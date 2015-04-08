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

-(void) setupCheckboxes;
-(void) setupUIButtonCheckbox: (UIButton *) checkbox;
-(void) toggleCheckbox:(id)sender;

@end

@implementation InitialConfirmationViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
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
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
