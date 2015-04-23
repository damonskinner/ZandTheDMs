//
//  ContainerViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/15/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "ContainerViewController.h"
#import "UIColor+DonorsChooseColors.h"
#import "UIFont+DonorsChooseFonts.h"
#import <FAKIonIcons.h>

static const float TOTAL_VIEW_CONTROLLERS = 4.0;

@interface ContainerViewController () <UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) UINavigationController *navController;

- (void)formatNavBar;

@end

@implementation ContainerViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor DonorsChooseOrange];
	self.myProgressView.progressTintColor = [UIColor DonorsChooseGreen];
	self.myProgressView.trackTintColor = [UIColor DonorsChooseGreyLight];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	self.navController = segue.destinationViewController;
	self.navController.delegate = self;
	[self formatNavBar];
}

#pragma mark - UINavigationController delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
	NSInteger currentNumberOfControllers = [navigationController.viewControllers count] - 1;
	[self.myProgressView setProgress:(currentNumberOfControllers / TOTAL_VIEW_CONTROLLERS) animated:YES];
}

#pragma mark - Helpers

- (void)formatNavBar {
	[self.navController.navigationBar setTranslucent:NO];
	[self.navController.navigationBar setBarTintColor:[UIColor DonorsChooseOrange]];
	[self.navController.navigationBar setTitleTextAttributes:@{                                                                    NSForegroundColorAttributeName : [UIColor DonorsChooseGreyVeryLight], NSFontAttributeName:[UIFont fontWithName:DonorsChooseTitleBoldFont size:20] }];
}

- (void)homeButtonTapped {
}

@end
