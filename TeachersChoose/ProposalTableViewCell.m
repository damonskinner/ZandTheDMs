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
    
    //    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
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
    
    NSLayoutConstraint *costToCompleteLabelCenterXConstraint =
    [NSLayoutConstraint constraintWithItem:self.costToCompleteLabel
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.50
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
    
    NSLayoutConstraint *numDonorsLabelCenterXConstraint =
    [NSLayoutConstraint constraintWithItem:self.numDonorsLabel
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:.50
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
    
    NSLayoutConstraint *donorsLabelCenterXConstraint =
    [NSLayoutConstraint constraintWithItem:self.donorsLabel
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.numDonorsLabel
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0];
    
    [self.contentView addConstraint:donorsLabelCenterXConstraint];
    
    NSLayoutConstraint *numDonorsLabelBottomConstraint =
    [NSLayoutConstraint constraintWithItem:self.numDonorsLabel
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.donorsLabel
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:5];
    
    [self.contentView addConstraint:numDonorsLabelBottomConstraint];
    
    NSLayoutConstraint *donorsLabelBottomConstraint =
    [NSLayoutConstraint constraintWithItem:self.donorsLabel
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:-5];
    
    [self.contentView addConstraint:donorsLabelBottomConstraint];
    
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
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.titleLabel
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:15];
    
    [self.contentView addConstraint:proposalTableViewProgressViewTopConstraint];
    
//    NSLayoutConstraint *proposalTableViewProgressViewHeightConstraint =
//    [NSLayoutConstraint constraintWithItem:self.proposalTableViewProgressView
//                                 attribute:NSLayoutAttributeHeight
//                                 relatedBy:NSLayoutRelationEqual
//                                    toItem:self.titleLabel
//                                 attribute:NSLayoutAttributeBottom
//                                multiplier:1.0
//                                  constant:10];
//    
//    [self.contentView addConstraint:proposalTableViewProgressViewHeightConstraint];
    
    [self layoutIfNeeded];
}

-(void) settingFontAttributes {
    
    self.titleLabel.font = [UIFont fontWithName:DonorsChooseTitleBoldFont size:19];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.expirationDateLabel.font = [UIFont fontWithName:DonorsChooseBodyBasicFont size:20];
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
    
    self.donorsLabel.font = [UIFont fontWithName:DonorsChooseBodyBasicFont size:18];
    self.donorsLabel.backgroundColor = [UIColor clearColor];
    self.donorsLabel.text = @"donors";
    
    self.numDonorsLabel.font = [UIFont fontWithName:DonorsChooseBodyBoldFont size:22];
    self.numDonorsLabel.backgroundColor = [UIColor clearColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setProposal:(FISDonorsChooseProposal *)proposal {
    
    _proposal = proposal;
    self.titleLabel.text = _proposal.title;
    
    if ([_proposal.costToComplete integerValue]>0) {
        self.costToCompleteLabel.text = [NSString stringWithFormat:@"$%d",_proposal.costToComplete.intValue];
    } else {
        self.costToCompleteLabel.text=@"";
    }
    
    self.percentFundedLabel.text=[NSString stringWithFormat:@"%d%%",self.proposal.percentFunded.intValue];
    self.numDonorsLabel.text=[NSString stringWithFormat:@"%@", self.proposal.numDonors];
    NSInteger amountRaised = [self.proposal.totalPrice integerValue] - [self.proposal.costToComplete integerValue];
    
    self.amountRaisedLabel.text= [NSString stringWithFormat:@"$%ld / $%d", amountRaised,self.proposal.totalPrice.intValue];
    
    
    
    
    
    NSInteger daysLeft = [NSDate daysBetweenDate:[NSDate date] andDate:[NSDate expirationDateFormatterWithDateString:self.proposal.expirationDate]];
    
    if ([_proposal.fundingStatus isEqualToString:@"needs funding"]) {
        self.toGoLabel.hidden=NO;
        self.raisedLabel.hidden=NO;
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

        
        
        self.expirationDateLabel.hidden=NO;
        
        
        
        self.expirationDateLabel.textColor=[UIColor DonorsChooseGreen];
        self.expirationDateLabel.text=@"Project Complete!";
    }
    
    
    [self settingFontAttributes];
}

@end
