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
    
    FISDonorsChooseProposal *firstProposal=self.datastore.loggedInTeacherProposals[0];

//    FISDonorsChooseProposal *secondProposal=self.datastore.loggedInTeacherProposals[1];
//    FISDonorsChooseProposal *thirdProposal=self.datastore.loggedInTeacherProposals[2];
//    self.proposalsArray = [NSMutableArray arrayWithObjects:firstProposal.title, nil];
    
//    Proposal *proposal0 = [[Proposal alloc]]
    
    Proposal *proposal1 = [[Proposal alloc]initWithProposalTitle:firstProposal.title
                                          proposalExpirationDate:firstProposal.expirationDate
                                             proposalNeedMessage:firstProposal.fulfillmentTrailer];
    
    Proposal *proposal2 = [[Proposal alloc]initWithProposalTitle:@"We Need a Science Lab!"                      proposalExpirationDate:@"May 13, 2015"
                                             proposalNeedMessage:@"My students need an area designed for science experiments. With six tables and 32 chairs, I can create a science lab ideal for group work and experiments."];
    
    Proposal *proposal3 = [[Proposal alloc]initWithProposalTitle:@"We Need A Chair Upgrade!" proposalExpirationDate:@"Jun 17, 2015"
                                             proposalNeedMessage:@"My students need 25 Thera-Band Exercise Balls upon which to sit!!"];
    
    Proposal *proposal4 = [[Proposal alloc]initWithProposalTitle:@"Igniting Imagination" proposalExpirationDate:@"Apr 03, 2015"
                                             proposalNeedMessage:@"My students need a CD player with headphones and audio books such as Tale of a Fourth Grade Nothing and Ramona's World in order to build a classroom listening center!"];
    
    Proposal *proposal5 = [[Proposal alloc]initWithProposalTitle:@"Fulfill Our Dream of a Document Camera!" proposalExpirationDate:@"Jun 14, 2015"
                                             proposalNeedMessage:@"My students need a document camera to make class time more efficient."];
    
    Proposal *proposal6 = [[Proposal alloc]initWithProposalTitle:@"Bookshelves, Bookshelves, Please!" proposalExpirationDate:@"Jun 23, 2015"
                                             proposalNeedMessage:@"My students need these bookshelves to easily find books during the class day. These bookshelves will show title to book and it has easy access for my students."];
    
    Proposal *proposal7 = [[Proposal alloc]initWithProposalTitle:@"Robotics in the Classroom" proposalExpirationDate:@"May 13, 2015"
                                             proposalNeedMessage:@"My students need five EV3 robotics kits and resource book, five sets of repair tools, and five storage containers to continue their studies in design, engineering and   programming."];

    self.proposalsArray = [NSMutableArray arrayWithObjects:proposal1,proposal2,proposal3, proposal4,proposal5,proposal6,proposal7,nil];
    
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

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    // The header for the section is the region name -- get this from the region at the section index.
//    Region *region = [regions objectAtIndex:section];
//    return [region name];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProposalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
    cell.proposal = [self.proposalsArray objectAtIndex:indexPath.row];
    //I'm a cell, I have a proposal (see ProposalTableViewCell.h's proposal property for reference, and I want it to be SET to the proposal in my array
    
    return cell;
}

//
//- (void)setSubtitleForCell:(RWBasicCell *)cell item:(RSSItem *)item {
//    NSString *subtitle = item.mediaText ?: item.mediaDescription;
//    
//    // Some subtitles can be really long, so only display the
//    // first 200 characters
//    if (subtitle.length > 200) {
//        subtitle = [NSString stringWithFormat:@"%@...", [subtitle substringToIndex:200]];
//    }
//    
//    [cell.subtitleLabel setText:subtitle];
//}

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
