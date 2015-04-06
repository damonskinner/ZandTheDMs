//
//  DetailsTabBarController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/3/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "DetailsTabBarController.h"

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

    // make tab bar items
    fakeHome.tabBarItem       = [[UITabBarItem alloc] initWithTabBarSystemItem: UITabBarSystemItemSearch tag: 0];
    statsVC.tabBarItem        = [[UITabBarItem alloc] initWithTabBarSystemItem: UITabBarSystemItemSearch tag:0];
    commentsTVC.tabBarItem    = [[UITabBarItem alloc] initWithTabBarSystemItem: UITabBarSystemItemContacts tag:1];
    donorsTVC.tabBarItem      = [[UITabBarItem alloc] initWithTabBarSystemItem: UITabBarSystemItemMore tag:2];
    photoManagerVC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem: UITabBarSystemItemDownloads tag:3];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
