//
//  PhotoManagerViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/1/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "PhotoManagerViewController.h"
#import "CompletionImageCollectionViewCell.h"
#import "UIColor+DonorsChooseColors.h"
#import "FISDonorsChooseDatastore.h"
#import <FAKIonIcons.h>
#import <MBProgressHUD.h>

@interface PhotoManagerViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSInteger selectedRow;
@property (nonatomic) UIImage *cameraImage;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;
@property (strong, nonatomic) FISDonorsChooseDatastore *dataStore;
@property (strong, nonatomic) NSMutableArray *completionPictures;

- (void)setupCompletionPicturesArray;
- (void)presentPhotoActionSheet;

@end

@implementation PhotoManagerViewController

#pragma mark - View LifeCycle


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.dataStore = [FISDonorsChooseDatastore sharedDataStore];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    FAKIonIcons *cameraIcon = [FAKIonIcons iosCameraOutlineIconWithSize:100];
    [cameraIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
    
    self.cameraImage = [cameraIcon imageWithSize:CGSizeMake(100, 100)];
    self.uploadButton.layer.cornerRadius = 10;
    self.uploadButton.backgroundColor = [UIColor DonorsChooseGreen];
    [self setupCompletionPicturesArray];

}

#pragma mark - UICollectionView Delegate
- (IBAction)uploadButtonTapped:(id)sender {

    NSLog(@"uploadTapped");
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // SAVE IT TO THE DATASTORE HERE
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return [self.completionPictures count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CompletionImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    
    cell.imageView.image = self.completionPictures[indexPath.row];
    cell.backgroundColor = [UIColor DonorsChooseOrange];
    cell.layer.cornerRadius = 10;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	self.selectedRow = indexPath.row;
	[self presentPhotoActionSheet];
}

#pragma mark - UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
	self.completionPictures[self.selectedRow] = chosenImage;
	[picker dismissViewControllerAnimated:YES completion: ^{
	    [self.collectionView reloadData];
	}];
}

#pragma mark - Helpers

- (void)setupCompletionPicturesArray {
	if (self.completionPictures == nil) {
		self.completionPictures = [[NSMutableArray alloc] init];
	}

	// fill the collection view with any necessary placeholders
	while ([self.completionPictures count] < 6) {
		[self.completionPictures addObject:self.cameraImage];
	}
}

- (void)presentPhotoActionSheet {
	// setup picker first
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	picker.allowsEditing = YES;

	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

	UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];

	UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler: ^(UIAlertAction *action)
	{
	    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	    [self presentViewController:picker animated:YES completion:nil];
	}];

	UIAlertAction *choosePhoto = [UIAlertAction actionWithTitle:@"Choose Photo" style:UIAlertActionStyleDefault handler: ^(UIAlertAction *action)
	{
	    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	    [self presentViewController:picker animated:YES completion:nil];
	}];

	[alertController addAction:takePhoto];
	[alertController addAction:choosePhoto];

	if (self.completionPictures[self.selectedRow] != self.cameraImage) {
		UIAlertAction *removePhoto = [UIAlertAction actionWithTitle:@"Remove Photo" style:UIAlertActionStyleDestructive handler: ^(UIAlertAction *action)
		{
		    [self.completionPictures removeObjectAtIndex:self.selectedRow];
		    [self.completionPictures insertObject:self.cameraImage atIndex:self.selectedRow];
		    [self.collectionView reloadData];
		}];
		[alertController addAction:removePhoto];
	}

	[alertController addAction:cancel];

	[self presentViewController:alertController animated:YES completion:nil];
}

@end
