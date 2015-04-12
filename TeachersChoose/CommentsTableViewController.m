//
//  CommentsTableViewController.m
//  TeachersChoose
//
//  Created by Cooper Veysey on 4/8/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "CommentsTableViewController.h"
#import "FISDonorsChooseProposal.h"
#import "DetailsTabBarController.h"
#import "FISDonation.h"
#import "FISComment.h"
#import "FISInputCommentCell.h"


@interface CommentsTableViewController () <UITextViewDelegate>

@property (nonatomic, strong) FISDonorsChooseProposal *proposal;
@property (strong, nonatomic) NSMutableDictionary *commentsDictionary;
@property (strong, nonatomic) NSMutableArray *orderedListOfDonors;

-(void) setupSegmentedControl;
-(void) prepareTableViewForResizingCells;
-(void) populateCommentsDictionary;
-(FISComment*) createDonorCommentFromDonation: (FISDonation*) donation;
-(FISComment*) createTeacherCommentFromDonation: (FISDonation*) donation;

-(void) formatCellForBasicDisplay:(UITableViewCell*) cell withComment: (FISComment*) comment;

NSString * const INPUT_CELL_PLACEHOLDER = @"Tap here to reply";
NSString * const INPUT_CELL_IDENTIFIER = @"inputCell";
NSString * const BASIC_CELL_IDENTIFIER = @"basicCell";

@end

@implementation CommentsTableViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // START FOR TEST PURPOSES ONLY!!!!
    
    FISDonorsChooseProposal *proposal = [[FISDonorsChooseProposal alloc] init];
    
    NSMutableArray *donations = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < 6; i++) {
        FISDonation *donation = [[FISDonation alloc] init];
        donation.donorName = [NSString stringWithFormat: @"Test User 00%ld", i];
        donation.donorMessage = @"i love school sah much. Also this is gonna be longer so we test out the multiline capability of the donor formatted cells.";
        [donations addObject: donation];
        if (i == 4)
        {
            donation.donorMessage = @"";
            donation.responseMessage = @"Worrrrd checking if teacher responses also display correctly";
        }
    }
    
    proposal.donations = donations;
    self.proposal = proposal;
    
    // END FOR TEST PURPOSES ONLY!!!!
    
    //    self.proposal=((DetailsTabBarController*)self.tabBarController).selectedProposal;
    [self setupSegmentedControl];
    [self populateCommentsDictionary];
    [self prepareTableViewForResizingCells];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.commentsDictionary allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *donorName = [self.commentsDictionary allKeys][section];
    NSArray *thisDonorsComments = self.commentsDictionary[donorName];
    return [thisDonorsComments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *donorName = [self.commentsDictionary allKeys][indexPath.section];
    NSArray *thisSetOfComments = self.commentsDictionary[donorName];
    FISComment *thisComment = thisSetOfComments[indexPath.row];

    if ([thisComment.commentBody isEqualToString: INPUT_CELL_PLACEHOLDER])
    {
        FISInputCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:INPUT_CELL_IDENTIFIER];
        if (!cell) {
            cell = [[FISInputCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:INPUT_CELL_IDENTIFIER];
        }
        cell.parentTableView = tableView;
        cell.placeholder = INPUT_CELL_PLACEHOLDER;
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: BASIC_CELL_IDENTIFIER];
        if (!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BASIC_CELL_IDENTIFIER];
        }
        [self formatCellForBasicDisplay: cell withComment: thisComment];
        return cell;
    }
}

#pragma mark - UITableViewDelegate

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%@", [self.commentsDictionary allKeys][section]];
}

#pragma mark - Formatting Helpers

-(void) formatCellForBasicDisplay:(UITableViewCell*) cell withComment: (FISComment*) comment
{
    cell.textLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = comment.commentBody;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - Initialization Helpers

-(void) setupSegmentedControl
{
    self.tableView.tableHeaderView = [[UISegmentedControl alloc] initWithItems:@[@"Awaiting Reply", @"All"]];
    ((UISegmentedControl*)self.tableView.tableHeaderView).selectedSegmentIndex = 0;
}

-(void) prepareTableViewForResizingCells
{
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // this line is needed to cell`s textview change cause resize the tableview`s cell
    self.tableView.estimatedRowHeight = 50.0;
}

-(void) populateCommentsDictionary
{
    self.commentsDictionary = [[NSMutableDictionary alloc] init];
    
    for(FISDonation *donation in self.proposal.donations)
    {
        FISComment *donorComment = [self createDonorCommentFromDonation: (FISDonation*) donation];
        FISComment *teacherResponse = [self createTeacherCommentFromDonation: (FISDonation*) donation];
        [self.commentsDictionary setObject:@[donorComment, teacherResponse] forKey: donation.donorName];
    }
    NSLog(@"dictionary %@", self.commentsDictionary);
    [self.tableView reloadData];
}

-(FISComment*) createDonorCommentFromDonation: (FISDonation*) donation
{
    FISComment *donorComment;
    if (!donation.donorMessage || [donation.donorMessage isEqualToString:@""])
    {
        NSString *automatedComment = [NSString stringWithFormat:@"%@ donated $%@.", donation.donorName, donation.donationAmount];
        NSLog(@"automatedComment:%@", automatedComment);
        donorComment = [[FISComment alloc] initWithDonorComment: automatedComment];
    }
    else
    {
        donorComment = [[FISComment alloc] initWithDonorComment:donation.donorMessage];
    }
    return donorComment;
}

-(FISComment*) createTeacherCommentFromDonation: (FISDonation*) donation
{
    FISComment *teacherResponse;
    if (!donation.responseMessage || [donation.responseMessage isEqualToString:@""])
    {
        NSString *tapMeText = INPUT_CELL_PLACEHOLDER;
        teacherResponse = [[FISComment alloc] initWithTeacherComment:tapMeText];
    }
    else
    {
        teacherResponse = [[FISComment alloc] initWithTeacherComment:donation.responseMessage];
    }
    return teacherResponse;
}

@end
