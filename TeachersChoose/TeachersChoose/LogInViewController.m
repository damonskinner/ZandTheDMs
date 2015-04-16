//
//  LogInViewController.m
//  TeachersChoose
//
//  Created by Cooper Veysey on 4/1/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "LogInViewController.h"
#import "UIColor+DonorsChooseColors.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Icon-76"]];
    logoImageView.contentMode = UIViewContentModeScaleAspectFill;
    logoImageView.frame=self.logInView.bounds;
    
    [self.logInView setLogo:logoImageView];
    [self.logInView setBackgroundColor:[UIColor whiteColor]];
    

    // Set buttons appearance
    
    
    
    
    // Do any additional setup after loading the view.
    // Remove text shadow
    CALayer *layer = self.logInView.usernameField.layer;
    layer.shadowOpacity = 0.0;
    layer = self.logInView.passwordField.layer;
    layer.shadowOpacity = 0.0;
    
    // Set field text color
    [self.logInView.usernameField setTextColor:[UIColor colorWithRed:135.0f/255.0f green:118.0f/255.0f blue:92.0f/255.0f alpha:1.0]];
    [self.logInView.passwordField setTextColor:[UIColor colorWithRed:135.0f/255.0f green:118.0f/255.0f blue:92.0f/255.0f alpha:1.0]];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
