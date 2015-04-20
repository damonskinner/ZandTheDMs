//
//  ReviewInformationViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/19/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "ReviewInformationViewController.h"
#import "ContainerViewController.h"

@interface ReviewInformationViewController ()

@property (weak, nonatomic) IBOutlet UIButton *completeMyProjectButton;
@property (weak, nonatomic) IBOutlet UILabel *teacherNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *specialInstructionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolCityStateZipLabel;
@property (weak, nonatomic) IBOutlet UILabel *thankyouDueDateLabel;

@end

@implementation ReviewInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.completeMyProjectButton.layer.cornerRadius = 10;
}

-(void) presentAreYouSureAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are You Sure?" message:@"Once submitted, this information may not be edited." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *submitAction = [UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"readyToSubmit");
        [self presentCongratulationsViewController];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:submitAction];

    [self presentViewController:alertController animated:YES completion:nil];
    NSLog(@"alertPresented");
}

- (IBAction)completeMyProjectTapped:(id)sender {
    [self presentAreYouSureAlert];
}

-(void) presentCongratulationsViewController
{
    UIViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"congratulationsVC"];
    [UIView animateWithDuration:0.5 animations:^{
        [((ContainerViewController*) self.navigationController.parentViewController).myProgressView setAlpha:0];
    }];
    [self.navigationController showViewController:nextVC sender:nil];
    
    
// for if and when we need to do some nav controller magic
//    ContainerViewController* containerVC = (ContainerViewController*)[self.navigationController parentViewController];
//    UINavigationController* originalNavController = (UINavigationController*)[containerVC parentViewController];
//    [originalNavController setNavigationBarHidden:NO animated:YES];
}

@end
