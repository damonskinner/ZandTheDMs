//
//  FISCommentCell.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/12/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "FISInputCommentCell.h"
#import "FISConstants.h"
#import "FISCommentInputAccessoryView.h"
#import "UIColor+DonorsChooseColors.h"
#import "UIFont+DonorsChooseFonts.h"

@interface FISInputCommentCell () <UITextViewDelegate>

@property (strong, nonatomic) UITableView *parentTableView;

-(void) formatCellWithPlaceholder:(NSString *)placeholder;

-(void) constrainTextView:(UITextView *) textView;

-(FISCommentInputAccessoryView *)createInputAccessoryView;
-(void) cancelButtonTapped;
-(void) saveButtonTapped;
-(void) handleSaveButton;

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

-(UITableView *)parentTableView
{
    // get the superview
    id view = [self superview];
    
    // if the superview exists and is NOT a tableview, keep going up
    while (view && [view isKindOfClass:[UITableView class]] == NO) {
        view = [view superview];
    }

    // cast it
    UITableView *tableView = (UITableView *)view;
    
    return tableView;
}

#pragma mark - Formatting

-(void)formatCellWithPlaceholder:(NSString *)placeholder
{
    self.myTextView.text = placeholder;
    self.myTextView.scrollEnabled = NO;
    self.myTextView.backgroundColor=[UIColor DonorsChooseGreyLight];
    self.myTextView.textAlignment = NSTextAlignmentCenter;
    self.myTextView.font = [UIFont fontWithName:DonorsChooseBodyItalicFont size:17];
    self.myTextView.textColor = [UIColor DonorsChooseOrange];
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
    textView.font = [UIFont fontWithName:DonorsChooseBodyBasicFont size:17];
    textView.textAlignment = NSTextAlignmentCenter;
    textView.textColor = [UIColor DonorsChooseBlack];
    [self handleSaveButton];
    
    [self.delegate textFieldWasTappedWithTextView:textView];
}

-(void)textViewDidChange:(UITextView *)textView
{
//    [UIView setAnimationsEnabled:NO];
    [self.parentTableView beginUpdates];
    [self.parentTableView endUpdates];
//     [UIView setAnimationsEnabled:YES];
    [self handleSaveButton];
}

#pragma mark - InputAccessoryView

-(FISCommentInputAccessoryView *)createInputAccessoryView
{
    FISCommentInputAccessoryView *inputAccessoryView = [[FISCommentInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];

    [inputAccessoryView.cancelButton addTarget:self action:@selector(cancelButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [inputAccessoryView.saveButton addTarget:self action:@selector(saveButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    return inputAccessoryView;
}

- (void) keyboardWillShow:(NSNotification *)note {
    NSDictionary *userInfo = [note userInfo];
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // move the view up by 30 pts
    CGRect frame = self.parentTableView.frame;
    frame.origin.y = -30;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.parentTableView.frame = frame;
    }];
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    // move the view back to the origin
    CGRect frame = self.parentTableView.frame;
    frame.origin.y = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.parentTableView.frame = frame;
    }];
    
    [self.parentTableView reloadData];
}


#pragma mark - IAV Helpers

-(void) handleSaveButton
{
    if (self.myTextView.text.length > 0) {
        [self.textViewInputAccessoryView.saveButton setEnabled: YES];
        self.textViewInputAccessoryView.saveButton.backgroundColor = [UIColor DonorsChooseOrange];
    } else{
        [self.textViewInputAccessoryView.saveButton setEnabled: NO];
        self.textViewInputAccessoryView.saveButton.backgroundColor = [UIColor lightGrayColor];
    }
}

-(void) cancelButtonTapped
{
    [self.myTextView resignFirstResponder];
    
    [self formatCellWithPlaceholder: INPUT_CELL_PLACEHOLDER];
}

-(void) saveButtonTapped
{
    [self.delegate saveDonationWithMessage:self.myTextView.text andIndexPath:[self.parentTableView indexPathForCell:self]];

    [self.myTextView resignFirstResponder];
    self.myTextView.editable = NO;
    self.myTextView.selectable = NO;
}

@end
