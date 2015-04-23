//
//  MailingLabelViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/21/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "MailingLabelViewController.h"
#import "UIColor+DonorsChooseColors.h"
#import <FAKIonIcons.h>

@interface MailingLabelViewController ()
@property (weak, nonatomic) IBOutlet UIView *labelBackground;
@property (weak, nonatomic) IBOutlet UIButton *printButton;

@end

@implementation MailingLabelViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.printButton.backgroundColor = [UIColor DonorsChooseOrange];
	self.printButton.layer.cornerRadius = 10;
	FAKIonIcons *printIcon = [FAKIonIcons printerIconWithSize:62.5];
	[self.printButton setAttributedTitle:[printIcon attributedString] forState:UIControlStateNormal];
	[self.printButton setTintColor:[UIColor whiteColor]];
	self.labelBackground.backgroundColor = [UIColor DonorsChooseOrange];
	self.labelBackground.layer.cornerRadius = 10;
}

- (IBAction)printButtonTapped:(id)sender {
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Print Error" message:@"No shared printers detected in range" preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
	[alertController addAction:ok];
	[self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)moreInfoTapped:(id)sender {
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Shipping Label" message:@"This is a prepaid label for sending your student's Thank You letters, due as part of your Thank You Package." preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
	[alertController addAction:ok];
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
