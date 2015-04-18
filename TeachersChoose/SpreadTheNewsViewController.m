//
//  GoodNewsViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/16/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "SpreadTheNewsViewController.h"

static NSString* const TEXTVIEW_PLACEHOLDER = @"Tap here to begin your message";

@interface SpreadTheNewsViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *saveMessageButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;

@property (nonatomic) float amountToResizeTextView;

@end

@implementation SpreadTheNewsViewController


#pragma mark - View LifeCycle

- (void)viewDidLoad {
    self.textView.delegate = self;
    self.textView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.saveMessageButton.layer.cornerRadius = 10;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedKeyboardNotification:) name:UIKeyboardWillShowNotification object:nil];
    
    [self setupKeyboardDismissalOnTouch];
    [self createInputAccessoryView];
    [super viewDidLoad];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    [self presentAlert];
}

#pragma mark - Alert Controller

-(void) presentAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Brief Thank You Message" message:@"This note will be publicly viewable on your project page and cannot be changed.\n\nFor safety purposes DO NOT include your name, school name, location, etc." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction: okayAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UITextViewDelegate

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:  TEXTVIEW_PLACEHOLDER])
    {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        textView.textAlignment = NSTextAlignmentLeft;
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = TEXTVIEW_PLACEHOLDER;
        textView.textColor = [UIColor lightGrayColor];
        textView.textAlignment = NSTextAlignmentCenter;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        // amountToResizeTextView setup in receivedKeyboardNotification:
        self.textViewHeightConstraint.constant += (self.amountToResizeTextView);
        [self.view layoutIfNeeded];
    }];
}

-(void) textViewDidChange:(UITextView *)textView
{
    if ([textView.text length] > 3) {
        self.saveMessageButton.enabled = YES;
        self.saveMessageButton.backgroundColor = [UIColor colorWithRed:0.106 green:0.761 blue:0.106 alpha:1.000];
    }
    else {
        self.saveMessageButton.enabled = NO;
        self.saveMessageButton.backgroundColor = [UIColor lightGrayColor];
    }
}

#pragma mark - Keyboard / InputAccessoryView

-(void) receivedKeyboardNotification:(NSNotification*) notification
{
    NSValue*keyboardFrame = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect  keyboardRect = [keyboardFrame CGRectValue];
    CGFloat keyboardTopY = keyboardRect.origin.y;
//    NSLog(@"kbty: %f", keyboardTopY);
    
    CGFloat textViewTopY = self.textView.superview.frame.origin.y;
    CGFloat textViewHeight = self.textView.frame.size.height;
    CGFloat textViewBottomY = textViewTopY + textViewHeight;
//    NSLog(@"tvby: %f", textViewBottomY);
    
    self.amountToResizeTextView = (textViewBottomY - keyboardTopY);
//    NSLog(@"diff: %f", self.amountToResizeTextView);
    
//    NSLog(@"keyboard: %@", NSStringFromCGRect(keyboardRect));
//    NSLog(@"supervw : %@", NSStringFromCGRect(self.textView.superview.frame));
//    NSLog(@"textview: %@", NSStringFromCGRect(self.textView.frame));
//    NSLog(@"IAV     : %@", NSStringFromCGRect(self.textView.inputAccessoryView.frame));
    
    [UIView animateWithDuration:0.5 animations:^{
        self.textViewHeightConstraint.constant -= (self.amountToResizeTextView);
        [self.view layoutIfNeeded];
    }];
}

-(void) createInputAccessoryView
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.textView action:@selector(resignFirstResponder)];

    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    toolbar.items = @[flexibleSpace, doneButton];

    self.textView.inputAccessoryView = toolbar;
}

-(void) setupKeyboardDismissalOnTouch
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void) dismissKeyboard
{
    [self.textView resignFirstResponder];
}

@end
