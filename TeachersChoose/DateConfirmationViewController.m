//
//  DateConfirmationViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/15/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "DateConfirmationViewController.h"

@interface DateConfirmationViewController ()
@property (weak, nonatomic) IBOutlet UIButton *confirmDateButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@end

@implementation DateConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.confirmDateButton.layer.cornerRadius = 10;
    [self setupDatePicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self presentAlert];
}

#pragma mark - DatePicker

-(void) setupDatePicker
{
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.minimumDate = [NSDate date];
    self.datePicker.maximumDate = [self calculateMaximumDate];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end