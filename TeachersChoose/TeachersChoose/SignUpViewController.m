//
//  SignUpViewController.m
//  TeachersChoose
//
//  Created by Cooper Veysey on 4/1/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Icon-76"]];
    logoImageView.contentMode = UIViewContentModeScaleAspectFill;
    logoImageView.frame=self.signUpView.bounds;
    
    [self.signUpView setLogo:logoImageView];
    [self.signUpView setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
