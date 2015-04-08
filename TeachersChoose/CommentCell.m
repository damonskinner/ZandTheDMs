//
//  CommentCell.m
//  TeachersChoose
//
//  Created by Cooper Veysey on 4/7/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "CommentCell.h"
#import "Comments.h"
#import "CommentsTableView.h"

@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code

    [self removeConstraints:self.constraints];
    [self.donorNameLabel removeConstraints:self.donorNameLabel.constraints];
    [self.donorLocationLabel removeConstraints:self.donorLocationLabel.constraints];
    [self.donationGivenDateLabel removeConstraints:self.donationGivenDateLabel.constraints];
    [self.donorMessageCopyLabel removeConstraints:self.donorMessageCopyLabel.constraints];
    
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.donorLocationLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.donorNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.donationGivenDateLabel.translatesAutoresizingMaskIntoConstraints= NO;
    self.donorMessageCopyLabel.translatesAutoresizingMaskIntoConstraints = NO;


    NSLayoutConstraint *donorNameLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.donorNameLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:8];
    
    [self addConstraint:donorNameLabelTopConstraint];
    
    NSLayoutConstraint *donorNameLabelLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.donorNameLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:8];
    
    [self addConstraint:donorNameLabelLeftConstraint];
    
    NSLayoutConstraint *donorLocationLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.donorLocationLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.donorNameLabel
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:0];
    
    [self addConstraint:donorLocationLabelTopConstraint];
    
    NSLayoutConstraint *donorLocationLabelLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.donorLocationLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.donorNameLabel
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:0];
    
    [self addConstraint:donorLocationLabelLeftConstraint];
    
    NSLayoutConstraint *donationGivenDateLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.donationGivenDateLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.donorNameLabel
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
    
    NSLayoutConstraint *donorMessageCopyLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.donorMessageCopyLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.donationGivenDateLabel
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:4];
    
    [self addConstraint:donorMessageCopyLabelTopConstraint];
    
    NSLayoutConstraint *donorMessageCopyLabelLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.donorMessageCopyLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:8];
    
    [self addConstraint:donorMessageCopyLabelLeftConstraint];
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

-(void)setComments:(Comments *)comments{

    NSDateFormatter *formatterForDonationGivenDateLabel = [[NSDateFormatter alloc]init];
    [formatterForDonationGivenDateLabel setDateFormat:@"LLLL d YYYY"];
    NSString *stringRenderingOfDonationGivenDate = [formatterForDonationGivenDateLabel stringFromDate:comments.donationGivenDate];

    _comments = comments;
    self.donorNameLabel.text = comments.donorName;
    self.donorLocationLabel.text = comments.donorLocation;
    self.donationGivenDateLabel.text = stringRenderingOfDonationGivenDate;
    self.donorMessageCopyLabel.text = comments.donorMessageCopy;
}

@end
