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

NSString *fromString = @"from";

- (void)awakeFromNib {
    // Initialization code

    [self.contentView removeConstraints:self.contentView.constraints];
    [self.donorNameAndLocationLabel removeConstraints:self.donorNameAndLocationLabel.constraints];
    [self.donationGivenDateLabel removeConstraints:self.donationGivenDateLabel.constraints];
    [self.donorMessageCopyLabel removeConstraints:self.donorMessageCopyLabel.constraints];
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.donorNameAndLocationLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.donationGivenDateLabel.translatesAutoresizingMaskIntoConstraints= NO;
    self.donorMessageCopyLabel.translatesAutoresizingMaskIntoConstraints = NO;


    NSLayoutConstraint *donorNameAndLocationLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.donorNameAndLocationLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:25];
    
    [self.contentView addConstraint:donorNameAndLocationLabelTopConstraint];
    
    NSLayoutConstraint *donorNameAndLocationLabelLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.donorNameAndLocationLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:8];
    
    [self.contentView addConstraint:donorNameAndLocationLabelLeftConstraint];
    
    NSLayoutConstraint *donationGivenDateLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.donationGivenDateLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.donorNameAndLocationLabel
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:4];
    
    [self.contentView addConstraint:donationGivenDateLabelTopConstraint];
    
    NSLayoutConstraint *donationGivenDateLabelLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.donationGivenDateLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:32];
    
    [self.contentView addConstraint:donationGivenDateLabelLeftConstraint];
    
    NSLayoutConstraint *donorMessageCopyLabelTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.donorMessageCopyLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.donationGivenDateLabel
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:4];
    
    [self.contentView addConstraint:donorMessageCopyLabelTopConstraint];
    
    NSLayoutConstraint *donorMessageCopyLabelLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.donorMessageCopyLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:8];
    
    [self.contentView addConstraint:donorMessageCopyLabelLeftConstraint];
    
    NSLayoutConstraint *donorMessageCopyLabelRightConstraint =
    [NSLayoutConstraint constraintWithItem:self.donorMessageCopyLabel
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:-2];
    
    [self addConstraint:donorMessageCopyLabelRightConstraint];
    
//    self.donorMessageCopyLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    self.donorMessageCopyLabel.numberOfLines = 0;
//    self.donorMessageCopyLabel.lineBreakMode = NSLineBreakByWordWrapping;
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
    self.donorNameAndLocationLabel.text  = [NSString stringWithFormat:@"%@ from %@", comments.donorName, comments.donorLocation];
    self.donationGivenDateLabel.text = stringRenderingOfDonationGivenDate;
    self.donorMessageCopyLabel.text = comments.donorMessageCopy;
}

@end
