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
	logoImageView.frame = self.logInView.bounds;

	[self.logInView setLogo:logoImageView];
	[self.logInView setBackgroundColor:[UIColor whiteColor]];

	self.logInView.dismissButton.hidden = YES;

	CALayer *layer = self.logInView.usernameField.layer;
	layer.shadowOpacity = 0.0;
	layer = self.logInView.passwordField.layer;
	layer.shadowOpacity = 0.0;

	[self.logInView.usernameField setTextColor:[UIColor colorWithRed:135.0f / 255.0f green:118.0f / 255.0f blue:92.0f / 255.0f alpha:1.0]];
	[self.logInView.passwordField setTextColor:[UIColor colorWithRed:135.0f / 255.0f green:118.0f / 255.0f blue:92.0f / 255.0f alpha:1.0]];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
