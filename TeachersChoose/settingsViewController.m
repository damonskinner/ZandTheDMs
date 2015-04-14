//
//  SettingsViewController.m
//  TeachersChoose
//
//  Created by Ian Smith on 4/13/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (strong, nonatomic) UIButton *resetDatabaseTapped;
@property (strong, nonatomic) UIButton *logoutTapped;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buttonSetup];
    [self.view removeConstraints:[self.view constraints]];

    for (UIView *view in self.view.subviews) {
        [view removeConstraints:[view constraints]];
        [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    };
    
    

    NSDictionary *views = @{@"resetDatabaseButton" : self.resetDatabaseTapped};

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *) resetDatabaseTapped {
    return nil;
}

- (UIButton *) logoutTapped {
    return nil;
}

@end
