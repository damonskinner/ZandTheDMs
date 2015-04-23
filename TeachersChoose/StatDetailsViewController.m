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
#import "UIFont+DonorsChooseFonts.h"
#import "UIColor+DonorsChooseColors.h"
#import "CustomItemUIActivityItemProvider.h"
#import "DonorsTableViewController.h"

@interface StatDetailsViewController () <UIActivityItemSource>


@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *expirationDate;
@property (strong, nonatomic) UILabel *schoolName;
@property (strong, nonatomic) UILabel *fundingStatus;
@property (strong, nonatomic) UILabel *costToCompleteOfTotalWithPercent;
@property (strong, nonatomic) UILabel *numberOfDonations;
@property (strong, nonatomic) UILabel *location;

@property (strong, nonatomic) UIButton *shareButton;
@property (strong, nonatomic) UIButton *donorsListButton;

@end

@implementation StatDetailsViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	[self createAndAddSubviews];
	[self.view removeConstraints:[self.view constraints]];

	for (UIView *view in self.view.subviews) {
		[view removeConstraints:[view constraints]];
		[view setTranslatesAutoresizingMaskIntoConstraints:NO];
	}

	self.navigationController.navigationBarHidden = YES;
	self.view.backgroundColor = [UIColor whiteColor];

	self.proposal = ((DetailsTabBarController *)self.tabBarController).selectedProposal;

	NSDictionary *views = @{ @"titleLabel" : self.titleLabel,
		                     @"expirationDate" : self.expirationDate,
		                     @"schoolName" : self.schoolName,
		                     @"location" : self.location,
		                     @"fundingStatus" : self.fundingStatus,
		                     @"costToCompleteOfTotalWithPercent" : self.costToCompleteOfTotalWithPercent,
		                     @"numberOfDonations" : self.numberOfDonations,
		                     @"shareButton": self.shareButton,
		                     @"donorsListButton": self.donorsListButton };

	self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
	self.titleLabel.numberOfLines = 0;
	self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
	self.titleLabel.text = self.proposal.title;
	self.titleLabel.font = [UIFont fontWithName:DonorsChooseTitleBoldFont size:24];
	[self.titleLabel sizeToFit];
	self.titleLabel.textAlignment = NSTextAlignmentCenter;
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[titleLabel]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[titleLabel(100)]" options:0 metrics:nil views:views]];

	self.expirationDate.text = [NSString stringWithFormat:@"Exp. Date: %@", self.proposal.expirationDate];
	self.expirationDate.font = [UIFont fontWithName:DonorsChooseBodyBasicFont size:14];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-25-[expirationDate]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[location]-30-[expirationDate(30)]" options:0 metrics:nil views:views]];

	self.schoolName.text = [NSString stringWithFormat:@"%@", self.proposal.schoolName];
	self.schoolName.textAlignment = NSTextAlignmentCenter;
	self.schoolName.font = [UIFont fontWithName:DonorsChooseBodyBasicFont size:16];
	self.schoolName.textAlignment = NSTextAlignmentCenter;
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[schoolName]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[titleLabel][schoolName(15)]" options:0 metrics:nil views:views]];

	self.location.text = [NSString stringWithFormat:@"%@, %@ %@", self.proposal.city, self.proposal.state, self.proposal.zip];
	self.location.font = [UIFont fontWithName:DonorsChooseBodyBasicFont size:16];
	self.location.textAlignment = NSTextAlignmentCenter;
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[location]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[schoolName]-[location(20)]" options:0 metrics:nil views:views]];

	self.fundingStatus.text = [NSString stringWithFormat:@"Funding Status: %@", self.proposal.fundingStatus];
	self.fundingStatus.font = [UIFont fontWithName:DonorsChooseBodyBasicFont size:14];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-25-[fundingStatus]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[expirationDate]-[fundingStatus(30)]" options:0 metrics:nil views:views]];

	NSInteger costToComplete = [self.proposal.costToComplete integerValue];
	NSInteger total = [self.proposal.totalPrice integerValue];
	NSString *raisedSoFar = [NSString stringWithFormat:@"%ld", total - costToComplete];
	self.costToCompleteOfTotalWithPercent.text = [NSString stringWithFormat:@"Raised: $%@ of $%@ (%@%%)", raisedSoFar, self.proposal.totalPrice, self.proposal.percentFunded];
	self.costToCompleteOfTotalWithPercent.font = [UIFont fontWithName:DonorsChooseBodyBasicFont size:14];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-25-[costToCompleteOfTotalWithPercent]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[fundingStatus]-[costToCompleteOfTotalWithPercent(30)]" options:0 metrics:nil views:views]];

	self.numberOfDonations.text = [NSString stringWithFormat:@"Number of Donations: %ld", (unsigned long)[self.proposal.donations count]];
	self.numberOfDonations.font = [UIFont fontWithName:DonorsChooseBodyBasicFont size:14];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-25-[numberOfDonations]" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[costToCompleteOfTotalWithPercent]-[numberOfDonations(30)]" options:0 metrics:nil views:views]];


	NSLayoutConstraint *shareButtonWidthConstraints = [NSLayoutConstraint constraintWithItem:self.shareButton
	                                                                               attribute:NSLayoutAttributeWidth
	                                                                               relatedBy:NSLayoutRelationEqual
	                                                                                  toItem:self.view
	                                                                               attribute:NSLayoutAttributeWidth
	                                                                              multiplier:0.3
	                                                                                constant:0];
	[self.view addConstraint:shareButtonWidthConstraints];

	NSLayoutConstraint *shareButtonCenterXConstraints = [NSLayoutConstraint constraintWithItem:self.self.shareButton
	                                                                                 attribute:NSLayoutAttributeCenterX
	                                                                                 relatedBy:NSLayoutRelationEqual
	                                                                                    toItem:self.view
	                                                                                 attribute:NSLayoutAttributeCenterX
	                                                                                multiplier:1.0
	                                                                                  constant:0];
	[self.view addConstraint:shareButtonCenterXConstraints];


	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[numberOfDonations]-50-[shareButton]" options:0 metrics:nil views:views]];

	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[numberOfDonations]-10-[donorsListButton]" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[costToCompleteOfTotalWithPercent]-[donorsListButton(30)]" options:0 metrics:nil views:views]];
}

