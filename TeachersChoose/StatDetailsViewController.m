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

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *expirationDate;
@property (strong, nonatomic) UILabel *schoolName;
@property (strong, nonatomic) UILabel *fundingStatus;
@property (strong, nonatomic) UILabel *costToCompleteOfTotalWithPercent;
@property (strong, nonatomic) UILabel *numberOfDonations;

@end

@implementation StatDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createAndAddSubviews];
    
    [self.view removeConstraints:[self.view constraints]];
    for (UIView *view in self.view.subviews)
    {
        [view removeConstraints:[view constraints]];
        [view setTranslatesAutoresizingMaskIntoConstraints: NO];
    }

    self.view.backgroundColor = [UIColor whiteColor];
//    self.view.backgroundColor = [UIColor greenColor];

    self.proposal=((DetailsTabBarController*)self.tabBarController).selectedProposal;
    
    NSDictionary *views = @{@"title" : self.titleLabel,
                            @"expirationDate" : self.expirationDate,
                            @"schoolName" : self.schoolName,
                            @"fundingStatus" : self.fundingStatus,
                            @"costToCompleteOfTotalWithPercent" : self.costToCompleteOfTotalWithPercent,
                            @"numberOfDonations" : self.numberOfDonations};
    
    
    self.titleLabel.text = self.proposal.title;
    self.titleLabel.backgroundColor = [UIColor redColor];
    [self.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[title]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[title(20)]" options:0 metrics:nil views:views]];
    
    
    self.expirationDate.text = [NSString stringWithFormat:@"Exp. Date: %@",self.proposal.expirationDate];
    self.expirationDate.backgroundColor = [UIColor blueColor];
    [self.expirationDate setFont:[UIFont systemFontOfSize:9]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[expirationDate(100)]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[schoolName]-[expirationDate(30)]" options:0 metrics:nil views:views]];
    
    self.schoolName.text = [NSString stringWithFormat:@"%@ - %@, %@ %@", self.proposal.schoolName, self.proposal.city, self.proposal.state, self.proposal.zip];
    self.schoolName.backgroundColor = [UIColor purpleColor];
    [self.schoolName setFont:[UIFont systemFontOfSize:10]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[schoolName]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[title][schoolName(15)]" options:0 metrics:nil views:views]];
    
    self.fundingStatus.text = [NSString stringWithFormat:@"Funding Status: %@", self.proposal.fundingStatus];
    self.fundingStatus.backgroundColor = [UIColor brownColor];
    [self.fundingStatus setFont:[UIFont systemFontOfSize:9]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[fundingStatus][expirationDate]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[schoolName]-[fundingStatus(30)]" options:0 metrics:nil views:views]];
    
    NSInteger costToComplete = [self.proposal.costToComplete integerValue];
    NSInteger total = [self.proposal.totalPrice integerValue];
    NSString *raisedSoFar = [NSString stringWithFormat:@"%d", total - costToComplete];
    self.costToCompleteOfTotalWithPercent.text = [NSString stringWithFormat:@"Raised: $%@ of $%@ (%@%%)", raisedSoFar, self.proposal.totalPrice, self.proposal.percentFunded];
    self.costToCompleteOfTotalWithPercent.backgroundColor = [UIColor yellowColor];
    [self.costToCompleteOfTotalWithPercent setFont:[UIFont systemFontOfSize:9]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[costToCompleteOfTotalWithPercent]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[fundingStatus]-[costToCompleteOfTotalWithPercent(30)]" options:0 metrics:nil views:views]];
    
    self.numberOfDonations.text = [NSString stringWithFormat:@"Number of Donations: %ld",(unsigned long)[self.proposal.donations count]];
    self.numberOfDonations.backgroundColor = [UIColor orangeColor];
    [self.numberOfDonations setFont:[UIFont systemFontOfSize:9]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[numberOfDonations]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[expirationDate]-[numberOfDonations(30)]" options:0 metrics:nil views:views]];

    
}

-(void) createAndAddSubviews
{
    self.titleLabel = [[UILabel alloc] init];
    [self.view addSubview:self.titleLabel];
    
    self.expirationDate = [[UILabel alloc] init];
    [self.view addSubview:self.expirationDate];
    
    self.schoolName = [[UILabel alloc] init];
    [self.view addSubview:self.schoolName];
    
    self.fundingStatus = [[UILabel alloc] init];
    [self.view addSubview:self.fundingStatus];
    
    self.costToCompleteOfTotalWithPercent = [[UILabel alloc] init];
    [self.view addSubview:self.costToCompleteOfTotalWithPercent];
    
    self.numberOfDonations = [[UILabel alloc] init];
    [self.view addSubview:self.numberOfDonations];
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
