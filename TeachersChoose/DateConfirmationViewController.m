//
//  DateConfirmationViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/15/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "DateConfirmationViewController.h"
#import "UIColor+DonorsChooseColors.h"
#import <FAKIonIcons.h>


@interface DateConfirmationViewController ()
@property (weak, nonatomic) IBOutlet UIButton *confirmDateButton;
@property (weak, nonatomic) IBOutlet UIView *datePickerBackground;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@end

@implementation DateConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.confirmDateButton.layer.cornerRadius = 10;
    [self setupDatePicker];
    [self setupHomeButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - DatePicker

-(void) setupDatePicker
{
    self.datePickerBackground.backgroundColor = [UIColor DonorsChooseOrange];
    self.datePickerBackground.layer.cornerRadius = 10;
    self.datePicker.backgroundColor = [UIColor whiteColor];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.minimumDate = [NSDate date];
    self.datePicker.maximumDate = [self calculateMaximumDate];
}
- (IBAction)moreInfoTapped:(id)sender {
    [self presentAlert];
}

-(NSDate *) calculateMaximumDate{
    // just gonna do 90 days (roughly 3 months) past today
    return [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay value:90 toDate:[NSDate date] options:0];
}

-(void) presentAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Due Date For \nThank You Package" message:@"This will be the date you deliver your 'Thank You Package' by. For more information, visit DonorsChoose.org." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction: okayAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Home Button

-(void) setupHomeButton
{
    UIImage *homeIcon = [[FAKIonIcons iosHomeIconWithSize:30] imageWithSize:CGSizeMake(30, 30)];
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
