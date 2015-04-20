//
//  AddressConfirmationViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/9/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "AddressConfirmationViewController.h"
#import <FAKIonIcons.h>

@interface AddressConfirmationViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (weak, nonatomic) IBOutlet UIButton *editAddressButton;

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end

@implementation AddressConfirmationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.inputTextField.delegate = self;
    [self setupKeyboardDismissalOnTouch];
    self.editAddressButton.layer.cornerRadius = 10;
    self.nextButton.layer.cornerRadius = 10;
    [self setupHomeButton];
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
    [self.inputTextField resignFirstResponder];
}



#pragma mark - Edit Address Button

- (IBAction)editAddressTapped:(id)sender {
    [self presentAlert];
}

-(void) presentAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Contact Us" message:@"Changing your address requires confirmation by a DonorsChoose employee. Please call us at 555-555-5555." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction: okayAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Home Button

-(void) setupHomeButton
{
    UIImage *homeIcon = [[FAKIonIcons homeIconWithSize:30] imageWithSize:CGSizeMake(30, 30)];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:homeIcon style:UIBarButtonItemStylePlain target:self action:@selector(homeButtonTapped)]];
}

-(void) homeButtonTapped
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Return To Dashboard" message:@"Your progress from this page will not be saved." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
