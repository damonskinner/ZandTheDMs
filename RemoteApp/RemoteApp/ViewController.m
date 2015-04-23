//
//  ViewController.m
//  RemoteApp
//
//  Created by Ian Smith on 4/15/15.
//  Copyright (c) 2015 Ian Smith. All rights reserved.
//

#import "ViewController.h"
#import "FISParseAPI.h"
#import "ParsePopulateDonations.h"
#import "FISDonation.h"
#import "FISDonorsChooseProposal.h"
#import "FISDonorsChooseAPI.h"


@interface ViewController () <UITextFieldDelegate>

- (IBAction)resetDBTapped:(id)sender;
- (IBAction)createDonationTapped:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *projectId;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *message;
@property (strong, nonatomic) IBOutlet UITextField *location;
@property (strong, nonatomic) IBOutlet UITextField *amount;

@property (strong, nonatomic) IBOutlet UIButton *createDonationButton;
@property (strong, nonatomic) IBOutlet UIButton *resetDbButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.createDonationButton.enabled = NO;
    self.resetDbButton.enabled = NO;
    
    self.projectId.delegate = self;
    self.name.delegate = self;
    self.message.delegate = self;
    self.location.delegate = self;
    self.amount.delegate = self;
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField  {
    
    
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSInteger projectIdLength = 7;
    if ((self.projectId.text.length == projectIdLength) && (self.name.text.length > 0) && (self.message.text.length > 0) && (self.location.text.length > 0) && (self.amount.text.length > 0)) {
        self.createDonationButton.enabled = YES;
    } else {
        self.createDonationButton.enabled = NO;
    }
    
    if (self.projectId.text.length == projectIdLength) {
        self.resetDbButton.enabled = YES;
    } else {
        self.resetDbButton.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createDonationTapped:(id)sender {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Notification Sent"
                                                                   message:@"Your notification was successfully sent."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                          }];
    [alert addAction:defaultAction];
    
    
    [FISParseAPI getProposalObjectProposalId:self.projectId.text andCompletionBlock:^(NSDictionary *parseProposalDict) {
        [FISParseAPI createDonationForProposalObjectId:parseProposalDict[@"objectId"] withName:self.name.text withDonorLocation:self.location.text donorMessage:self.message.text responseMessage:@"" donationAmount:self.amount.text andCompletionBlock:^(NSDictionary *responseObject) {
            [FISParseAPI addDonationObjectId:responseObject[@"objectId"] toProposalWithObjectId:parseProposalDict[@"objectId"] andCompletionBlock:^{
                
                if ([self.projectId.text isEqualToString: @"9999999"]) {
                    [FISParseAPI getTeacherIdForProposalObjectId:parseProposalDict[@"objectId"] andCompletionBlock:^(NSString * teacherId) {
                        NSInteger newTotal = [parseProposalDict[@"totalDonated"] integerValue] + [self.amount.text integerValue];
                        if (newTotal >= [parseProposalDict[@"totalPrice"] integerValue]) {
                            
                            [FISParseAPI sendFinishedPushNotificationToTeacherId:teacherId withProposalTitle:@"Almost There!" andCompletionBlock:^{
                                [self presentViewController:alert animated:YES completion:nil];
                            }];
                        } else {
                            [FISParseAPI sendPushNotificationToTeacherId: teacherId withProposalTitle:@"Almost There!" andCompletionBlock:^{
                                [self presentViewController:alert animated:YES completion:nil];
                            }];
                        }
                    }];
                } else {
                    [FISDonorsChooseAPI getTeacherIdForProposalId:self.projectId.text andCompletionBlock:^(NSDictionary * proposalDict) {
                        NSInteger newTotal = [parseProposalDict[@"totalDonated"] integerValue] + [self.amount.text integerValue];
                        if (newTotal >= [parseProposalDict[@"totalPrice"] integerValue]) {
                            
                            [FISParseAPI sendFinishedPushNotificationToTeacherId:proposalDict[@"teacherId"] withProposalTitle:proposalDict[@"title"] andCompletionBlock:^{
                                [self presentViewController:alert animated:YES completion:nil];
                            }];
                        } else {
                            [FISParseAPI sendPushNotificationToTeacherId: proposalDict[@"teacherId"] withProposalTitle:proposalDict[@"title"] andCompletionBlock:^{
                                [self presentViewController:alert animated:YES completion:nil];
                            }];
                        }
                    }];
                }
            }];
        }];
        
        
    }];
}

- (IBAction)resetDBTapped:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Delete Confirmation"
                                                                   message:@"Are you really really sure you want to clear the database??"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [FISParseAPI getProposalObjectIdForProposalId:self.projectId.text andCompletionBlock:^(NSString *objectId) {
                                                                  
                                                                  [FISParseAPI getDonationsListForProposalWithId:objectId andCompletionBlock:^(NSArray *donationDictionaries) {

                                                                      for (NSDictionary *eachDonation in donationDictionaries) {

                                                                          [FISParseAPI removeDonationObjectId:eachDonation[@"objectId"] fromProposalWithObjectId:objectId andCompletionBlock:^{
                                                                              [FISParseAPI deleteDonationWithObjectId:eachDonation[@"objectId"] andCompletionBlock:^{
;
                                                                              }];
                                                                          }];
                                                                      }
                                                                      [ParsePopulateDonations populateDonationsForProposalWithObjectId:objectId andproposalId:self.projectId.text];
                                                                  }];
                                                              }];
                                                          }];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self dismissViewControllerAnimated:alert completion:nil];
                                                          }];
    
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
