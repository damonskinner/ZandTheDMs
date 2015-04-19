//
//  ReviewInformationViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/19/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "ReviewInformationViewController.h"

@interface ReviewInformationViewController ()

@property (weak, nonatomic) IBOutlet UIButton *completeMyProjectButton;
@property (weak, nonatomic) IBOutlet UILabel *teacherNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *specialInstructionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolCityStateZipLabel;
@property (weak, nonatomic) IBOutlet UILabel *thankyouDueDateLabel;

@end

@implementation ReviewInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.completeMyProjectButton.layer.cornerRadius = 10;
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
