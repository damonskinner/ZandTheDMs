//
//  FISCommentCell.h
//  TeachersChoose
//
//  Created by Tom OMalley on 4/12/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FISComment;
@class FISCommentInputAccessoryView;
@class CommentsViewController;


@protocol CommentCellDelegate <NSObject>

-(void) saveDonationWithMessage: (NSString *) responseMessage andIndexPath: (NSIndexPath *) indexPath;

@end

@interface FISInputCommentCell : UITableViewCell

@property (strong, nonatomic) NSString *placeholder;
@property (strong, nonatomic) FISCommentInputAccessoryView *textViewInputAccessoryView;

@property (strong, nonatomic) id <CommentCellDelegate> CommentsViewController;

@end
