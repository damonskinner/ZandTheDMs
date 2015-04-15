//
//  FISCommentCell.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/12/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "FISInputCommentCell.h"
#import "FISComment.h"
#import "FISCommentInputAccessoryView.h"
#import "UIColor+DonorsChooseColors.h"

@interface FISInputCommentCell () <UITextViewDelegate>

@property (strong, nonatomic) UITextView *myTextView;
@property (strong, nonatomic) FISCommentInputAccessoryView *textViewInputAccessoryView;

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

-(FISCommentInputAccessoryView *)textViewInputAccessoryView{
    if(!_textViewInputAccessoryView)
    {
        _textViewInputAccessoryView = [self createInputAccessoryView];
    }
    return _textViewInputAccessoryView;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [textView setInputAccessoryView: self.textViewInputAccessoryView];
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.text = @"";
    textView.textAlignment = NSTextAlignmentRight;
    textView.textColor = [UIColor blackColor];
    [self handleSaveButton];
}

-(void)textViewDidChange:(UITextView *)textView
{
    [self.parentTableView beginUpdates];
    [self.parentTableView endUpdates];
    [self handleSaveButton];
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

-(void) handleSaveButton
{
    if (self.myTextView.text.length > 0) {
        [self.textViewInputAccessoryView.saveButton setEnabled: YES];
        self.textViewInputAccessoryView.saveButton.backgroundColor = [UIColor DonorsChooseOrange];
    }
    else{
        [self.textViewInputAccessoryView.saveButton setEnabled: NO];
        self.textViewInputAccessoryView.saveButton.backgroundColor = [UIColor lightGrayColor];
    }
}
#pragma mark - InputAccessoryView

-(FISCommentInputAccessoryView*)createInputAccessoryView
{
    FISCommentInputAccessoryView *inputAccessoryView = [[FISCommentInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];

    [inputAccessoryView.cancelButton addTarget:self action:@selector(cancelButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [inputAccessoryView.saveButton addTarget:self action:@selector(saveButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    return inputAccessoryView;
}

-(void) cancelButtonTapped
{
    NSLog(@"Cancel tapped");
    [self.myTextView resignFirstResponder];
    [self formatCellWithPlaceholder: @"Tap here to reply"];
}

-(void) saveButtonTapped
{
    NSLog(@"save tapped");
}

@end
