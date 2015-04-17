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


//needs more work on cell constraints, i.e., height

@implementation ProposalTableViewCell

//-(id)initWithCoder:(NSCoder *) aDecoder
//{
//    self=[super initWithCoder:aDecoder];
//    if(!self) {
//        return nil;
//    }
//    
//    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner: self options: nil];
//    
//    [self addSubview:self.contentView];
//    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
//    self.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    NSDictionary *views = @{@"self":self,
//                            @"subView":self.contentView};
//    
//    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|[subView]|"
//                                                                   options:0
//                                                                   metrics:nil
//                                                                     views:views];
//    [self addConstraints:constraints];
//    
//    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subView]|" options:0 metrics:nil views:views];
//    [self addConstraints:constraints];
//    
//    return self;
//}

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
    

    
    NSLayoutConstraint *titleLabelWidthConstraint =
    [NSLayoutConstraint constraintWithItem:self.titleLabel
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                  constant:0];
    
    [self.contentView addConstraint:titleLabelWidthConstraint];
    
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
    
    self.titleLabel.font = [UIFont fontWithName:DonorsChooseTitleBoldFont size:25];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    
    
    
    self.expirationDateLabel.font = [UIFont fontWithName:DonorsChooseBodyBasicFont size:20];
    self.expirationDateLabel.backgroundColor = [UIColor clearColor];
    
    
    
    self.costToCompleteLabel.font = [UIFont fontWithName:DonorsChooseBodyItalicFont size:20];
    self.costToCompleteLabel.backgroundColor = [UIColor clearColor];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setProposal:(FISDonorsChooseProposal *)proposal {
    
    
    _proposal = proposal;
    self.titleLabel.text = _proposal.title;
    
    if ([_proposal.costToComplete integerValue]>0) {
        self.costToCompleteLabel.text = [NSString stringWithFormat:@"$%@ To Go!",_proposal.costToComplete];
    } else {
        self.costToCompleteLabel.text=@"";
    }
        
    
    
    NSInteger daysLeft = [NSDate daysBetweenDate:[NSDate date] andDate:[NSDate expirationDateFormatterWithDateString:self.proposal.expirationDate]];
    
    if ([_proposal.fundingStatus isEqualToString:@"needs funding"]) {
        self.expirationDateLabel.textColor=[UIColor DonorsChooseRedErrorColor];
        self.expirationDateLabel.text =[NSString stringWithFormat:@"%ld Days Left",daysLeft];
        if ([self.expirationDateLabel.text integerValue]<=30) {
            self.expirationDateLabel.hidden=NO;
        } else {
            self.expirationDateLabel.hidden=YES;
        }
    } else {
        self.expirationDateLabel.hidden=NO;
        self.expirationDateLabel.textColor=[UIColor DonorsChooseGreen];
        self.expirationDateLabel.text=@"Project Complete!";
    }
    
    
    [self settingFontAttributes];
}

@end
