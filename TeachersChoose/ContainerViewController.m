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

static const float totalNumberOfViewControllers = 5.0;

@interface ContainerViewController () <UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) UINavigationController *navController;
@property (weak, nonatomic) IBOutlet UIProgressView *myProgressView;
@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor DonorsChooseOrange];
    self.myProgressView.progressTintColor = [UIColor DonorsChooseOrange];
}

#pragma mark - Navigation

// THIS IS HOW WE GET THE NAVIGATION CONTROLLER
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"SOURCE: %@", segue.sourceViewController);
    NSLog(@"DESTINATION: %@", segue.destinationViewController);

    self.navController = segue.destinationViewController;
    self.navController.delegate = self;
    [self.navController.navigationBar setTranslucent: NO];
    [self.navController.navigationBar setBarTintColor: [UIColor DonorsChooseOrange]];
    [self.navController.navigationBar setTitleTextAttributes:@{                                                                    NSForegroundColorAttributeName : [UIColor DonorsChooseGreyVeryLight],NSFontAttributeName:[UIFont fontWithName:DonorsChooseTitleBoldFont size:25]}];
}

#pragma mark - UINavigationController delegate

// THIS IS HOW WE UPDATE THE PROGRESS BAR
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSInteger currentNumberOfControllers = [navigationController.viewControllers count];
    [self.myProgressView setProgress:(currentNumberOfControllers/totalNumberOfViewControllers) animated:YES];
    
    NSLog(@"DID SHOW");
    NSLog(@"STACK COUNT: %ld", [navigationController.viewControllers count]);
}

@end
