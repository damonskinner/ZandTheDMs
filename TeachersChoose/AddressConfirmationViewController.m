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

@end

@implementation AddressConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.nextButton.layer.cornerRadius = 10;
    [self setupCheckbox];
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

- (void) evaluateCheckbox
{
    if ([self.checkbox isSelected])
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
