//
//  ViewController.m
//  RemoteApp
//
//  Created by Ian Smith on 4/15/15.
//  Copyright (c) 2015 Ian Smith. All rights reserved.
//

#import "ViewController.h"
#import "FISParseAPI.h"

@interface ViewController ()
- (IBAction)createDonationTapped:(id)sender;
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
    [FISParseAPI createDonationWithName:self.name.text withDonorLocation:self.location.text donorMessage:self.message.text responseMessage:@"" donationAmount:self.amount.text andCompletionBlock:^(NSDictionary *response) {
        NSLog(@"%@",response);
    }];
}
@end
