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
-(void) evaluateCheckboxes;

@end

@implementation InitialConfirmationViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nextButton.layer.cornerRadius = 10;
    [self setupCheckboxes];
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

- (void) evaluateCheckboxes
{
    BOOL allBoxesChecked = ([self.checkbox1 isSelected] && [self.checkbox2 isSelected] && [self.checkbox3 isSelected]);
    
    if (allBoxesChecked)
    {
        self.nextButton.enabled = YES;
        self.nextButton.backgroundColor = [UIColor colorWithRed:0.106 green:0.761 blue:0.106 alpha:1.000];
    }
    else
    {
        self.nextButton.enabled = NO;
        self.nextButton.backgroundColor = [UIColor lightGrayColor];
    }
}


@end
