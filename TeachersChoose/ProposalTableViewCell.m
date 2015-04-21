//
//  ProposalTableViewCell.m
//  TeachersChoose
//
//  Created by Damon Skinner on 4/8/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "ProposalTableViewCell.h"
#import "UIFont+DonorsChooseFonts.h"
#import "UIColor+DonorsChooseColors.h"

#import "NSDate+DateConvenienceMethods.h"
#import "FISDonorsChooseCompletedProposal.h"


@implementation ProposalTableViewCell



- (void)awakeFromNib {
    // Initialization code
    
    self.raisedLabel.hidden=YES;
    self.completionButton = [[UIButton alloc]init];
    
    self.completionButton.titleLabel.font = [UIFont fontWithName:DonorsChooseBodyBoldFont size:17];
    
    [self.completionButton setTitleColor:[UIColor DonorsChooseOrange] forState:UIControlStateNormal];
    
    self.completionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [self.completionButton setTitle:@"   Confirm Funding   " forState:UIControlStateNormal];
    
    [self.completionButton addTarget:self action:@selector(completionButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.completionButton setTitleColor:[UIColor DonorsChooseGreyLight] forState:UIControlStateSelected];
    
    [self.completionButton setBackgroundColor:[UIColor DonorsChooseGreen]];
    [self.completionButton setTintColor:[UIColor DonorsChooseGreyVeryLight]];
    
    self.completionButton.layer.cornerRadius=10;
    self.completionButton.titleLabel.font = [UIFont fontWithName:DonorsChooseTitleBoldFont size:15];
    self.completionButton.layer.borderWidth=1.0f;
    self.completionButton.layer.borderColor=[UIColor DonorsChooseGreyVeryLight].CGColor;
    self.completionButton.layer.shadowColor=[UIColor DonorsChooseGrey].CGColor;
    self.completionButton.layer.shadowOpacity=0.3;
    self.completionButton.layer.shadowRadius=7;
    self.completionButton.layer.shadowOffset=CGSizeMake(2, 2);
    
    
    [self.contentView addSubview:self.completionButton];
    
    self.backgroundColor=[UIColor DonorsChooseBlueLight];
    self.proposalTableViewProgressView.trackTintColor = [UIColor grayColor];
    self.proposalTableViewProgressView.progressTintColor = [UIColor greenColor];
    self.proposalTableViewProgressView.transform = CGAffineTransformMakeScale(1.0, 5.0);
    self.proposalTableViewProgressView.layer.cornerRadius = 20.0f;
    self.proposalTableViewProgressView.layer.masksToBounds = TRUE;
    self.proposalTableViewProgressView.clipsToBounds = TRUE;

    [self.contentView removeConstraints:self.contentView.constraints];
    [self.titleLabel removeConstraints:self.titleLabel.constraints];
    [self.expirationDateLabel removeConstraints:self.expirationDateLabel.constraints];
    [self.costToCompleteLabel removeConstraints:self.costToCompleteLabel.constraints];
    [self.numDonorsLabel removeConstraints:self.numDonorsLabel.constraints];
    [self.proposalTableViewProgressView removeConstraints:self.proposalTableViewProgressView.constraints];
    [self.toGoLabel removeConstraints:self.toGoLabel.constraints];
    [self.fundedLabel removeConstraints:self.fundedLabel.constraints];
    [self.raisedLabel removeConstraints:self.raisedLabel.constraints];
    [self.percentFundedLabel removeConstraints:self.percentFundedLabel.constraints];
    [self.amountRaisedLabel removeConstraints:self.amountRaisedLabel.constraints];
    [self.donorsLabel removeConstraints:self.donorsLabel.constraints];
    [self.completionButton removeConstraints:self.completionButton.constraints];
    [self.donorsAwaitingReplyLabel removeConstraints:self.donorsAwaitingReplyLabel.constraints];
<<<<<<< HEAD
    
=======
    [self.dateFundedLabel removeConstraints:self.dateFundedLabel.constraints];
    [self.fullyFundedDateLabel removeConstraints:self.fullyFundedDateLabel.constraints];
    
//        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
>>>>>>> need to finish date formatting
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.expirationDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.costToCompleteLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.numDonorsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.proposalTableViewProgressView.translatesAutoresizingMaskIntoConstraints = NO;
    self.toGoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.fundedLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.raisedLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.percentFundedLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.amountRaisedLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.donorsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.completionButton.translatesAutoresizingMaskIntoConstraints=NO;
    self.donorsAwaitingReplyLabel.translatesAutoresizingMaskIntoConstraints=NO;
    self.dateFundedLabel.translatesAutoresizingMaskIntoConstraints=NO;
    self.fullyFundedDateLabel.translatesAutoresizingMaskIntoConstraints=NO;
    
    NSLayoutConstraint *titleLabelWidthConstraint =
    [NSLayoutConstraint constraintWithItem:self.titleLabel
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                  constant:0];
    
    [self.contentView addConstraint:titleLabelWidthConstraint];
    
    NSLayoutConstraint *titleLabelBottomConstraint =
    [NSLayoutConstraint constraintWithItem:self.titleLabel
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.proposalTableViewProgressView
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:-20];
    
    [self.contentView addConstraint:titleLabelBottomConstraint];
    
    NSLayoutConstraint *titleLabelLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.titleLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:0];
    
    [self.contentView addConstraint:titleLabelLeftConstraint];
    
    NSLayoutConstraint *titleLabelRightConstraint =
    [NSLayoutConstraint constraintWithItem:self.titleLabel
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:0];
    
    [self.contentView addConstraint:titleLabelRightConstraint];
    
    NSLayoutConstraint *expirationDateLabelRightConstraint =
    [NSLayoutConstraint constraintWithItem:self.expirationDateLabel
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.titleLabel
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:0];
    
    [self.contentView addConstraint:expirationDateLabelRightConstraint];
    
    NSLayoutConstraint *expirationDateLabelBottomConstraint =
    [NSLayoutConstraint constraintWithItem:self.expirationDateLabel
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:-5];
    
    [self.contentView addConstraint:expirationDateLabelBottomConstraint];
    
    NSLayoutConstraint *completionButtonRight =
    [NSLayoutConstraint constraintWithItem:self.completionButton
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeRightMargin
                                multiplier:1.0
                                  constant:0];
    
    [self.contentView addConstraint:completionButtonRight];
    
    NSLayoutConstraint *completionButtonCenterY =
    [NSLayoutConstraint constraintWithItem:self.completionButton
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.expirationDateLabel
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0
                                  constant:-10];
    
    [self.contentView addConstraint:completionButtonCenterY];
    
    NSLayoutConstraint *costToCompleteLabelCenterXConstraint =
    [NSLayoutConstraint constraintWithItem:self.costToCompleteLabel
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.75
                                  constant:0];
    
    [self.contentView addConstraint:costToCompleteLabelCenterXConstraint];
    
    NSLayoutConstraint *costToCompleteLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.costToCompleteLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.proposalTableViewProgressView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:10];
    
    [self.contentView addConstraint:costToCompleteLabelTopConstraint];
    
    NSLayoutConstraint *amountRaisedLabelCenterXConstraint =
    [NSLayoutConstraint constraintWithItem:self.amountRaisedLabel
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.proposalTableViewProgressView
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0];
    
    [self.contentView addConstraint:amountRaisedLabelCenterXConstraint];
    
    NSLayoutConstraint *amountRaisedLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.amountRaisedLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.proposalTableViewProgressView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:10];
    
    [self.contentView addConstraint:amountRaisedLabelTopConstraint];
    
    
    NSLayoutConstraint *toGoLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.toGoLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.costToCompleteLabel
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:-2];
    
    [self.contentView addConstraint:toGoLabelTopConstraint];
    
    NSLayoutConstraint *toGoLabelCenterXConstraint =
    [NSLayoutConstraint constraintWithItem:self.toGoLabel
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.costToCompleteLabel
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0];
    
    [self.contentView addConstraint:toGoLabelCenterXConstraint];
    
    NSLayoutConstraint *raisedLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.raisedLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.amountRaisedLabel
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:-2];
    
    [self.contentView addConstraint:raisedLabelTopConstraint];
    
    NSLayoutConstraint *raisedLabelCenterXConstraint =
    [NSLayoutConstraint constraintWithItem:self.raisedLabel
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.amountRaisedLabel
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0];
    
    [self.contentView addConstraint:raisedLabelCenterXConstraint];
    
    NSLayoutConstraint *donorsLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.donorsLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.toGoLabel
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:0];
    
    [self.contentView addConstraint:donorsLabelTopConstraint];
    
    NSLayoutConstraint *donorsLabelCenterX =
    [NSLayoutConstraint constraintWithItem:self.donorsLabel
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:0.25
                                  constant:0];
    
    [self.contentView addConstraint:donorsLabelCenterX];
    
    NSLayoutConstraint *numDonorsLabelBottomConstraint =
    [NSLayoutConstraint constraintWithItem:self.numDonorsLabel
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.donorsLabel
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:5];
    
    [self.contentView addConstraint:numDonorsLabelBottomConstraint];
    
    NSLayoutConstraint *numDonorsLabelCenterXConstraint =
    [NSLayoutConstraint constraintWithItem:self.numDonorsLabel
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.donorsLabel
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0];
    
    [self.contentView addConstraint:numDonorsLabelCenterXConstraint];
    
    NSLayoutConstraint *numDonorsLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.numDonorsLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.proposalTableViewProgressView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:10];
    
    [self.contentView addConstraint:numDonorsLabelTopConstraint];
    
    
    NSLayoutConstraint *donorsLabelLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.donorsLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:8];
    
    [self.contentView addConstraint:donorsLabelLeftConstraint];
    
    
    NSLayoutConstraint *proposalTableViewProgressViewLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.proposalTableViewProgressView
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:5];
    
    [self.contentView addConstraint:proposalTableViewProgressViewLeftConstraint];
    
    NSLayoutConstraint *proposalTableViewProgressViewRightConstraint =
    [NSLayoutConstraint constraintWithItem:self.proposalTableViewProgressView
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:-5];
    
    [self.contentView addConstraint:proposalTableViewProgressViewRightConstraint];
    
    NSLayoutConstraint *proposalTableViewProgressViewTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.proposalTableViewProgressView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0
                                  constant:0];
    
    [self.contentView addConstraint:proposalTableViewProgressViewTopConstraint];
    
    NSLayoutConstraint *donorsAwaitingReplyLabelBottomConstraint =
    [NSLayoutConstraint constraintWithItem:self.donorsAwaitingReplyLabel
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0];
    
    [self.contentView addConstraint:donorsAwaitingReplyLabelBottomConstraint];
    
    
    NSLayoutConstraint *donorsAwaitingReplyLabelLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.donorsAwaitingReplyLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:8];
    
    [self.contentView addConstraint:donorsAwaitingReplyLabelLeftConstraint];
    
    NSLayoutConstraint *dateFundedLabelBottomConstraint =
    [NSLayoutConstraint constraintWithItem:self.dateFundedLabel
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0];
    
    [self.contentView addConstraint:dateFundedLabelBottomConstraint];
    
    NSLayoutConstraint *dateFundedLabelRightConstraint =
    [NSLayoutConstraint constraintWithItem:self.dateFundedLabel
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:-250];
    
    [self.contentView addConstraint:dateFundedLabelRightConstraint];
    
    NSLayoutConstraint *fullyFundedDateLabelBottomConstraint =
    [NSLayoutConstraint constraintWithItem:self.fullyFundedDateLabel
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0];
    
    [self.contentView addConstraint:fullyFundedDateLabelBottomConstraint];
    
    NSLayoutConstraint *fullyFundedDateLabelRightConstraint =
    [NSLayoutConstraint constraintWithItem:self.fullyFundedDateLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.dateFundedLabel
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:-0];
    
    [self.contentView addConstraint:fullyFundedDateLabelRightConstraint];
    
    [self layoutIfNeeded];
}

