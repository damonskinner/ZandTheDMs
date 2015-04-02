//
//  ViewController.m
//  TeachersChoose
//
//  Created by Damon Skinner on 4/1/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import "LogInViewController.h"
#import "SignUpViewController.h"
#import "FISDonorsChooseProposal.h"
#import <AFNetworking.h>


@interface ViewController () <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datastore=[FISDonorsChooseDatastore sharedDataStore];
    
    
    [self.view removeConstraints:self.view.constraints];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Create the sign up view controller
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
}

- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    
    PFUser *currentUser = user;

    [self.datastore getSearchResultsWithParams:nil andCompletion:^(BOOL completion) {

        NSString *currentTeacherId = currentUser[@"teacherId"];
        NSLog(@"%@", currentTeacherId);

    }];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    PFUser *currentUser = user;
    NSDictionary *params = @{@"location":@"NY",@"max":@"50"};
    [self.datastore getSearchResultsWithParams:params andCompletion:^(BOOL completion) {
        
        NSUInteger r=arc4random_uniform(50);
        FISDonorsChooseProposal *randomProposal = self.datastore.donorsChooseSearchResults[r];
        
        [self.datastore getSearchResultsWithTeacherId:randomProposal.teacherId andCompletion:^(BOOL completion) {
            
            FISDonorsChooseProposal *sampleProposalFromRandomTeacher = self.datastore.loggedInTeacherProposals[0];
            
            NSLog(@"%@",sampleProposalFromRandomTeacher.teacherId);
            
            
            NSString *donorsChooseURLString = [NSString stringWithFormat:@"https://api.parse.com/1/users/%@",currentUser.objectId];
            
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            
            NSDictionary *params = @{@"teacherId":sampleProposalFromRandomTeacher.teacherId};
            
            
            manager.requestSerializer=[[AFJSONRequestSerializer alloc] init];
            
            [manager.requestSerializer setValue:@"2EvZdDTprhbwbQ1Saz6Lz7YZ54qAKuFqv2j57Ezj" forHTTPHeaderField:@"X-Parse-Application-Id"];
            [manager.requestSerializer setValue:@"XScYXImf4BFkIRWGY5Xt61LfKQoC6JGSUWB5N3Un" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
            
            [manager.requestSerializer setValue:currentUser.sessionToken forHTTPHeaderField:@"X-Parse-Session-Token"];
            
            
            manager.securityPolicy.allowInvalidCertificates = YES;
            
            [manager PUT:donorsChooseURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
                
                
                //        completionBlock(responseObject[@"results"]);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"Fail: %@",error.localizedDescription);
            }];
            
            
            
        }];
    }];
    
    [self dismissModalViewControllerAnimated:YES]; // Dismiss the PFSignUpViewController
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
