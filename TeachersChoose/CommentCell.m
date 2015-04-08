//
//  CommentCell.m
//  TeachersChoose
//
//  Created by Cooper Veysey on 4/7/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "CommentCell.h"
#import "Comments.h"

@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code

    [self removeConstraints:self.constraints];
    [self.donorNameFromLocationLabel removeConstraints:self.donorNameFromLocationLabel.constraints];
    [self.donationGivenDateLabel removeConstraints:self.donationGivenDateLabel.constraints];
    [self.donorCommentLabel removeConstraints:self.donorCommentLabel.constraints];

    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.donorNameFromLocationLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.donationGivenDateLabel.translatesAutoresizingMaskIntoConstraints= NO;
    self.donorCommentLabel.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *donorNameFromLocationLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.donorNameFromLocationLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:8];
    
    [self addConstraint:donorNameFromLocationLabelTopConstraint];
    
    NSLayoutConstraint *donorNameFromLocationLabelLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.donorNameFromLocationLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:8];
    
    [self addConstraint:donorNameFromLocationLabelLeftConstraint];
    
    NSLayoutConstraint *donationGivenDateLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.donationGivenDateLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.donorNameFromLocationLabel
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:4];
    
    [self addConstraint:donationGivenDateLabelTopConstraint];
    
    NSLayoutConstraint *donationGivenDateLabelLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.donationGivenDateLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:32];
    
    [self addConstraint:donationGivenDateLabelLeftConstraint];
    
    NSLayoutConstraint *donorCommentLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.donorCommentLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.donationGivenDateLabel
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:4];
    
    [self addConstraint:donorCommentLabelTopConstraint];
    
    NSLayoutConstraint *donorCommentLabelLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.donorCommentLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:8];
    
    [self addConstraint:donorCommentLabelLeftConstraint];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
    // Configure the view for the selected state
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        

    }
    
    return self;
}

@end
