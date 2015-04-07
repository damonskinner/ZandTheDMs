//
//  StatDetailsViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/3/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "StatDetailsViewController.h"
#import "DetailsTabBarController.h"
#import "FISDonorsChooseProposal.h"

@interface StatDetailsViewController ()

@end

@implementation StatDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.view removeConstraints:self.view.constraints];
    self.view.translatesAutoresizingMaskIntoConstraints = NO;

    self.view.backgroundColor = [UIColor clearColor];
    

    self.proposal=((DetailsTabBarController*)self.tabBarController).selectedProposal;
    self.view.backgroundColor = [UIColor greenColor];
    
}

-(void)viewWillAppear:(BOOL)animated
{

    
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
