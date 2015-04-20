//
//  ProposalTableViewCell.h
//  TeachersChoose
//
//  Created by Damon Skinner on 4/8/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FISDonorsChooseProposal.h"



@interface ProposalTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *costToCompleteLabel;
@property (weak, nonatomic) IBOutlet UILabel *expirationDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numDonorsLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *proposalTableViewProgressView;
@property (weak, nonatomic) IBOutlet UILabel *toGoLabel;
@property (weak, nonatomic) IBOutlet UILabel *raisedLabel;
@property (weak, nonatomic) IBOutlet UILabel *fundedLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountRaisedLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentFundedLabel;
@property (weak, nonatomic) IBOutlet UILabel *donorsLabel;

@property (weak, nonatomic) IBOutlet UIButton *completionButton;
@property (weak, nonatomic) IBOutlet UILabel *donorsAwaitingReplyLabel;

- (IBAction)completionButton:(id)sender;

@property (nonatomic, strong) FISDonorsChooseProposal *proposal;

@end