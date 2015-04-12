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
    proposal.donations = (NSMutableArray*)@[donation];
    self.proposal = proposal;
    
    // END FOR TEST PURPOSES ONLY!!!!
    
    self.commentsDictionary = [[NSMutableDictionary alloc] init];
    [self populateCommentsDictionary];
}

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

#pragma mark - Table view data source

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"basicCell"];
    }

    NSString *donorName = [self.commentsDictionary allKeys][indexPath.section];
    NSArray *thisSetOfComments = self.commentsDictionary[donorName];
    FISComment *thisComment = thisSetOfComments[indexPath.row];
    
    if(thisComment.commentType == CommentFromDonor)
    {
        cell.textLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = thisComment.commentBody;
    }
    else
    {
        // make a textview
        UITextView *myTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
        myTextView.textAlignment = NSTextAlignmentCenter;
        myTextView.font = cell.textLabel.font;
        myTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        myTextView.text = thisComment.commentBody;
        myTextView.textColor = [UIColor lightGrayColor];
        
        // add it to the cell
        [cell addSubview: myTextView];
    }
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%@", [self.commentsDictionary allKeys][section]];
}


@end
