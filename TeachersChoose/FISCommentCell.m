//
//  FISCommentCell.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/12/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "FISCommentCell.h"
#import "FISComment.h"


@interface FISCommentCell () <UITextViewDelegate>

@property (strong, nonatomic) UITextView *myTextView;
-(void) formatCellWithDonorComment:(FISComment*) comment;
-(void) formatCellWithTeacherComment:(FISComment*) comment;
@end

@implementation FISCommentCell



-(void)setComment:(FISComment *)comment
{
    if(comment.commentType == CommentFromDonor){
        [self formatCellWithDonorComment:comment]; }
    else {
        [self formatCellWithTeacherComment:comment]; }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.text = @"";
    textView.textAlignment = NSTextAlignmentRight;
    textView.textColor = [UIColor blackColor];
}

-(void)textViewDidChange:(UITextView *)textView
{
    [self.parentTableView beginUpdates];
    [self.parentTableView endUpdates];
}

#pragma mark - Helpers

-(void) formatCellWithDonorComment:(FISComment*) comment
{
    self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.textLabel.numberOfLines = 0;
    self.textLabel.text = comment.commentBody;
}

-(void) formatCellWithTeacherComment:(FISComment*) comment
{
    self.myTextView = [[UITextView alloc] init];
    [self constrainTextView: self.myTextView];
    self.myTextView.delegate = self;
    self.myTextView.scrollEnabled = NO;
    self.myTextView.textAlignment = NSTextAlignmentCenter;
    self.myTextView.font = self.textLabel.font;
    self.myTextView.text = comment.commentBody;
    self.myTextView.textColor = [UIColor lightGrayColor];
    
    // add it to the cell
}

-(void) constrainTextView:(UITextView *) textView
{
    [self.contentView addSubview: textView];
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{@"tv":textView};

    NSArray *horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tv]|" options:0 metrics:nil views:views];
    [self.contentView addConstraints:horizontal];
    
    NSArray *vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tv]|" options:0 metrics:nil views:views];
    [self.contentView addConstraints:vertical];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if(selected)
    {
        [self.myTextView becomeFirstResponder];
    }else
    {
        [self.myTextView resignFirstResponder];
    }
}




@end
