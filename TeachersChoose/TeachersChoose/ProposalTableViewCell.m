//
//  ProposalTableViewCell.m
//  TeachersChoose
//
//  Created by Cooper Veysey on 4/2/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "ProposalTableViewCell.h"
//#import "Proposal.h"
#import "UIColor+DonorsChooseColors.h"
#import "NSDate+DateConvenienceMethods.h"

@implementation ProposalTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.backgroundColor=[UIColor DonorsChooseBlueLight];
    
    [self.contentView removeConstraints:self.contentView.constraints];
    [self.titleLabel removeConstraints:self.titleLabel.constraints];
    [self.expirationDateLabel removeConstraints:self.expirationDateLabel.constraints];
    [self.costToCompleteLabel removeConstraints:self.costToCompleteLabel.constraints];
    
//    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
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
    
    NSLayoutConstraint *costToCompleteLabelLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.costToCompleteLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.titleLabel
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:0];
    
    [self.contentView addConstraint:costToCompleteLabelLeftConstraint];
    
    NSLayoutConstraint *costToCompleteLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.costToCompleteLabel
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.titleLabel
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:40];
    
    [self.contentView addConstraint:costToCompleteLabelTopConstraint];
    
    
    
    [self layoutIfNeeded];
}

-(void) settingFontAttributes {
    
    self.titleLabel.font = [UIFont fontWithName:@"CourierNewPS-BoldMT" size:25];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    
    
    
    self.expirationDateLabel.font = [UIFont fontWithName:@"CourierNewPS-BoldMT" size:30];
    self.expirationDateLabel.backgroundColor = [UIColor clearColor];
    
    
    
    self.costToCompleteLabel.font = [UIFont fontWithName:@"CourierNewPS-BoldMT" size:20];
    self.costToCompleteLabel.backgroundColor = [UIColor clearColor];
    
    
    if ([self.expirationDateLabel.text integerValue]<=30) {
        self.expirationDateLabel.textColor=[UIColor DonorsChooseRedErrorColor];
    } else {
        self.expirationDateLabel.textColor=[UIColor clearColor];
    }
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setProposal:(FISDonorsChooseProposal *)proposal {
    
    
    _proposal = proposal;
    self.titleLabel.text = _proposal.title;
    
    self.costToCompleteLabel.text = [NSString stringWithFormat:@"$ %@ To Go!",_proposal.costToComplete];
    
    NSInteger daysLeft = [NSDate daysBetweenDate:[NSDate date] andDate:[NSDate expirationDateFormatterWithDateString:self.proposal.expirationDate]];
    
    self.expirationDateLabel.text =[NSString stringWithFormat:@"%ld Days Left",daysLeft];
    
    [self settingFontAttributes];
}




@end
