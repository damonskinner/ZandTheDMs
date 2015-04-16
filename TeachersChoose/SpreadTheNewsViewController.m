//
//  GoodNewsViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/16/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "SpreadTheNewsViewController.h"

@interface SpreadTheNewsViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveMessageButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation SpreadTheNewsViewController

- (void)viewDidLoad {
    self.textView.delegate = self;
    self.saveMessageButton.layer.cornerRadius = 10;
    [super viewDidLoad];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    [self presentAlert];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITextViewDelegate

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.text = @"";
    textView.textColor = [UIColor blackColor];
    textView.textAlignment = NSTextAlignmentLeft;
}


-(void) presentAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Thank You Message" message:@"This note will be publicly viewable on your project page and cannot be changed.\n\nFor safety purposes DO NOT include your name, school name, location, etc." preferredStyle:UIAlertControllerStyleAlert];
    
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
