//
//  CommentCell.h
//  TeachersChoose
//
//  Created by Cooper Veysey on 4/7/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Comments;

@interface CommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *donorNameFromLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *donationGivenDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *donorCommentLabel;

@property (strong,nonatomic) Comments *comments;

@end
