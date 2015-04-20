//
//  CongratulationsViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/19/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "CongratulationsViewController.h"
#import <FAKIonIcons.h>

@interface CongratulationsViewController ()


@end

@implementation CongratulationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    [self setupHomeButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dashboardButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)thankYouPackageButtonTapped:(id)sender {
    NSLog(@"thankyou");
}

#pragma mark - Home Button

-(void) setupHomeButton
{
    UIImage *homeIcon = [[FAKIonIcons homeIconWithSize:30] imageWithSize:CGSizeMake(30, 30)];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:homeIcon style:UIBarButtonItemStylePlain target:self action:@selector(homeButtonTapped)]];
}

-(void) homeButtonTapped
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
