//
//  MainTableViewViewController.m
//  TeachersChoose
//
//  Created by Cooper Veysey on 4/2/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "MainTableViewViewController.h"
#import "FISDonorsChooseProposal.h"
#import "ProposalTableViewCell.h"
#import "Proposal.h"
#import "StatDetailsViewController.h"
#import "DetailsTabBarController.h"
#import "UIColor+DonorsChooseColors.h"
#import <FAKIonIcons.h>



@interface MainTableViewViewController ()

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;


@end

@implementation MainTableViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datastore = [FISDonorsChooseDatastore sharedDataStore];
    self.navigationController.navigationBar.barTintColor=[UIColor DonorsChooseGreyVeryLight];
    
    self.title = self.datastore.loggedInTeacher.name;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                              NSForegroundColorAttributeName : [UIColor DonorsChooseOrange]}];
    [self.mainTableView setSeparatorColor:[UIColor DonorsChooseBlueBorder]];

    
    [self.view removeConstraints:self.view.constraints];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;


    [self.mainTableView removeConstraints:self.mainTableView.constraints];

    self.mainTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIImage *gearIconImage = [[FAKIonIcons gearAIconWithSize:25] imageWithSize:CGSizeMake(25,25)] ;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:gearIconImage style:UIBarButtonItemStylePlain target:self action:@selector(segueToSettingsPage)];
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor DonorsChooseGrey];
    


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
    [self.mainTableView reloadData];
    
}

-(void) segueToSettingsPage {
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    
    return [self.datastore.loggedInTeacherProposals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProposalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
    
    cell.proposal = [self.datastore.loggedInTeacherProposals objectAtIndex:indexPath.row];
    
//    self.mainTableView.rowHeight = UITableViewAutomaticDimension;
//    self.mainTableView.estimatedRowHeight = 100.0;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected row: %ld", (long)indexPath.row);
    
    DetailsTabBarController *tabBarController = [[DetailsTabBarController alloc] init];

    FISDonorsChooseProposal *selectedProposal = self.datastore.loggedInTeacherProposals[indexPath.row];
    
    
    tabBarController.navigationItem.title = [NSString stringWithFormat:@"Project Details"]; // selectedProposal.title;
    tabBarController.selectedProposal=selectedProposal;
    
    [self.navigationController pushViewController:tabBarController animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
