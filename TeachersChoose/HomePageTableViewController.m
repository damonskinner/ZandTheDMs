//
//  HomePageTableViewController.m
//  TeachersChoose
//
//  Created by Damon Skinner on 4/8/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "HomePageTableViewController.h"
#import "FISDonorsChooseProposal.h"
#import "ProposalTableViewCell.h"
#import "DetailsTabBarController.h"
#import "UIColor+DonorsChooseColors.h"
#import <FAKIonIcons.h>

@interface HomePageTableViewController ()

@end

@implementation HomePageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datastore = [FISDonorsChooseDatastore sharedDataStore];
    
    [self setHeaderImage:self.datastore.loggedInTeacher.image];
    [self setTitleText:self.datastore.loggedInTeacher.name];
    [self setSubtitleText:self.datastore.loggedInTeacher.schoolName];

    
    
    self.navigationController.navigationBar.barTintColor=[UIColor DonorsChooseGreyVeryLight];
    
    self.title = self.datastore.loggedInTeacher.name;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName : [UIColor DonorsChooseOrange]}];
    [self.tableView setSeparatorColor:[UIColor DonorsChooseBlueBorder]];
    
    
    [self.view removeConstraints:self.view.constraints];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
//    [self.tableView removeConstraints:self.tableView.constraints];
//    
//    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIImage *gearIconImage = [[FAKIonIcons gearAIconWithSize:25] imageWithSize:CGSizeMake(25,25)] ;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:gearIconImage style:UIBarButtonItemStylePlain target:self action:@selector(segueToSettingsPage)];
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor DonorsChooseGrey];
//    
//    
//    
//    
//    NSLayoutConstraint *mainTableViewTopConstraint =
//    [NSLayoutConstraint constraintWithItem:self.tableView
//                                 attribute:NSLayoutAttributeTop
//                                 relatedBy:NSLayoutRelationEqual
//                                    toItem:self.view
//                                 attribute:NSLayoutAttributeTop
//                                multiplier:1.0
//                                  constant:0];
//    
//    [self.view addConstraint:mainTableViewTopConstraint];
//    
//    NSLayoutConstraint *mainTableViewRightConstraint =
//    [NSLayoutConstraint constraintWithItem:self.tableView
//                                 attribute:NSLayoutAttributeRight
//                                 relatedBy:NSLayoutRelationEqual
//                                    toItem:self.view
//                                 attribute:NSLayoutAttributeRight
//                                multiplier:1.0
//                                  constant:0];
//    
//    [self.view addConstraint:mainTableViewRightConstraint];
//    
//    NSLayoutConstraint *mainTableViewLeftConstraint =
//    [NSLayoutConstraint constraintWithItem:self.tableView
//                                 attribute:NSLayoutAttributeLeft
//                                 relatedBy:NSLayoutRelationEqual
//                                    toItem:self.view
//                                 attribute:NSLayoutAttributeLeft
//                                multiplier:1.0
//                                  constant:0];
//    
//    [self.view addConstraint:mainTableViewLeftConstraint];
//    
//    NSLayoutConstraint *mainTableViewBottomConstraint =
//    [NSLayoutConstraint constraintWithItem:self.tableView
//                                 attribute:NSLayoutAttributeBottom
//                                 relatedBy:NSLayoutRelationEqual
//                                    toItem:self.view
//                                 attribute:NSLayoutAttributeBottom
//                                multiplier:1.0
//                                  constant:0];
//    
//    [self.view addConstraint:mainTableViewBottomConstraint];
//    
//    NSLayoutConstraint *mainTableViewCenteringXConstraint =
//    [NSLayoutConstraint constraintWithItem:self.tableView
//                                 attribute:NSLayoutAttributeCenterX
//     
//                                 relatedBy:NSLayoutRelationEqual
//                                    toItem:self.view
//                                 attribute:NSLayoutAttributeCenterX
//                                multiplier:1.0
//                                  constant:0];
//    
//    [self.view addConstraint:mainTableViewCenteringXConstraint];
//    
//    //     Do any additional setup after loading the view.
//    [self.tableView reloadData];
    
}

-(void) segueToSettingsPage {
    
}



-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return 200;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    
    return [self.datastore.loggedInTeacherProposals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"proposalCell";
    
    ProposalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell==nil) {
        [tableView registerNib:[UINib nibWithNibName:@"ProposalTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    
    
    cell.proposal = [self.datastore.loggedInTeacherProposals objectAtIndex:indexPath.row];
    
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected row: %ld", indexPath.row);
    
    DetailsTabBarController *tabBarController = [[DetailsTabBarController alloc] init];
    
    FISDonorsChooseProposal *selectedProposal = self.datastore.loggedInTeacherProposals[indexPath.row];
    
    
    tabBarController.navigationItem.title = selectedProposal.title;
    tabBarController.selectedProposal=selectedProposal;
    
    [self.navigationController pushViewController:tabBarController animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
