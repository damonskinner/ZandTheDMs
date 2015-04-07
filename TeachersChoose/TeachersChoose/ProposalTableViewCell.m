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
    
    self.backgroundColor=[UIColor colorWithRed:0.957 green:0.98 blue:0.992 alpha:1]; /*#f4fafd*/
    
    [self.contentView removeConstraints:self.contentView.constraints];
    [self.titleLabel removeConstraints:self.titleLabel.constraints];
    [self.expirationDateLabel removeConstraints:self.expirationDateLabel.constraints];
    [self.costToCompleteLabel removeConstraints:self.costToCompleteLabel.constraints];
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.expirationDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.costToCompleteLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
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
                                  constant:-20];
    
    [self.contentView addConstraint:titleLabelRightConstraint];
    
    NSLayoutConstraint *titleLabelBottomConstraint =
    [NSLayoutConstraint constraintWithItem:self.titleLabel
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.costToCompleteLabel
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:-50];
    
    [self.contentView addConstraint:titleLabelBottomConstraint];
    
    NSLayoutConstraint *expirationDateLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.expirationDateLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.costToCompleteLabel
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:0];
    
    [self.contentView addConstraint:expirationDateLabelTopConstraint];
    
    NSLayoutConstraint *expirationDateLabelLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.expirationDateLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:-70];
    
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
    
    NSLayoutConstraint *expirationDateLabelBottomConstraint =
    [NSLayoutConstraint constraintWithItem:self.expirationDateLabel
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:-5];
    
    [self.contentView addConstraint:expirationDateLabelBottomConstraint];
    
    NSLayoutConstraint *costToCompleteLabelLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.costToCompleteLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:8];
    
    [self.contentView addConstraint:costToCompleteLabelLeftConstraint];
    
    NSLayoutConstraint *costToCompleteLabelBottomConstraint =
    [NSLayoutConstraint constraintWithItem:self.costToCompleteLabel
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:-5];
    
    [self.contentView addConstraint:costToCompleteLabelBottomConstraint];
    
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
    self.costToCompleteLabel.text = [NSString stringWithFormat:@"%@",_proposal.proposalCostToComplete];
    
}


@end
