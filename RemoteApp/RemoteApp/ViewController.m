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

@interface ViewController ()

- (IBAction)resetDBTapped:(id)sender;
- (IBAction)createDonationTapped:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *projectId;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *message;
@property (strong, nonatomic) IBOutlet UITextField *location;
@property (strong, nonatomic) IBOutlet UITextField *amount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createDonationTapped:(id)sender {
    [FISParseAPI getProposalObjectIdForProposalId:self.projectId.text andCompletionBlock:^(NSString *proposalObjectId) {
        [FISParseAPI createDonationForProposalObjectId:proposalObjectId withName:self.name.text withDonorLocation:self.location.text donorMessage:self.message.text responseMessage:@"" donationAmount:self.amount.text andCompletionBlock:^(NSDictionary *responseObject) {
            [FISParseAPI addDonationObjectId:responseObject[@"objectId"] toProposalWithObjectId:proposalObjectId andCompletionBlock:^{
                
            }];
        }];
    }];
    
    
    
    
    [FISParseAPI sendPushNotificationToEveryone];
}

- (IBAction)resetDBTapped:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Delete Confirmation"
                                                                   message:@"Are you really really sure you want to clear the database??"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [FISParseAPI getProposalObjectIdForProposalId:self.projectId.text andCompletionBlock:^(NSString *objectId) {
                                                                  
                                                                  [FISParseAPI getDonationsListForProposalWithId:objectId andCompletionBlock:^(NSArray *donationDictionaries) {
//                                                                      NSMutableArray *donationListToDelete = [[NSMutableArray alloc]init];
                                                                      for (NSDictionary *eachDonation in donationDictionaries) {
//                                                                          [donationListToDelete addObject:[FISDonation donationFromDictionary:eachDonation]];
                                                                          [FISParseAPI removeDonationObjectId:eachDonation[@"objectId"] fromProposalWithObjectId:objectId andCompletionBlock:^{
                                                                              [FISParseAPI deleteDonationWithObjectId:eachDonation[@"objectId"] andCompletionBlock:^{
                                                                                  [ParsePopulateDonations populateDonationsForProposalWithObjectId:objectId];
                                                                              }];
                                                                          }];
                                                                      }
                                                                      
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
