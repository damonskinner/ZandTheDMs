//
//  CongratulationsViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/19/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "CongratulationsViewController.h"
#import "UIColor+DonorsChooseColors.h"
#import "UIFont+DonorsChooseFonts.h"
#import <FAKIonIcons.h>
#import "FISDonorsChooseDatastore.h"
#import "ContainerViewController.h"
#import "PhotoManagerViewController.h"
#import "ImpactLetterViewController.h"

@interface CongratulationsViewController ()

@property (weak, nonatomic) IBOutlet UIButton *impactLetterButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraAccessButton;
@property (weak, nonatomic) IBOutlet UIButton *printLabelButton;

@end

@implementation CongratulationsViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    [self formatNavBar];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    [self setupThankYouPackageButtons];
    [self setupHomeButton];
    
}

-(FISDonorsChooseProposal *)proposal{
    if (!_proposal)
    {
        return ((ContainerViewController*)self.parentViewController.parentViewController).proposal;
    }
    return _proposal;
}

-(void) formatNavBar
{
    [self.navigationController.navigationBar setTranslucent: NO];
    [self.navigationController.navigationBar setBarTintColor: [UIColor DonorsChooseOrange]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{                                                                    NSForegroundColorAttributeName : [UIColor DonorsChooseGreyVeryLight],NSFontAttributeName:[UIFont fontWithName:DonorsChooseTitleBoldFont size:20]}];

}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)setupThankYouPackageButtons {
	FAKIonIcons *letterIcon = [FAKIonIcons iosEmailOutlineIconWithSize:62];
	[self.impactLetterButton setAttributedTitle:[letterIcon attributedString] forState:UIControlStateNormal];
	[self.impactLetterButton setBackgroundColor:[UIColor DonorsChooseOrange]];
	self.impactLetterButton.layer.cornerRadius = 10;

	FAKIonIcons *cameraIcon = [FAKIonIcons iosCameraOutlineIconWithSize:62];
	[self.cameraAccessButton setAttributedTitle:[cameraIcon attributedString] forState:UIControlStateNormal];
	[self.cameraAccessButton setBackgroundColor:[UIColor DonorsChooseOrange]];
	self.cameraAccessButton.layer.cornerRadius = 10;

	FAKIonIcons *printIcon = [FAKIonIcons iosPrinterOutlineIconWithSize:62];
	[self.printLabelButton setAttributedTitle:[printIcon attributedString] forState:UIControlStateNormal];
	[self.printLabelButton setBackgroundColor:[UIColor DonorsChooseOrange]];
	self.printLabelButton.layer.cornerRadius = 10;
}

#pragma mark - Home Button

- (void)setupHomeButton {
	UIImage *homeIcon = [[FAKIonIcons iosHomeIconWithSize:30] imageWithSize:CGSizeMake(30, 30)];
	[self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:homeIcon style:UIBarButtonItemStylePlain target:self action:@selector(homeButtonTapped)]];
}



#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    UIViewController *vc = [segue destinationViewController];
    
    if ([vc isKindOfClass:[ImpactLetterViewController class]])
    {
        ((ImpactLetterViewController*)vc).proposal = self.proposal;
    }
    else if([vc isKindOfClass:[PhotoManagerViewController class]])
    {
        ((PhotoManagerViewController*)vc).proposal = self.proposal;
    }
}


- (void)homeButtonTapped {
	[self dismissViewControllerAnimated:YES completion:nil];
}


@end