- (void)createAndAddSubviews {
	self.titleLabel = [[UILabel alloc] init];
	[self.view addSubview:self.titleLabel];

	self.expirationDate = [[UILabel alloc] init];
	[self.view addSubview:self.expirationDate];

	self.location = [[UILabel alloc] init];
	[self.view addSubview:self.location];

	self.schoolName = [[UILabel alloc] init];
	[self.view addSubview:self.schoolName];

	self.fundingStatus = [[UILabel alloc] init];
	[self.view addSubview:self.fundingStatus];

	self.costToCompleteOfTotalWithPercent = [[UILabel alloc] init];
	[self.view addSubview:self.costToCompleteOfTotalWithPercent];

	self.numberOfDonations = [[UILabel alloc] init];
	[self.view addSubview:self.numberOfDonations];

	self.shareButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];


	[self.shareButton addTarget:self action:@selector(shareTapped) forControlEvents:UIControlEventTouchUpInside];


	[self.shareButton setTitle:@"Share" forState:UIControlStateNormal];
	self.shareButton.backgroundColor = [UIColor DonorsChooseOrange];
	self.shareButton.tintColor = [UIColor DonorsChooseGreyVeryLight];
	self.shareButton.layer.cornerRadius = 10;
	self.shareButton.titleLabel.font = [UIFont fontWithName:DonorsChooseTitleBoldFont size:15];
	self.shareButton.layer.borderWidth = 1.0f;
	self.shareButton.layer.borderColor = [UIColor DonorsChooseGreyVeryLight].CGColor;
	self.shareButton.layer.shadowColor = [UIColor DonorsChooseGrey].CGColor;
	self.shareButton.layer.shadowOpacity = 0.3;
	self.shareButton.layer.shadowRadius = 7;
	self.shareButton.layer.shadowOffset = CGSizeMake(2, 2);


	[self.view addSubview:self.shareButton];

	self.donorsListButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[self.donorsListButton addTarget:self action:@selector(donorsListButtonTapped) forControlEvents:UIControlEventTouchUpInside];
	[self.donorsListButton setTitle:@"  Donors List  " forState:UIControlStateNormal];

	self.donorsListButton.backgroundColor = [UIColor DonorsChooseOrange];
	self.donorsListButton.tintColor = [UIColor DonorsChooseGreyVeryLight];
	self.donorsListButton.layer.cornerRadius = 10;
	self.donorsListButton.titleLabel.font = [UIFont fontWithName:DonorsChooseTitleBoldFont size:15];
	self.donorsListButton.layer.borderWidth = 1.0f;
	self.donorsListButton.layer.borderColor = [UIColor DonorsChooseGreyVeryLight].CGColor;
	self.donorsListButton.layer.shadowColor = [UIColor DonorsChooseGrey].CGColor;
	self.donorsListButton.layer.shadowOpacity = 0.3;
	self.donorsListButton.layer.shadowRadius = 7;
	self.donorsListButton.layer.shadowOffset = CGSizeMake(2, 2);

	[self.view addSubview:self.donorsListButton];
}

- (void)shareTapped {
	CustomItemUIActivityItemProvider *customItem = [[CustomItemUIActivityItemProvider alloc] initWithProposal:self.proposal andPlaceholder:@""];
	UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[customItem] applicationActivities:nil];
	[self presentViewController:activityVC animated:YES completion:nil];
}

- (void)donorsListButtonTapped {
//    DonorsTableViewController *donorsTable = [[DonorsTableViewController alloc] init];
//    donorsTable.proposal = self.proposal;
//    [self.navigationController addChildViewController:donorsTable];
//    [self.navigationController presentViewController:donorsTable animated:YES completion:nil];
}

@end