-(void) settingFontAttributes {
    
    self.titleLabel.font = [UIFont fontWithName:DonorsChooseTitleBoldFont size:19];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.expirationDateLabel.font = [UIFont fontWithName:DonorsChooseBodyBasicFont size:17];
    self.expirationDateLabel.backgroundColor = [UIColor clearColor];
    
    self.costToCompleteLabel.font = [UIFont fontWithName:DonorsChooseBodyBoldFont size:18];
    self.costToCompleteLabel.backgroundColor = [UIColor clearColor];
    
    self.percentFundedLabel.font = [UIFont fontWithName:DonorsChooseBodyBoldFont size:18];
    self.percentFundedLabel.backgroundColor = [UIColor clearColor];
    
    self.amountRaisedLabel.font = [UIFont fontWithName:DonorsChooseBodyBoldFont size:18];
    self.amountRaisedLabel.backgroundColor = [UIColor clearColor];
    
    self.toGoLabel.font = [UIFont fontWithName:DonorsChooseBodyBasicFont size:18];
    self.toGoLabel.backgroundColor = [UIColor clearColor];
    self.toGoLabel.text = @"to go";
    
    
    self.raisedLabel.font = [UIFont fontWithName:DonorsChooseBodyBasicFont size:18];
    self.raisedLabel.backgroundColor = [UIColor clearColor];
    self.raisedLabel.text = @"raised";
    
    self.fundedLabel.font = [UIFont fontWithName:DonorsChooseBodyBasicFont size:18];
    self.fundedLabel.backgroundColor = [UIColor clearColor];
    self.fundedLabel.text = @"funded";
    
    self.donorsAwaitingReplyLabel.font = [UIFont fontWithName:DonorsChooseBodyItalicFont size:14];
    self.donorsAwaitingReplyLabel.backgroundColor = [UIColor clearColor];
    self.donorsAwaitingReplyLabel.textColor = [UIColor grayColor];
    
    self.donorsLabel.font = [UIFont fontWithName:DonorsChooseBodyBasicFont size:18];
    self.donorsLabel.backgroundColor = [UIColor clearColor];
    if ([self.proposal.numDonors isEqual:@"1"]) {
        self.donorsLabel.text=@"donor";
    } else {
        self.donorsLabel.text = @"donors";
    }
    
    
    self.numDonorsLabel.font = [UIFont fontWithName:DonorsChooseBodyBoldFont size:22];
    self.numDonorsLabel.backgroundColor = [UIColor clearColor];
    
    self.dateFundedLabel.font = [UIFont fontWithName:DonorsChooseBodyBasicFont size:18];
    self.dateFundedLabel.backgroundColor = [UIColor clearColor];
    self.dateFundedLabel.text = @"Funded:";
    
    
    if ([self.proposal isKindOfClass:[FISDonorsChooseCompletedProposal class]]) {
        self.fullyFundedDateLabel.font = [UIFont fontWithName:DonorsChooseBodyBasicFont size:18];
        self.fullyFundedDateLabel.backgroundColor = [UIColor clearColor];
//        self.fullyFundedDateLabel.text = ((FISDonorsChooseCompletedProposal *)self.proposal).fullyFundedDate;
        NSDate *dateFromString = [FISDonorsChooseCompletedProposal dateFromString:((FISDonorsChooseCompletedProposal *)self.proposal).fullyFundedDate];
        self.fullyFundedDateLabel.text = [FISDonorsChooseCompletedProposal stringFromDate:dateFromString];
    }
    
    [self layoutIfNeeded];

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
}


