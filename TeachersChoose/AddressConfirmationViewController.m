//
//  AddressConfirmationViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/9/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "AddressConfirmationViewController.h"
#import <FAKIonIcons.h>

@interface AddressConfirmationViewController ()

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *checkbox;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end

@implementation AddressConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupKeyboardDismissalOnTouch];
    self.nextButton.layer.cornerRadius = 10;
    [self setupCheckbox];
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

-(void) setupCheckbox
{
    UIImage *emptyCheckbox = [[FAKIonIcons iosCircleOutlineIconWithSize:50] imageWithSize:CGSizeMake(50,50)];
    UIImage *checkedCheckbox = [[FAKIonIcons iosCheckmarkIconWithSize:50] imageWithSize:CGSizeMake(50,50)];
    
    [self.checkbox setImage: emptyCheckbox forState:UIControlStateNormal];
    [self.checkbox setImage: checkedCheckbox forState:UIControlStateSelected];
    [self.checkbox addTarget:self action:@selector(toggleCheckbox:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)toggleCheckbox:(id)sender
{
    UIButton *thisButton = sender;
    thisButton.selected = !thisButton.selected;
    [self evaluateCheckbox];
}

- (BOOL) evaluateCheckbox
{
    if ([self.checkbox isSelected])
    {
        self.nextButton.enabled = YES;
        self.nextButton.backgroundColor = [UIColor colorWithRed:0.106 green:0.761 blue:0.106 alpha:1.000];
        return YES;
    }
    else
    {
        self.nextButton.enabled = NO;
        self.nextButton.backgroundColor = [UIColor lightGrayColor];
        return NO;
    }
}

#pragma mark - Navigation

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    
    if(![self evaluateCheckbox])
        [self presentAlert];
    
    return [self evaluateCheckbox];
}

-(void) presentAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Unconfirmed Address" message:@"First, confirm your address by tapping the circle next to the confirmation statement." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction: okayAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
