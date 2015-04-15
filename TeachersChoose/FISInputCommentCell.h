//
//  FISCommentCell.h
//  TeachersChoose
//
//  Created by Tom OMalley on 4/12/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FISComment;
@interface FISInputCommentCell : UITableViewCell

@property (strong, nonatomic) NSString *placeholder;
@property (strong, nonatomic) UITableView *parentTableView;

@end
