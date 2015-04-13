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

@property (strong, nonatomic) UITableView *parentTableView;
@property (strong, nonatomic) UITextView *myTextView;

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
    self.myTextView.textAlignment = NSTextAlignmentCenter;
    self.myTextView.font = self.textLabel.font;
    self.myTextView.textColor = [UIColor lightGrayColor];
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

-(UIView *)textViewInputAccessoryView{
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

#pragma mark - InputAccessoryView

-(FISCommentInputAccessoryView *)createInputAccessoryView
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
    [self.myTextView resignFirstResponder];
    self.myTextView.editable = NO;
    self.myTextView.selectable = NO;
    
    //    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Confirm Comment" message:@"Are you sure you're ready to save your message?" preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
//    UIAlertAction *submitAction = [UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:nil];
//    
//    [alertController addAction:cancelAction];
//    [alertController addAction:submitAction];
}

#pragma mark - IAV Helpers

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


@end
