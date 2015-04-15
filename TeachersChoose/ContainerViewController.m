//
//  ContainerViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/15/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "ContainerViewController.h"

@interface ContainerViewController () <UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) UINavigationController *navController;
@property (weak, nonatomic) IBOutlet UIProgressView *myProgressView;
@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Navigation

// THIS IS HOW WE GET THE NAVIGATION CONTROLLER
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"SOURCE: %@", segue.sourceViewController);
    NSLog(@"DESTINATION: %@", segue.destinationViewController);

    self.navController = segue.destinationViewController;
    self.navController.delegate = self;
}

#pragma mark - UINavigationController delegate

// THIS IS HOW WE UPDATE THE PROGRESS BAR
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    float totalNumberOfControllers = 6.0; // MAGIC NUMBER
    NSInteger currentNumberOfControllers = [navigationController.viewControllers count];
    [self.myProgressView setProgress:(currentNumberOfControllers/totalNumberOfControllers) animated:YES];
    
    NSLog(@"DID SHOW");
    NSLog(@"STACK COUNT: %ld", [navigationController.viewControllers count]);
}

@end
