//
//  PhotoManagerViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/1/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "PhotoManagerViewController.h"
#import "CompletionImageCollectionViewCell.h"
#import "PhotoManagerView.h"

@interface PhotoManagerViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) PhotoManagerView *photoManagerView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic) NSInteger selectedItem; // for updating cells in collection

@end

@implementation PhotoManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // make a new photomanagerview and add it as a subview
//    self.photoManagerView = [[PhotoManagerView alloc] init];
//    [self.view addSubview: self.photoManagerView];
//    
//    // remove constraint
//    self.photoManagerView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.view removeConstraints: self.view.constraints];
//    
//    // constrain photomanagerView to self.view
//    NSDictionary *views = @{@"pmv": self.photoManagerView};
//
//    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-44-[pmv]-44-|" options:0 metrics:nil views: views];
//    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[pmv]|" options:0 metrics:nil views:views];
//    
//    [self.view addConstraints: verticalConstraints];
//    [self.view addConstraints: horizontalConstraints];
//    [self.view layoutIfNeeded];
    
    [self initialSetup];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void) initialSetup
{
    // make sure we dont break the collection view
    if (self.completionPictures == nil)
    {
        self.completionPictures = [[NSMutableArray alloc] init];
    }
    
    // fill the collection view with any necessary placeholders
    while ([self.completionPictures count] < 6)
    {
        [self.completionPictures addObject: [UIImage imageNamed:@"tapHereIcon"]];
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
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected item: %ld", indexPath.row);
    self.selectedItem = indexPath.row;
    [self presentPhotoActionSheet];
}


#pragma mark - UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"image Chosen");
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.completionPictures[self.selectedItem] = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.collectionView reloadData];
    }];
}

#pragma mark - AlertController (action sheet)

-(void) presentPhotoActionSheet
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add Photos" message:@"Select photos that you'd like to share on DonorsChoose.org upon completion of your project." preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];

    UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"take photo chosen");
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:nil];
    }];
    
    UIAlertAction *choosePhoto = [UIAlertAction actionWithTitle:@"Choose Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"choose photo chosen");
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:nil];
    }];
    
    [alertController addAction: cancel];
    [alertController addAction: takePhoto];
    [alertController addAction: choosePhoto];

    [self presentViewController: alertController animated: YES completion:nil];
}


@end