-(void)setProposal:(FISDonorsChooseProposal *)proposal {
    
    _proposal = proposal;
    self.titleLabel.text = _proposal.title;
    
    
    
    if (self.proposal.isFake || [self.proposal isKindOfClass:[FISDonorsChooseCompletedProposal class]]) {
        if ([_proposal.costToComplete integerValue]>0) {
            self.costToCompleteLabel.text = [NSString stringWithFormat:@"$%@", self.proposal.parseCostToComplete];
        } else {
            self.costToCompleteLabel.text=@"";
        }
        self.numDonorsLabel.text =[NSString stringWithFormat:@"%@", self.proposal.numDonors];
        NSInteger amountRaised = [self.proposal.totalPrice integerValue] - [self.proposal.costToComplete integerValue];
        
        CGFloat raisedAsFloat = [self.proposal.totalPrice floatValue] - [self.proposal.costToComplete floatValue];
        self.proposalTableViewProgressView.progress=  raisedAsFloat / [self.proposal.totalPrice floatValue];
        self.amountRaisedLabel.text= [NSString stringWithFormat:@"$%ld / $%ld", amountRaised,[self.proposal.totalPrice integerValue]];
    } else {
        if ([self.proposal.parseCostToComplete integerValue]>0) {
            self.costToCompleteLabel.text = [NSString stringWithFormat:@"$%@", self.proposal.parseCostToComplete];
        } else {
            self.costToCompleteLabel.text=@"";
        }
        
        self.percentFundedLabel.text=[NSString stringWithFormat:@"%ld%%",[self.proposal.percentFunded integerValue]];
        self.numDonorsLabel.text=[NSString stringWithFormat:@"%@", self.proposal.parseNumDonors];
        
        self.proposalTableViewProgressView.progress=  [self.proposal.parseCurrentDonated floatValue]/ [self.proposal.totalPrice floatValue];
        self.amountRaisedLabel.text= [NSString stringWithFormat:@"$%ld / $%ld", [self.proposal.parseCurrentDonated integerValue],[self.proposal.totalPrice integerValue]];
        

    }
    
    
    
    self.donorsAwaitingReplyLabel.text=[NSString stringWithFormat:@"(%ld donors awaiting reply)",(long)self.proposal.numDonationsNeedResponse];
    if ([self.donorsAwaitingReplyLabel.text isEqualToString:@"(0 donors awaiting reply)"]) {
        self.donorsAwaitingReplyLabel.hidden=YES;
    } else {
        self.donorsAwaitingReplyLabel.hidden=NO;
    }

    NSInteger daysLeft = [NSDate daysBetweenDate:[NSDate date] andDate:[NSDate expirationDateFormatterWithDateString:self.proposal.expirationDate]];
    
    if ([self.proposal.fundingStatus isEqualToString:@"needs funding"]) {
        self.toGoLabel.hidden=NO;
        self.completionButton.hidden=YES;
//        self.raisedLabel.hidden=NO;
        self.fundedLabel.hidden=NO;
        self.expirationDateLabel.textColor=[UIColor DonorsChooseRedErrorColor];
        self.expirationDateLabel.text =[NSString stringWithFormat:@"%ld Days Left",daysLeft];
        if ([self.expirationDateLabel.text integerValue]<=30) {
            self.expirationDateLabel.hidden=NO;
        } else {
            self.expirationDateLabel.hidden=YES;
        }
    } else {
        self.toGoLabel.hidden=YES;
        self.raisedLabel.hidden=YES;
        self.fundedLabel.hidden=YES;

        if ([self.proposal isKindOfClass:[FISDonorsChooseCompletedProposal class]]) {
            self.expirationDateLabel.hidden=YES;
            self.completionButton.hidden=YES;
            self.proposalTableViewProgressView.hidden=YES;
            self.amountRaisedLabel.hidden=YES;
            self.dateFundedLabel.hidden=NO;
            self.fullyFundedDateLabel.hidden=NO;
        } else {
             self.expirationDateLabel.hidden=YES;
            self.completionButton.hidden=NO;
            self.proposalTableViewProgressView.hidden=NO;
            self.amountRaisedLabel.hidden=NO;
            self.dateFundedLabel.hidden=YES;
            self.fullyFundedDateLabel.hidden=YES;
        }
       
        
        self.expirationDateLabel.textColor=[UIColor DonorsChooseGreen];
        self.expirationDateLabel.text=@"Project Complete!";
    }
    
    [self layoutIfNeeded];
    [self settingFontAttributes];

}

- (IBAction)completionButton:(id)sender {
}

@end
