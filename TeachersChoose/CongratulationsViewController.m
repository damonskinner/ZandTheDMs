//
//  CongratulationsViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/19/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "CongratulationsViewController.h"
#import "UIColor+DonorsChooseColors.h"
#import <FAKIonIcons.h>


@interface CongratulationsViewController ()

@property (weak, nonatomic) IBOutlet UIButton *impactLetterButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraAccessButton;
@property (weak, nonatomic) IBOutlet UIButton *printLabelButton;

@end

@implementation CongratulationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    [self setupThankYouPackageButtons];
    [self setupHomeButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupThankYouPackageButtons
{
    FAKIonIcons *letterIcon = [FAKIonIcons iosEmailOutlineIconWithSize:50];
    [self.impactLetterButton setAttributedTitle:[letterIcon attributedString] forState:UIControlStateNormal];
    [self.impactLetterButton setBackgroundColor: [UIColor DonorsChooseOrange]];
    self.impactLetterButton.layer.cornerRadius = 10;

    FAKIonIcons *cameraIcon = [FAKIonIcons iosCameraOutlineIconWithSize:50];
    [self.cameraAccessButton setAttributedTitle:[cameraIcon attributedString] forState:UIControlStateNormal];
    [self.cameraAccessButton setBackgroundColor: [UIColor DonorsChooseOrange]];
    self.cameraAccessButton.layer.cornerRadius = 10;
    
    FAKIonIcons *printIcon = [FAKIonIcons iosPrinterOutlineIconWithSize:50];
    [self.printLabelButton setAttributedTitle:[printIcon attributedString] forState:UIControlStateNormal];
    [self.printLabelButton setBackgroundColor: [UIColor DonorsChooseOrange]];
    self.printLabelButton.layer.cornerRadius = 10;
}

#pragma mark - Home Button

-(void) setupHomeButton
{
    UIImage *homeIcon = [[FAKIonIcons iosHomeIconWithSize:30] imageWithSize:CGSizeMake(30, 30)];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:homeIcon style:UIBarButtonItemStylePlain target:self action:@selector(homeButtonTapped)]];
}

-(void) homeButtonTapped
{
    [self dismissViewControllerAnimated:YES completion:nil];
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