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
#import "DetailsTabBarController.h"


@interface MainTableViewViewController ()

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) NSMutableArray *proposalsArray;

@end

@implementation MainTableViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datastore = [FISDonorsChooseDatastore sharedDataStore];
    
    [self.view removeConstraints:self.view.constraints];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;

    [self.mainTableView removeConstraints:self.mainTableView.constraints];

    self.mainTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.proposalsArray = [[NSMutableArray alloc] init];
    
    for (FISDonorsChooseProposal *eachProposal in self.datastore.loggedInTeacherProposals){
        Proposal *newLocalProposal = [[Proposal alloc] initWithProposalTitle:eachProposal.title proposalExpirationDate:eachProposal.expirationDate proposalCostToComplete:eachProposal.costToComplete];
        [self.proposalsArray addObject:newLocalProposal];
        
    }

    NSLayoutConstraint *mainTableViewTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.mainTableView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:50];
    
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

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    
    return [self.proposalsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProposalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
    
    cell.proposal = [self.proposalsArray objectAtIndex:indexPath.row];
    
//    self.mainTableView.rowHeight = UITableViewAutomaticDimension;
//    self.mainTableView.estimatedRowHeight = 100.0;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected row: %ld", indexPath.row);
    
    // make the tab bar controller
    DetailsTabBarController *tabBarController = [[DetailsTabBarController alloc] init];

    
    //static for now
    FISDonorsChooseProposal *selectedProposal = self.datastore.loggedInTeacherProposals[indexPath.row];
    
    
    tabBarController.navigationItem.title = selectedProposal.title;
    tabBarController.selectedProposal=selectedProposal;
    // move to it (all the child VCs are setup in viewDidLoad of DetailsTabBarController)
//    [self.navigationController showViewController: tabBarController sender:nil];
    
    [self.navigationController pushViewController:tabBarController animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
