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
#import "CustomItemUIActivityItemProvider.h"

@interface StatDetailsViewController ()<UIActivityItemSource>

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *expirationDate;
@property (strong, nonatomic) UILabel *schoolName;
@property (strong, nonatomic) UILabel *fundingStatus;
@property (strong, nonatomic) UILabel *costToCompleteOfTotalWithPercent;
@property (strong, nonatomic) UILabel *numberOfDonations;
@property (strong, nonatomic) UILabel *location;

@property (strong, nonatomic) UIButton *shareButton;

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

	self.view.backgroundColor = [UIColor whiteColor];
//    self.view.backgroundColor = [UIColor greenColor];

	self.proposal = ((DetailsTabBarController *)self.tabBarController).selectedProposal;

	NSDictionary *views = @{ @"title" : self.titleLabel,
		                     @"expirationDate" : self.expirationDate,
		                     @"schoolName" : self.schoolName,
		                     @"location" : self.location,
		                     @"fundingStatus" : self.fundingStatus,
		                     @"costToCompleteOfTotalWithPercent" : self.costToCompleteOfTotalWithPercent,
		                     @"numberOfDonations" : self.numberOfDonations,
                             @"shareButton": self.shareButton};



	self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
	self.titleLabel.numberOfLines = 0;
	self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
	self.titleLabel.text = self.proposal.title;
    self.titleLabel.font = [UIFont fontWithName:DonorsChooseCSSFont size:20];
	[self.titleLabel sizeToFit];
	self.titleLabel.textAlignment = NSTextAlignmentCenter;
//self.titleLabel.backgroundColor = [UIColor redColor];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[title]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[title(100)]" options:0 metrics:nil views:views]];

	self.expirationDate.text = [NSString stringWithFormat:@"Exp. Date: %@", self.proposal.expirationDate];
//self.expirationDate.backgroundColor = [UIColor blueColor];
	self.expirationDate.font = [UIFont fontWithName:DonorsChooseBasicFont size:14];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-25-[expirationDate]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[location]-30-[expirationDate(30)]" options:0 metrics:nil views:views]];

	self.schoolName.text = [NSString stringWithFormat:@"%@", self.proposal.schoolName];
//self.schoolName.backgroundColor = [UIColor purpleColor];
    self.schoolName.textAlignment = NSTextAlignmentCenter;
	self.schoolName.font = [UIFont fontWithName:DonorsChooseBasicFont size:16];
	self.schoolName.textAlignment = NSTextAlignmentCenter;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[schoolName]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[title][schoolName(10)]" options:0 metrics:nil views:views]];

	self.location.text = [NSString stringWithFormat:@"%@, %@ %@", self.proposal.city, self.proposal.state, self.proposal.zip];
//self.schoolName.backgroundColor = [UIColor purpleColor];
	self.location.font = [UIFont fontWithName:DonorsChooseBasicFont size:16];
	self.location.textAlignment = NSTextAlignmentCenter;
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[location]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[schoolName]-[location(20)]" options:0 metrics:nil views:views]];

	self.fundingStatus.text = [NSString stringWithFormat:@"Funding Status: %@", self.proposal.fundingStatus];
//self.fundingStatus.backgroundColor = [UIColor brownColor];
	self.fundingStatus.font = [UIFont fontWithName:DonorsChooseBasicFont size:14];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-25-[fundingStatus]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[expirationDate]-[fundingStatus(30)]" options:0 metrics:nil views:views]];

	NSInteger costToComplete = [self.proposal.costToComplete integerValue];
	NSInteger total = [self.proposal.totalPrice integerValue];
	NSString *raisedSoFar = [NSString stringWithFormat:@"%d", total - costToComplete];
	self.costToCompleteOfTotalWithPercent.text = [NSString stringWithFormat:@"Raised: $%@ of $%@ (%@%%)", raisedSoFar, self.proposal.totalPrice, self.proposal.percentFunded];
//self.costToCompleteOfTotalWithPercent.backgroundColor = [UIColor yellowColor];
	self.costToCompleteOfTotalWithPercent.font = [UIFont fontWithName:DonorsChooseBasicFont size:14];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-25-[costToCompleteOfTotalWithPercent]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[fundingStatus]-[costToCompleteOfTotalWithPercent(30)]" options:0 metrics:nil views:views]];

	self.numberOfDonations.text = [NSString stringWithFormat:@"Number of Donations: %ld", (unsigned long)[self.proposal.donations count]];
//self.numberOfDonations.backgroundColor = [UIColor orangeColor];
	self.numberOfDonations.font = [UIFont fontWithName:DonorsChooseBasicFont size:14];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-25-[numberOfDonations]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[costToCompleteOfTotalWithPercent]-[numberOfDonations(30)]" options:0 metrics:nil views:views]];
    
    //[self.shareButton setTitle:@"Share Button" forState:UIControlStateNormal];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[shareButton]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[numberOfDonations]-50-[shareButton]" options:0 metrics:nil views:views]];
    
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
    [self.shareButton setTitle:@"Share Button" forState:UIControlStateNormal];
    self.shareButton.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:self.shareButton];

}

- (void)shareTapped {
    
    CustomItemUIActivityItemProvider *customItem = [[CustomItemUIActivityItemProvider alloc] initWithProposal:self.proposal andPlaceholder:@""];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[customItem] applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}




@end
