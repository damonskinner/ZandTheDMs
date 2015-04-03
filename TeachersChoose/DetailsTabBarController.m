//
//  DetailsTabBarController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/3/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "DetailsTabBarController.h"

// child VCs
#import "CommentsTableViewController.h"
#import "PhotoManagerViewController.h"


@interface DetailsTabBarController ()

@end

@implementation DetailsTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // make child view controllers
    CommentsTableViewController *commentsTVC = [[CommentsTableViewController alloc] init];
    PhotoManagerViewController *photoManagerVC = [[UIStoryboard storyboardWithName:@"CameraTest" bundle:nil] instantiateViewControllerWithIdentifier:@"photoManager"];
    
//    PhotoManagerViewController *photoManagerVC = [[PhotoManagerViewController alloc] init];
    
    // make tab bar items
    commentsTVC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:0];
    photoManagerVC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem: UITabBarSystemItemDownloads tag:1];
    
    // add them to self.viewControllers
    self.viewControllers = @[commentsTVC, photoManagerVC];
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
