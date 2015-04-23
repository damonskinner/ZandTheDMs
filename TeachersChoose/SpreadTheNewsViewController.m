//
//  GoodNewsViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/16/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "SpreadTheNewsViewController.h"
#import <FAKIonIcons.h>

static NSString *const TEXTVIEW_PLACEHOLDER = @"Tap here to begin your message";

@interface SpreadTheNewsViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *saveMessageButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *placeholderTextLabel;
@property (nonatomic) float pointsToResizeTextView;

- (void)presentAlert;
- (void)setupTextViewAndKeyboard;
- (void)setupInputAccessoryView;
- (void)setupKeyboardDismissalOnTouch;
- (void)receivedKeyboardNotification:(NSNotification *)notification;

@end

@implementation SpreadTheNewsViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad {
	[super viewDidLoad];

	[self setupTextViewAndKeyboard];
	self.saveMessageButton.layer.cornerRadius = 10;
	[self setupHomeButton];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (IBAction)moreInfoTapped:(id)sender {
	[self presentAlert];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
	if (![self.placeholderTextLabel isHidden])
		[self.placeholderTextLabel setHidden:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
	NSString *trimmedText = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

	if ([trimmedText isEqualToString:@""]) {
		textView.text = @"";
		[self.placeholderTextLabel setHidden:NO];
	}

	[UIView animateWithDuration:0.5 animations: ^{
	    self.textViewHeightConstraint.constant += self.pointsToResizeTextView;
	    [self.view layoutIfNeeded];
	}];
}

- (void)textViewDidChange:(UITextView *)textView {
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

- (void)presentAlert {
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Brief Thank You Message" message:@"This note will be publicly viewable on your project page and cannot be changed.\n\nFor safety purposes DO NOT include your name, school name, location, etc." preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];

	[alertController addAction:okayAction];

	[self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Helpers

- (void)setupTextViewAndKeyboard {
	self.textView.delegate = self;
	self.textView.autocorrectionType = UITextAutocorrectionTypeNo;

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedKeyboardNotification:) name:UIKeyboardWillShowNotification object:nil];
	[self setupKeyboardDismissalOnTouch];
	[self setupInputAccessoryView];
}

- (void)setupInputAccessoryView {
	UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];

	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.textView action:@selector(resignFirstResponder)];

	UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

	toolbar.items = @[flexibleSpace, doneButton];

	self.textView.inputAccessoryView = toolbar;
}

- (void)setupKeyboardDismissalOnTouch {
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self.textView action:@selector(resignFirstResponder)];
	[self.view addGestureRecognizer:tap];
}

- (void)receivedKeyboardNotification:(NSNotification *)notification {
	NSValue *keyboardFrame = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
	CGRect keyboardRect = [keyboardFrame CGRectValue];

	//FIXME: IAV.height used to work, but for some reason 20 points extra was necessary. so, magic number 64.
	CGFloat keyboardTopY = keyboardRect.origin.y - 64;

	CGFloat textViewTopY = self.textView.superview.frame.origin.y;
	CGFloat textViewHeight = self.textView.frame.size.height;
	CGFloat textViewBottomY = textViewTopY + textViewHeight;

	self.pointsToResizeTextView = (textViewBottomY - keyboardTopY);

	[UIView animateWithDuration:0.5 animations: ^{
	    self.textViewHeightConstraint.constant -= self.pointsToResizeTextView;
	    [self.view layoutIfNeeded];
	}];
}

#pragma mark - Home Button

- (void)setupHomeButton {
	UIImage *homeIcon = [[FAKIonIcons iosHomeIconWithSize:30] imageWithSize:CGSizeMake(30, 30)];
	[self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:homeIcon style:UIBarButtonItemStylePlain target:self action:@selector(homeButtonTapped)]];
}

- (void)homeButtonTapped {
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Return To Dashboard" message:@"Your progress from this page will not be saved." preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler: ^(UIAlertAction *action) {
	    [self dismissViewControllerAnimated:YES completion:nil];
	}];
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];

	[alertController addAction:cancelAction];
	[alertController addAction:okAction];

	[self presentViewController:alertController animated:YES completion:nil];
}

@end
