//
//  ImpactLetterViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/21/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "ImpactLetterViewController.h"
#import "UIColor+DonorsChooseColors.h"
#import "FISParseAPI.h"

static NSString* const TEXTVIEW_PLACEHOLDER = @"Tap here to begin your message";

@interface ImpactLetterViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *saveMessageButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *placeholderTextLabel;
@property (nonatomic) float pointsToResizeTextView;
@property (weak, nonatomic) IBOutlet UILabel *teacherNameLabel;

-(void) presentAlert;
-(void) setupTextViewAndKeyboard;
-(void) setupInputAccessoryView;
-(void) setupKeyboardDismissalOnTouch;
-(void) receivedKeyboardNotification:(NSNotification*) notification;

@end

@implementation ImpactLetterViewController

#pragma mark - View LifeCycle

- (IBAction)moreInfoTapped:(id)sender {
    [self presentAlert];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.teacherNameLabel.text = self.proposal.teacherName;
    
    [self setupTextViewAndKeyboard];
    self.saveMessageButton.layer.cornerRadius = 10;
    [self.saveMessageButton addTarget:self action:@selector(saveTapped:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

#pragma mark - UITextViewDelegate

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if(![self.placeholderTextLabel isHidden])
        [self.placeholderTextLabel setHidden:YES];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    NSString *trimmedText = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([trimmedText isEqualToString:@""]) {
        textView.text = @"";
        [self.placeholderTextLabel setHidden:NO];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        // pointsToResizeTextView setup in receivedKeyboardNotification:
        self.textViewHeightConstraint.constant += self.pointsToResizeTextView;
        [self.view layoutIfNeeded];
    }];
}

-(void) textViewDidChange:(UITextView *)textView
{
    NSString *trimmedText = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([trimmedText length] > 0) {
        self.saveMessageButton.enabled = YES;
        self.saveMessageButton.backgroundColor = [UIColor colorWithRed:0.106 green:0.761 blue:0.106 alpha:1.000];
    }
    else {
        self.saveMessageButton.enabled = NO;
        self.saveMessageButton.backgroundColor = [UIColor lightGrayColor];
    }
}

#pragma mark - Alert Controller

-(void) presentAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Impact Letter" message:@"Let your donors know how much funding this project has affected your students lives!\n\nFor safety purposes DO NOT include student names, school name, location, etc." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction: okayAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Helpers

-(void) setupTextViewAndKeyboard
{
    self.textView.delegate = self;
    self.textView.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedKeyboardNotification:) name:UIKeyboardWillShowNotification object:nil];
    [self setupKeyboardDismissalOnTouch];
    [self setupInputAccessoryView];
}

-(void) setupInputAccessoryView
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.textView action:@selector(resignFirstResponder)];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    toolbar.items = @[flexibleSpace, doneButton];
    
    self.textView.inputAccessoryView = toolbar;
}

-(void) setupKeyboardDismissalOnTouch
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self.textView action:@selector(resignFirstResponder)];
    [self.view addGestureRecognizer:tap];
}

-(void) receivedKeyboardNotification:(NSNotification*) notification
{
    NSValue*keyboardFrame = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect  keyboardRect = [keyboardFrame CGRectValue];
    
    //FIXME: IAV.height used to work, but for some reason 20 points extra was necessary. so, magic number 64.
    CGFloat keyboardTopY = keyboardRect.origin.y - 64;
    
    CGFloat textViewTopY = self.textView.superview.frame.origin.y;
    CGFloat textViewHeight = self.textView.frame.size.height;
    CGFloat textViewBottomY = textViewTopY + textViewHeight;
    
    self.pointsToResizeTextView = (textViewBottomY - keyboardTopY);
    
    [UIView animateWithDuration:0.5 animations:^{
        self.textViewHeightConstraint.constant -= self.pointsToResizeTextView;
        [self.view layoutIfNeeded];
    }];
    
    //    NSLog(@"kbty: %f", keyboardTopY);
    //    NSLog(@"tvby: %f", textViewBottomY);
    //    NSLog(@"diff: %f", self.amountToResizeTextView);
    
    //    NSLog(@"keyboard: %@", NSStringFromCGRect(keyboardRect));
    //    NSLog(@"supervw : %@", NSStringFromCGRect(self.textView.superview.frame));
    //    NSLog(@"textview: %@", NSStringFromCGRect(self.textView.frame));
    //    NSLog(@"IAV     : %@", NSStringFromCGRect(self.textView.inputAccessoryView.frame));
}


-(void) saveTapped: (id) sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Upload Confirmed" message: @"Congatulations!  Your impact letter has been successfully uploaded!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction: okayAction];
    

    [FISParseAPI saveThankYouPackageForProposal:self.proposal withCompletionDictionary:self.proposal.completionInfo andCompletionBlock:^{
        [self presentViewController:alertController animated:YES completion:nil];
    }];
}

@end
