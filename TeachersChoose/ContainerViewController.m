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

-(void)formatNavBar;

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor DonorsChooseOrange];
    self.myProgressView.progressTintColor = [UIColor DonorsChooseOrange];
    self.myProgressView.trackTintColor = [UIColor DonorsChooseGreyLight];
}

#pragma mark - Navigation

// get a reference to the embedded nav controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    NSLog(@"SOURCE: %@", segue.sourceViewController);
//    NSLog(@"DESTINATION: %@", segue.destinationViewController);

    self.navController = segue.destinationViewController;
    self.navController.delegate = self;
    [self formatNavBar];
}

#pragma mark - UINavigationController delegate

// update the progress bar everytime the nav controller pushes/pops a VC
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSInteger currentNumberOfControllers = [navigationController.viewControllers count]-1;
    [self.myProgressView setProgress:(currentNumberOfControllers/TOTAL_VIEW_CONTROLLERS) animated:YES];
    
    NSLog(@"STACK COUNT: %ld", [navigationController.viewControllers count]);
}

#pragma mark - Helpers

-(void) formatNavBar
{
    [self.navController.navigationBar setTranslucent: NO];
    [self.navController.navigationBar setBarTintColor: [UIColor DonorsChooseOrange]];
    [self.navController.navigationBar setTitleTextAttributes:@{                                                                    NSForegroundColorAttributeName : [UIColor DonorsChooseGreyVeryLight],NSFontAttributeName:[UIFont fontWithName:DonorsChooseTitleBoldFont size:20]}];
}

-(void) homeButtonTapped
{
    NSLog(@"home tapped");
}

@end
