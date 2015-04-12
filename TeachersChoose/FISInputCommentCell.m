//
//  FISCommentCell.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/12/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "FISInputCommentCell.h"
#import "FISComment.h"


@interface FISInputCommentCell () <UITextViewDelegate>

@property (strong, nonatomic) UITextView *myTextView;
-(void) formatCellWithPlaceholder:(NSString *)placeholder;
@end

@implementation FISInputCommentCell

#pragma mark - Cell LifeCycle

-(void)setPlaceholder:(NSString *)placeholder
{
    self.myTextView = [[UITextView alloc] init];
    self.myTextView.delegate = self;

    [self constrainTextView: self.myTextView];
    [self formatCellWithPlaceholder: placeholder];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if(selected)
    {
        [self.myTextView becomeFirstResponder];
    } else
    {
        [self.myTextView resignFirstResponder];
    }
}

#pragma mark - Formatting

-(void)formatCellWithPlaceholder:(NSString *)placeholder
{
    self.myTextView.text = placeholder;
    self.myTextView.scrollEnabled = NO;
    self.myTextView.textAlignment = NSTextAlignmentCenter;
    self.myTextView.font = self.textLabel.font;
    self.myTextView.textColor = [UIColor lightGrayColor];
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

@end
