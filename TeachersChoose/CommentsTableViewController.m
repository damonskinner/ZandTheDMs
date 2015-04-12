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
#import "FISCommentCell.h"


@interface CommentsTableViewController () <UITextViewDelegate>

@property (nonatomic, strong) FISDonorsChooseProposal *proposal;
@property (strong, nonatomic) NSMutableDictionary *commentsDictionary;
@property (strong, nonatomic) NSMutableArray *orderedListOfDonors;
@end

@implementation CommentsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.tableHeaderView = [[UISegmentedControl alloc] initWithItems:@[@"Awaiting Reply", @"All"]];
    ((UISegmentedControl*)self.tableView.tableHeaderView).selectedSegmentIndex = 0;
    
//    self.proposal=((DetailsTabBarController*)self.tabBarController).selectedProposal;
    
    // START FOR TEST PURPOSES ONLY!!!!
    
    FISDonorsChooseProposal *proposal = [[FISDonorsChooseProposal alloc] init];
    
    FISDonation *donation = [[FISDonation alloc] init];
    donation.donorName = @"Edward Billingsworth III";
    donation.donorMessage = @"i love school sah much";
    
    FISDonation *donation2 = [[FISDonation alloc] init];
    donation2.donorName = @"Mary Poppins";
    donation2.donorMessage = @"i love school sah much";
    
    proposal.donations = (NSMutableArray*)@[donation, donation2];
    self.proposal = proposal;
    
    // END FOR TEST PURPOSES ONLY!!!!
    
    self.commentsDictionary = [[NSMutableDictionary alloc] init];
    [self populateCommentsDictionary];
    
    [self prepareTableViewForResizingCells];
}
#pragma mark - Helpers

-(void) populateCommentsDictionary
{
    // work over each donation
    for(FISDonation *donation in self.proposal.donations)
    {
        // declare for further modification
        FISComment *donorComment;
        FISComment *teacherResponse;
        
        // make the appropriate donor comment whether they have it or not
        if (![donation.donorMessage isEqualToString: @""] || donation.donorMessage
            )
        {
            // if the comment exists, add it
            donorComment = [[FISComment alloc] initWithDonorComment:donation.donorMessage];
        }
        else
        {
            NSString *automatedComment = [NSString stringWithFormat:@"%@ donated $%@.", donation.donorName, donation.donationAmount];
            NSLog(@"automatedComment:%@", automatedComment);
            donorComment = [[FISComment alloc] initWithDonorComment: automatedComment];
        }
        
        // make the appropriate teacher comment whether they have it or not
        if (donation.responseMessage)
        {
            teacherResponse = [[FISComment alloc] initWithTeacherComment:donation.responseMessage];
        }
        else
        {
            NSString *tapMeText = @"Tap here to reply";
            teacherResponse = [[FISComment alloc] initWithTeacherComment:tapMeText];
        }
        
        // make an entry in the dictionary with both of these comments in an array
        [self.commentsDictionary setObject:@[donorComment, teacherResponse] forKey: donation.donorName];
    }
    
    NSLog(@"%@", self.commentsDictionary);
    [self.tableView reloadData];
}

-(void) prepareTableViewForResizingCells
{
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // this line is needed to cell`s textview change cause resize the tableview`s cell
    self.tableView.estimatedRowHeight = 50.0;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //TODO: hook up sections by person
    return [[self.commentsDictionary allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //TODO: hook up rows by comments per donation / section
    NSString *donorName = [self.commentsDictionary allKeys][section];
    NSArray *thisDonorsComments = self.commentsDictionary[donorName];
    return [thisDonorsComments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FISCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell"];
    
    if (!cell) {
        cell = [[FISCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"basicCell"];
        cell.parentTableView = tableView;
    }

    NSString *donorName = [self.commentsDictionary allKeys][indexPath.section];
    NSArray *thisSetOfComments = self.commentsDictionary[donorName];
    FISComment *thisComment = thisSetOfComments[indexPath.row];
    
    cell.comment = thisComment;
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%@", [self.commentsDictionary allKeys][section]];
}



@end
