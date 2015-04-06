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
#import "DonorsTableViewController.h"
#import "PhotoManagerViewController.h"

#import "FakeHomepageTableViewController.h"



@interface DetailsTabBarController ()

@end

@implementation DetailsTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // make child view controllers
    FakeHomepageTableViewController *fakeHome  = [[FakeHomepageTableViewController alloc] init];
    StatDetailsViewController *statsVC         = [[StatDetailsViewController alloc] init];
    CommentsTableViewController *commentsTVC   = [[CommentsTableViewController alloc] init];
    DonorsTableViewController *donorsTVC       = [[DonorsTableViewController alloc] init];
    PhotoManagerViewController *photoManagerVC = [[UIStoryboard storyboardWithName:@"CameraTest" bundle:nil] instantiateViewControllerWithIdentifier:@"photoManager"];
// ^^^^^^ currently using storyboard version, STAY AWARE OF THIS ************

    // make icons / tabBarItems
//    fakeHome.tabBarItem       = [[UITabBarItem alloc] initWithTabBarSystemItem: UITabBarSystemItemSearch tag: 0];
    UIImage *statsImage = [[FAKIonIcons iosPulseStrongIconWithSize:30] imageWithSize:CGSizeMake(30, 30)];
    statsVC.tabBarItem        = [[UITabBarItem alloc] initWithTitle:@"Stats" image:statsImage  tag:0];
    
    UIImage *commentsImage = [[FAKIonIcons chatboxesIconWithSize:30] imageWithSize:CGSizeMake(30, 30)];
    commentsTVC.tabBarItem    = [[UITabBarItem alloc] initWithTitle:@"Comments" image:commentsImage tag:1];
    
    UIImage *donorsImage = [[FAKIonIcons cashIconWithSize:35] imageWithSize:CGSizeMake(35, 35)];
    donorsTVC.tabBarItem      = [[UITabBarItem alloc] initWithTitle:@"Donors" image:donorsImage tag:2];
    
    UIImage *photosImage = [[FAKIonIcons imagesIconWithSize:35] imageWithSize:CGSizeMake(35, 35)];
    photoManagerVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Photos" image:photosImage tag:3];
    
    // make nav controllers
    UINavigationController *statsNav    = [[UINavigationController alloc] init];
    UINavigationController *commentsNav = [[UINavigationController alloc] init];
    UINavigationController *donorsNav   = [[UINavigationController alloc] init];
    UINavigationController *photoNav    = [[UINavigationController alloc] init];
    
    // add their respective children
    [statsNav addChildViewController: statsVC];
    [commentsNav addChildViewController: commentsTVC];
    [donorsNav addChildViewController: donorsTVC];
    [photoNav addChildViewController: photoManagerVC];
    
    // add them to self.viewControllers
//    self.viewControllers = @[statsVC, commentsTVC, donorsTVC, photoManagerVC];
    self.viewControllers = @[statsNav, commentsNav, donorsNav, photoNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
