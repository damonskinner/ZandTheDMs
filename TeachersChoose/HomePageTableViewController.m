//
//  HomePageTableViewController.m
//  TeachersChoose
//
//  Created by Damon Skinner on 4/8/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "HomePageTableViewController.h"
#import "FISDonorsChooseProposal.h"
#import "FISDonorsChooseCompletedProposal.h"
#import "ProposalTableViewCell.h"
#import "DetailsTabBarController.h"
#import "UIColor+DonorsChooseColors.h"
#import "UIFont+DonorsChooseFonts.h"
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

    
    
    self.navigationController.navigationBar.barTintColor=[UIColor DonorsChooseOrange];
    self.title=@"Home";
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName : [UIColor DonorsChooseGreyLight],NSFontAttributeName:[UIFont fontWithName:DonorsChooseBoldFont size:25]}];
    self.navigationController.navigationItem.backBarButtonItem.tintColor=[UIColor DonorsChooseGreyVeryLight];
    
    
    [self.tableView setSeparatorColor:[UIColor DonorsChooseBlueBorder]];

    
    [self.view removeConstraints:self.view.constraints];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
//    [self.tableView removeConstraints:self.tableView.constraints];
//    
//    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIImage *gearIconImage = [[FAKIonIcons gearAIconWithSize:25] imageWithSize:CGSizeMake(25,25)] ;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:gearIconImage style:UIBarButtonItemStylePlain target:self action:@selector(segueToSettingsPage)];
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor DonorsChooseGreyVeryLight];
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
    
    if (indexPath.section==0) {
        return 200;
    } else {
        return 140;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    if (section==0) {
        return [self.datastore.loggedInTeacherProposals count];
    } else {
        return [self.datastore.loggedInTeacherCompletedProposals count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"proposalCell";
    
    ProposalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell==nil) {
        [tableView registerNib:[UINib nibWithNibName:@"ProposalTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    
    if(indexPath.section==0) {
        cell.proposal = [self.datastore.loggedInTeacherProposals objectAtIndex:indexPath.row];
    } else if (indexPath.section ==1) {
        cell.proposal = [self.datastore.loggedInTeacherCompletedProposals objectAtIndex:indexPath.row];
    }
    
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    return NO;
}


-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    
    if(section ==0) {
        headerLabel.text = @"Current Proposals";
    } else {
        headerLabel.text = @"Completed Proposals";
    }
    headerLabel.font = [UIFont fontWithName:DonorsChooseBoldFont size:20];
    headerLabel.textColor = [UIColor DonorsChooseGreyVeryLight];
    
    [view addSubview:headerLabel];
    view.backgroundColor = [UIColor DonorsChooseOrange];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"selected row: %ld", indexPath.row);
    
    DetailsTabBarController *tabBarController = [[DetailsTabBarController alloc] init];
    
    
    
    if (indexPath.section ==0) {
        FISDonorsChooseProposal *selectedProposal= self.datastore.loggedInTeacherProposals[indexPath.row];
        tabBarController.navigationItem.title = selectedProposal.title;
        tabBarController.selectedProposal=selectedProposal;
        
    } else {
        FISDonorsChooseCompletedProposal *selectedProposal = self.datastore.loggedInTeacherCompletedProposals[indexPath.row];
        tabBarController.navigationItem.title = selectedProposal.title;
        tabBarController.selectedProposal=selectedProposal;
        
    }
    
    
    
    
    
    [self.navigationController pushViewController:tabBarController animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
