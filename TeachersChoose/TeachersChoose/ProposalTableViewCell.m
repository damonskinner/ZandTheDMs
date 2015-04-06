//
//  ProposalTableViewCell.m
//  TeachersChoose
//
//  Created by Cooper Veysey on 4/2/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "ProposalTableViewCell.h"
#import "Proposal.h"

@implementation ProposalTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.contentView removeConstraints:self.contentView.constraints];
    [self.titleLabel removeConstraints:self.titleLabel.constraints];
    [self.expirationDateLabel removeConstraints:self.expirationDateLabel.constraints];
    [self.needLabel removeConstraints:self.needLabel.constraints];
    [self.percentFundedLabel removeConstraints:self.percentFundedLabel.constraints];
    [self.costToCompleteLabel removeConstraints:self.costToCompleteLabel.constraints];
    [self.numDonorsLabel removeConstraints:self.numDonorsLabel.constraints];
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.expirationDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.needLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.percentFundedLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.costToCompleteLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.numDonorsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *titleLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.titleLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:10];
    
    [self.contentView addConstraint:titleLabelTopConstraint];
    
    NSLayoutConstraint *titleLabelLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.titleLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:8];
    
    [self.contentView addConstraint:titleLabelLeftConstraint];
    
    NSLayoutConstraint *titleLabelRightConstraint =
    [NSLayoutConstraint constraintWithItem:self.titleLabel
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:-8];
    
    [self.contentView addConstraint:titleLabelRightConstraint];
    
    NSLayoutConstraint *titleLabelBottomConstraint =
    [NSLayoutConstraint constraintWithItem:self.titleLabel
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.expirationDateLabel
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:0];
    
    [self.contentView addConstraint:titleLabelBottomConstraint];
    
    NSLayoutConstraint *expirationDateLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.expirationDateLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.titleLabel
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:8];
    
    [self.contentView addConstraint:expirationDateLabelTopConstraint];
    
    NSLayoutConstraint *expirationDateLabelLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.expirationDateLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:-50];
    
    [self.contentView addConstraint:expirationDateLabelLeftConstraint];
    
//    NSLayoutConstraint *expirationDateLabelRightConstraint =
//    [NSLayoutConstraint constraintWithItem:self.expirationDateLabel
//                                 attribute:NSLayoutAttributeRight
//                                 relatedBy:NSLayoutRelationEqual
//                                    toItem:self.contentView
//                                 attribute:NSLayoutAttributeRight
//                                multiplier:1.0
//                                  constant:-8];
//    
//    [self.contentView addConstraint:expirationDateLabelRightConstraint];
    
//    NSLayoutConstraint *expirationDateLabelBottomConstraint =
//    [NSLayoutConstraint constraintWithItem:self.expirationDateLabel
//                                 attribute:NSLayoutAttributeBottom
//                                 relatedBy:NSLayoutRelationEqual
//                                    toItem:self.percentFundedLabel
//                                 attribute:NSLayoutAttributeTop
//                                multiplier:1.0
//                                  constant:-10];
    
//    [self.contentView addConstraint:expirationDateLabelBottomConstraint];
    
    NSLayoutConstraint *percentFundedLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.percentFundedLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.expirationDateLabel
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:10];
    
    [self.contentView addConstraint:percentFundedLabelTopConstraint];
    
    NSLayoutConstraint *percentFundedLabelLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.percentFundedLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:-50];
    
    [self.contentView addConstraint:percentFundedLabelLeftConstraint];
    
//    NSLayoutConstraint *percentFundedLabelRightConstraint =
//    [NSLayoutConstraint constraintWithItem:self.expirationDateLabel
//                                 attribute:NSLayoutAttributeRight
//                                 relatedBy:NSLayoutRelationEqual
//                                    toItem:self.contentView
//                                 attribute:NSLayoutAttributeRight
//                                multiplier:1.0
//                                  constant:-8];
//    
//    [self.contentView addConstraint:percentFundedLabelRightConstraint];
    
    NSLayoutConstraint *percentFundedLabelBottomConstraint =
    [NSLayoutConstraint constraintWithItem:self.percentFundedLabel
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.costToCompleteLabel
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:-10];
    
    [self.contentView addConstraint:percentFundedLabelBottomConstraint];
    
    NSLayoutConstraint *costToCompleteLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.costToCompleteLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.percentFundedLabel
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:10];
    
    [self.contentView addConstraint:costToCompleteLabelTopConstraint];
    
    NSLayoutConstraint *costToCompleteLabelLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.costToCompleteLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.percentFundedLabel
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:0];
    
    [self.contentView addConstraint:costToCompleteLabelLeftConstraint];
    
