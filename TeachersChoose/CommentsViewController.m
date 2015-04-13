//
//  CommentsViewController.m
//  TeachersChoose
//
//  Created by Damon Skinner on 4/13/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "CommentsViewController.h"
#import "FISDonorsChooseProposal.h"
#import "UIColor+DonorsChooseColors.h"
#import "UIFont+DonorsChooseFonts.h"
#import "DetailsTabBarController.h"
#import "FISDonation.h"
#import "FISComment.h"
#import "FISInputCommentCell.h"


@interface CommentsViewController () <UITextViewDelegate>

@property (nonatomic, strong) FISDonorsChooseProposal *proposal;
@property (strong, nonatomic) NSMutableDictionary *commentsDictionary;
@property (strong, nonatomic) NSMutableArray *orderedListOfDonors;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UISegmentedControl *mySegmentedControl;
@property (nonatomic, strong) UILabel *titleLabel;

-(void) setupSegmentedControl;
-(void) prepareTableViewForResizingCells;
-(void) populateCommentsDictionary;


@end

NSString * const INPUT_CELL_PLACEHOLDER = @"Tap here to reply"; // there is a matching one in FISComment
NSString * const INPUT_CELL_IDENTIFIER = @"inputCell";
NSString * const BASIC_CELL_IDENTIFIER = @"basicCell";

@implementation CommentsViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.proposal=((DetailsTabBarController*)self.tabBarController).selectedProposal;
    [self setupSegmentedControl];
    [self setupLayout];
    [self populateCommentsDictionary];
    [self prepareTableViewForResizingCells];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
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


#pragma mark - Initialization Helpers

-(void) setupLayout {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text=self.proposal.title;
    self.titleLabel.font=[UIFont fontWithName:DonorsChooseTitleBoldFont size:20];
    self.titleLabel.textColor=[UIColor DonorsChooseBlack];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.myTableView = [[UITableView alloc]init];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.myTableView];
    self.view.backgroundColor=[UIColor DonorsChooseGreyLight];
    
    
    
    [self.mySegmentedControl removeConstraints:self.mySegmentedControl.constraints];
    [self.myTableView removeConstraints:self.myTableView.constraints];
    [self.titleLabel removeConstraints:self.titleLabel.constraints];
    [self.view removeConstraints:self.view.constraints];
    
    [self.myTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.mySegmentedControl setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *views = @{@"view":self.view,@"segmentedControl":self.mySegmentedControl,@"titleLabel":self.titleLabel,@"tableView":self.myTableView};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleLabel(view)]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[segmentedControl(view)]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-65-[titleLabel(80)][segmentedControl(35)]-[tableView]-30-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[tableView]-|" options:0 metrics:nil views:views]];
}



-(void) setupSegmentedControl
{
    self.mySegmentedControl= [[UISegmentedControl alloc] initWithItems:@[@"Awaiting Reply", @"All"]];
    self.mySegmentedControl.selectedSegmentIndex = 0;

    self.mySegmentedControl.layer.borderWidth=1;
    self.mySegmentedControl.layer.borderColor =[UIColor DonorsChooseOrange].CGColor;
    self.mySegmentedControl.tintColor=[UIColor DonorsChooseOrange];
    [self.view addSubview:self.mySegmentedControl];
}

-(void) prepareTableViewForResizingCells
{
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    self.myTableView.estimatedRowHeight = 50.0;
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
    [self.myTableView reloadData];
}



@end