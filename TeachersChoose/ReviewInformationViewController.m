//
//  ReviewInformationViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/19/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "ReviewInformationViewController.h"
#import "FISDonorsChooseDatastore.h"
#import "FISDonorsChooseTeacher.h"
#import "ContainerViewController.h"
#import <FAKIonIcons.h>

@interface ReviewInformationViewController ()

@property (weak, nonatomic) IBOutlet UIButton *completeMyProjectButton;
@property (weak, nonatomic) IBOutlet UILabel *teacherNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *specialInstructionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolCityStateZipLabel;
@property (weak, nonatomic) IBOutlet UILabel *thankyouDueDateLabel;

@property (strong, nonatomic) FISDonorsChooseDatastore *dataStore;
@property (strong, nonatomic) FISDonorsChooseTeacher *teacher;
@property (strong, nonatomic) FISDonorsChooseProposal *proposal;

@end

@implementation ReviewInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.completeMyProjectButton.layer.cornerRadius = 10;
    [self setupHomeButton];
    self.dataStore = [FISDonorsChooseDatastore sharedDataStore];
    self.teacher = self.dataStore.loggedInTeacher;
    self.proposal = ((ContainerViewController*)self.parentViewController.parentViewController).proposal;
}

-(void)setTeacher:(FISDonorsChooseTeacher *)teacher
{
    self.teacherNameLabel.text = teacher.name;
    self.schoolNameLabel.text = teacher.schoolName;
    self.schoolAddressLabel.text = @"2101 N Indiana Ave";
    self.schoolCityStateZipLabel.text = @"Los Angeles, CA 90032";
    self.specialInstructionsLabel =  self.proposal.completionInfo[@"specialInstructions"];
}


-(void) presentAreYouSureAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are You Sure?" message:@"Once submitted, this information may not be edited." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *submitAction = [UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {

        //TODO: add API call to save completionInfo
        self.proposal.completionInfo[@"fundingConfirmed"] = @"YES";

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
}

#pragma mark - Home Button

-(void) setupHomeButton
{
    UIImage *homeIcon = [[FAKIonIcons iosHomeIconWithSize:30] imageWithSize:CGSizeMake(30, 30)];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:homeIcon style:UIBarButtonItemStylePlain target:self action:@selector(homeButtonTapped)]];
}

-(void) homeButtonTapped
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Return To Dashboard" message:@"Your progress from this page will not be saved." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
