//
//  PhotoManagerViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/1/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "PhotoManagerViewController.h"
#import "CompletionImageCollectionViewCell.h"
#import <FAKIonIcons.h>

@interface PhotoManagerViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic) NSInteger selectedRow;
@property (nonatomic) UIImage *cameraImage;

@end

@implementation PhotoManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialSetup];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void) initialSetup
{
    self.cameraImage = [[FAKIonIcons iosCameraIconWithSize:120] imageWithSize:CGSizeMake(120, 120)];;
    
    // make sure we dont break the collection view with an empty array
    if (self.completionPictures == nil)
    {
        self.completionPictures = [[NSMutableArray alloc] init];
    }
    
    // fill the collection view with any necessary placeholders
    while ([self.completionPictures count] < 6)
    {
        [self.completionPictures addObject: self.cameraImage];
    }
    
    // setup collectionView
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

#pragma mark - UICollectionView Delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.completionPictures count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CompletionImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    
    // assign the corresponding picture
    cell.imageView.image = self.completionPictures[indexPath.row];
    
    // check whether to hide the label or not
    if (cell.imageView.image != self.cameraImage)
    {
        cell.tapMeLabel.hidden = YES;
    }
    else
    {
        cell.tapMeLabel.hidden = NO;
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected item: %ld", indexPath.row);
    self.selectedRow = indexPath.row;
    [self presentPhotoActionSheet];
}

#pragma mark - UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"image chosen");
    NSLog(@"%@", info);
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.completionPictures[self.selectedRow] = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.collectionView reloadData];
    }];
}

#pragma mark - AlertController (action sheet)

-(void) presentPhotoActionSheet
{
    // setup picker first
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add Photos" message:@"Select photos that you'd like to share on DonorsChoose.org upon completion of your project." preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];

    UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    {
        NSLog(@"take photo chosen");
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }];
    
    UIAlertAction *choosePhoto = [UIAlertAction actionWithTitle:@"Choose Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    {
        NSLog(@"choose photo chosen");
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }];
    
    UIAlertAction *removePhoto = [UIAlertAction actionWithTitle:@"Remove Photo" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action)
    {
        NSLog(@"remove photo chosen");
        [self.completionPictures removeObjectAtIndex: self.selectedRow];
        [self.completionPictures insertObject: self.cameraImage atIndex:self.selectedRow];
        [self.collectionView reloadData];
    }];
    
    
    [alertController addAction: takePhoto];
    [alertController addAction: choosePhoto];
    [alertController addAction: removePhoto];
    [alertController addAction: cancel];
    
    [self presentViewController: alertController animated: YES completion:nil];
}


@end
