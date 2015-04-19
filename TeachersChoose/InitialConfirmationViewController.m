//
//  InitialConfirmationViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/7/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "InitialConfirmationViewController.h"
#import <FAKIonIcons.h>

@interface InitialConfirmationViewController ()

@property (strong, nonatomic) UIImage *emptyCheckbox;
@property (strong, nonatomic) UIImage *checkedCheckbox;

@property (weak, nonatomic) IBOutlet UIButton *checkbox1;
@property (weak, nonatomic) IBOutlet UIButton *checkbox2;
@property (weak, nonatomic) IBOutlet UIButton *checkbox3;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

-(void) setupCheckboxes;
-(void) setupUIButtonCheckbox: (UIButton *) checkbox;
-(void) toggleCheckbox:(id)sender;
-(BOOL) evaluateCheckboxes;

@end

@implementation InitialConfirmationViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nextButton.layer.cornerRadius = 10;
    [self setupCheckboxes];
}

#pragma mark - Navigation

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    
    if(![self evaluateCheckboxes])
        [self presentAlert];
    
    return [self evaluateCheckboxes];
}

-(void) presentAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Incomplete" message:@"First, confirm all statements by tapping the circles next to them." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        BOOL anyCheckboxIsSelected = ([self.checkbox1 isSelected] || [self.checkbox2 isSelected] || [self.checkbox3 isSelected]);

        if (!anyCheckboxIsSelected)
            [self animateCheckboxForUser];
    }];
    
    [alertController addAction: okayAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Checkbox Methods

-(void) setupCheckboxes
{
    self.emptyCheckbox = [[FAKIonIcons iosCircleOutlineIconWithSize:50] imageWithSize:CGSizeMake(50,50)];
    self.checkedCheckbox = [[FAKIonIcons iosCheckmarkIconWithSize:50] imageWithSize:CGSizeMake(50,50)];
    
    [self setupUIButtonCheckbox: self.checkbox1];
    [self setupUIButtonCheckbox: self.checkbox2];
    [self setupUIButtonCheckbox: self.checkbox3];
}

-(void) setupUIButtonCheckbox: (UIButton *) checkbox
{
    [checkbox setImage:self.emptyCheckbox forState:UIControlStateNormal];
    [checkbox setImage:self.checkedCheckbox forState:UIControlStateSelected];
    [checkbox addTarget:self action:@selector(toggleCheckbox:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)toggleCheckbox:(id)sender
{
    UIButton *thisButton = sender;
    thisButton.selected = !thisButton.selected;
    [self evaluateCheckboxes];
}

- (BOOL) evaluateCheckboxes
{
    BOOL allBoxesChecked = ([self.checkbox1 isSelected] &&
                            [self.checkbox2 isSelected] &&
                            [self.checkbox3 isSelected]);
    
    if (allBoxesChecked) {
        self.nextButton.backgroundColor = [UIColor colorWithRed:0.106 green:0.761 blue:0.106 alpha:1.000];
        return YES;
    }
    else {
        self.nextButton.backgroundColor = [UIColor lightGrayColor];
        return NO;
    }
}

-(void) animateCheckboxForUser
{
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options: 0
                     animations:^{
                         self.checkbox1.selected = YES;
                         self.checkbox1.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);                     }
                     completion:^(BOOL finished) {
                         if (finished)
                         {
                             [UIView animateWithDuration:0.5 animations:^{
                                 self.checkbox1.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                             } completion:^(BOOL finished) {
                                 if(finished)
                                     self.checkbox1.selected = NO;
                             }];
                         }
                     }];
}

@end
