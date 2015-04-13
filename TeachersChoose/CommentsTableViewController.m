//
//  CommentsTableViewController.m
//  TeachersChoose
//
//  Created by Cooper Veysey on 4/8/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "CommentsTableViewController.h"
#import "FISDonorsChooseProposal.h"
#import "UIColor+DonorsChooseColors.h"
#import "UIFont+DonorsChooseFonts.h"
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
-(void) formatCellForBasicDisplay:(UITableViewCell*) cell withComment: (FISComment*) comment;

@end

NSString * const INPUT_CELL_PLACEHOLDER = @"Tap here to reply"; // there is a matching one in FISComment
NSString * const INPUT_CELL_IDENTIFIER = @"inputCell";
NSString * const BASIC_CELL_IDENTIFIER = @"basicCell";

@implementation CommentsTableViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.proposal=((DetailsTabBarController*)self.tabBarController).selectedProposal;
    [self setupSegmentedControl];
    [self populateCommentsDictionary];
    [self prepareTableViewForResizingCells];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"MEMORY WARNING");
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
//        cell.parentTableView = tableView;
        cell.placeholder = INPUT_CELL_PLACEHOLDER;
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: BASIC_CELL_IDENTIFIER];
        if (!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BASIC_CELL_IDENTIFIER];
        }
        [self formatCell: cell forBasicDisplaywithComment: thisComment];
        return cell;
    }
}

#pragma mark - UITableViewDelegate

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%@", [self.commentsDictionary allKeys][section]];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    // height-less because we implement tableView:heightForFooterInSection:
    UIView *view = [[UIView alloc] initWithFrame: CGRectMake(0,0, tableView.frame.size.width, 30)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30; // just seemed like a magical number
}

#pragma mark - Formatting Helpers

-(void) formatCell:(UITableViewCell*) cell forBasicDisplaywithComment: (FISComment*) comment
{
    cell.textLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = comment.commentBody;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self formatCell: cell byCommentTypeWithComment:comment];
}

-(void) formatCell: (UITableViewCell*) cell byCommentTypeWithComment: (FISComment *) comment
{
    // !!! need to have counter-acting actions in each since cells are reusable
    if (comment.commentType == CommentFromDonor)
    {
        cell.backgroundColor = [UIColor DonorsChooseGreyLight];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.indentationLevel = 0;
    }
    else
    {
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textAlignment = NSTextAlignmentRight;
        cell.indentationLevel = 3;
    }
}

-(void) formatCellAsTeacherComment
{
    
}
#pragma mark - Initialization Helpers

-(void) setupSegmentedControl
{
    self.tableView.tableHeaderView = [[UISegmentedControl alloc] initWithItems:@[@"Awaiting Reply", @"All"]];
    ((UISegmentedControl*)self.tableView.tableHeaderView).selectedSegmentIndex = 0;
    self.tableView.tableHeaderView.layer.borderWidth=1;
    self.tableView.tableHeaderView.layer.borderColor =[UIColor DonorsChooseOrange].CGColor;
    self.tableView.tableHeaderView.tintColor=[UIColor DonorsChooseOrange];
}

-(void) prepareTableViewForResizingCells
{
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50.0;
}

-(void) populateCommentsDictionary
{
    self.commentsDictionary = [[NSMutableDictionary alloc] init];
    
    for(FISDonation *donation in self.proposal.donations)
    {
        FISComment *donorComment = [FISComment createDonorCommentFromDonation: (FISDonation*) donation];
        FISComment *teacherResponse = [FISComment createTeacherCommentFromDonation: (FISDonation*) donation];
        [self.commentsDictionary setObject:@[donorComment, teacherResponse] forKey: donation.donorName];
    }
    NSLog(@"dictionary %@", self.commentsDictionary);
    [self.tableView reloadData];
}



@end
