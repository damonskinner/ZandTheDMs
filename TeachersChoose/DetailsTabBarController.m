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
#import "DonorsTableViewController.h"
#import "CommentsViewController.h"
#import "UIColor+DonorsChooseColors.h"
#import "UIFont+DonorsChooseFonts.h"

@interface DetailsTabBarController ()
-(UINavigationController*) makeCommentsTVCwithNavController;
-(DonorsTableViewController*) makeDonorsTVC;
@end

@implementation DetailsTabBarController

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];

    UINavigationController *commentsNav = [self makeCommentsTVCwithNavController];
    DonorsTableViewController *donorsTVC = [self makeDonorsTVC];
    self.viewControllers = @[commentsNav, donorsTVC];
    self.tabBar.tintColor = [UIColor DonorsChooseOrange];
}

#pragma mark - VC Creation Helpers

-(UINavigationController*) makeCommentsTVCwithNavController
{
    CommentsViewController *commentsTVC   = [[CommentsViewController alloc] init];
    
    UIImage *commentsImage = [[FAKIonIcons chatboxesIconWithSize:30] imageWithSize:CGSizeMake(30, 30)];
    commentsTVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Comments" image:commentsImage tag:1];
    
    // make nav controller just for comments to have a header
    UINavigationController *commentsNav = [[UINavigationController alloc] init];
    [commentsNav addChildViewController: commentsTVC];
    
    return commentsNav;
}

-(DonorsTableViewController*) makeDonorsTVC
{
    DonorsTableViewController *donorsTVC = [[DonorsTableViewController alloc] init];
    
    UIImage *donorsImage = [[FAKIonIcons cashIconWithSize:30] imageWithSize:CGSizeMake(30, 30)];
    
    donorsTVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Donors" image:donorsImage  tag:0];
    
    [donorsTVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor DonorsChooseOrange]} forState:UIControlStateSelected];

    return donorsTVC;
}

@end
