//
//  settingsViewController.m
//  TeachersChoose
//
//  Created by Ian Smith on 4/13/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "settingsViewController.h"

@interface settingsViewController ()

@end

@implementation settingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view removeConstraints:[self.view constraints]];
    
    for (UIView *view in self.view.subviews) {
        [view removeConstraints:[view constraints]];
        [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    
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