//    NSLayoutConstraint *costToCompleteLabelRightConstraint =
//    [NSLayoutConstraint constraintWithItem:self.costToCompleteLabel
//                                 attribute:NSLayoutAttributeRight
//                                 relatedBy:NSLayoutRelationEqual
//                                    toItem:self.contentView
//                                 attribute:NSLayoutAttributeRight
//                                multiplier:1.0
//                                  constant:-8];
//    
//    [self.contentView addConstraint:costToCompleteLabelRightConstraint];
    
    NSLayoutConstraint *costToCompleteLabelBottomConstraint =
    [NSLayoutConstraint constraintWithItem:self.costToCompleteLabel
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.numDonorsLabel
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:-10];
    
    [self.contentView addConstraint:costToCompleteLabelBottomConstraint];
    
    NSLayoutConstraint *numDonorsLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.numDonorsLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.costToCompleteLabel
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:10];
    
    [self.contentView addConstraint:numDonorsLabelTopConstraint];
    
    NSLayoutConstraint *numDonorsLabelLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.numDonorsLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.percentFundedLabel
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:0];
    
    [self.contentView addConstraint:numDonorsLabelLeftConstraint];
    
//    NSLayoutConstraint *numDonorsLabelRightConstraint =
//    [NSLayoutConstraint constraintWithItem:self.numDonorsLabel
//                                 attribute:NSLayoutAttributeRight
//                                 relatedBy:NSLayoutRelationEqual
//                                    toItem:self.contentView
//                                 attribute:NSLayoutAttributeRight
//                                multiplier:1.0
//                                  constant:-8];
//    
//    [self.contentView addConstraint:numDonorsLabelRightConstraint];
    
    NSLayoutConstraint *numDonorsLabelBottomConstraint =
    [NSLayoutConstraint constraintWithItem:self.numDonorsLabel
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:-10];
    
    [self.contentView addConstraint:numDonorsLabelBottomConstraint];
    
    NSLayoutConstraint *needLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.needLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.expirationDateLabel
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:5];
    
    [self.contentView addConstraint:needLabelTopConstraint];
    
    NSLayoutConstraint *needLabelLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.needLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:8];
    
    [self.contentView addConstraint:needLabelLeftConstraint];
    
    NSLayoutConstraint *needLabelRightConstraint =
    [NSLayoutConstraint constraintWithItem:self.needLabel
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.expirationDateLabel
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:-8];
    
    [self.contentView addConstraint:needLabelRightConstraint];
    
//    NSLayoutConstraint *needLabelBottomConstraint =
//    [NSLayoutConstraint constraintWithItem:self.needLabel
//                                 attribute:NSLayoutAttributeBottom
//                                 relatedBy:NSLayoutRelationEqual
//                                    toItem:self.contentView
//                                 attribute:NSLayoutAttributeBottom
//                                multiplier:1.0
//                                  constant:-10];
//    
//    [self.contentView addConstraint:needLabelBottomConstraint];
    
    [self layoutIfNeeded];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setProposal:(Proposal *)proposal {
    _proposal = proposal;
    self.titleLabel.text = _proposal.proposalTitle;
    self.expirationDateLabel.text = _proposal.proposalExpirationDate;
    self.needLabel.text = _proposal.proposalNeed;
    self.percentFundedLabel.text = [NSString stringWithFormat:@"%@",_proposal.proposalPercentFunded];
    self.costToCompleteLabel.text = [NSString stringWithFormat:@"%@",_proposal.proposalCostToComplete];
    
}


@end
