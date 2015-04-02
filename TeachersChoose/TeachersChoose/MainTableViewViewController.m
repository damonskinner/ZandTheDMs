//
//  MainTableViewViewController.m
//  TeachersChoose
//
//  Created by Cooper Veysey on 4/2/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "MainTableViewViewController.h"

@interface MainTableViewViewController ()

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) NSMutableArray *proposalsArray;

@end

@implementation MainTableViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view removeConstraints:self.view.constraints];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView removeConstraints:self.mainTableView.constraints];
    self.mainTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.proposalsArray = [NSMutableArray arrayWithObjects:@"proposal1",@"proposal2",@"proposal3",@"proposal4", nil];
    
    NSLayoutConstraint *mainTableViewTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.mainTableView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:0];
    
    [self.view addConstraint:mainTableViewTopConstraint];
    
    NSLayoutConstraint *mainTableViewRightConstraint =
    [NSLayoutConstraint constraintWithItem:self.mainTableView
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:0];
    
    [self.view addConstraint:mainTableViewRightConstraint];
    
    NSLayoutConstraint *mainTableViewLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.mainTableView
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:0];
    
    [self.view addConstraint:mainTableViewLeftConstraint];
    
    NSLayoutConstraint *mainTableViewBottomConstraint =
    [NSLayoutConstraint constraintWithItem:self.mainTableView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0];
    
    [self.view addConstraint:mainTableViewBottomConstraint];
    
    NSLayoutConstraint *mainTableViewCenteringXConstraint =
    [NSLayoutConstraint constraintWithItem:self.mainTableView
                                 attribute:NSLayoutAttributeCenterX
     
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0];
    
    [self.view addConstraint:mainTableViewCenteringXConstraint];
//     Do any additional setup after loading the view.
    NSLog(@"main TVVC view did load");
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    NSLog(@"main TVVC view did appear");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    
    return [self.proposalsArray count];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    // The header for the section is the region name -- get this from the region at the section index.
//    Region *region = [regions objectAtIndex:section];
//    return [region name];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.proposalsArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
