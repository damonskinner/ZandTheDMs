//
//  DetailsTabBarController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/3/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "DetailsTabBarController.h"
#import <FAKIonIcons.h>

// child VCs
#import "StatDetailsViewController.h"
#import "CommentsTableViewController.h"
#import "UIColor+DonorsChooseColors.h"
#import "UIFont+DonorsChooseFonts.h"

@interface DetailsTabBarController ()

@end

@implementation DetailsTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // make child view controllers
    StatDetailsViewController *statsVC         = [[StatDetailsViewController alloc] init];
    CommentsTableViewController *commentsTVC   = [[CommentsTableViewController alloc] init];

    // make icons / tabBarItems

    UIImage *statsImage = [[FAKIonIcons iosPulseStrongIconWithSize:30] imageWithSize:CGSizeMake(30, 30)];
    statsVC.tabBarItem        = [[UITabBarItem alloc] initWithTitle:@"Stats" image:statsImage  tag:0];
    
    UIImage *commentsImage = [[FAKIonIcons chatboxesIconWithSize:30] imageWithSize:CGSizeMake(30, 30)];
    commentsTVC.tabBarItem    = [[UITabBarItem alloc] initWithTitle:@"Comments" image:commentsImage tag:1];
    
    // make nav controllers
    UINavigationController *statsNav    = [[UINavigationController alloc] init];
    
    UINavigationController *commentsNav = [[UINavigationController alloc] init];
    
    // add their respective children
    [statsNav addChildViewController: statsVC];
    [commentsNav addChildViewController: commentsTVC];
    
    // add them to self.viewControllers
    self.viewControllers = @[statsNav, commentsNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
