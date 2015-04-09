//
//  CommentsTableViewController.m
//  TeachersChoose
//
//  Created by Cooper Veysey on 4/8/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "CommentsTableViewController.h"
#import "CommentCell.h"
#import "ProposalComment.h"
#import "FISDonorsChooseProposal.h"
#import "DetailsTabBarController.h"
#import "FISDonation.h"


@interface CommentsTableViewController ()

@property (strong,nonatomic) NSMutableArray *commentsArray;
@property (nonatomic, strong) FISDonorsChooseProposal *proposal;

@end

@implementation CommentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil ] forCellReuseIdentifier:@"basicCell"];

    self.commentsArray = [[NSMutableArray alloc]init];

    self.proposal=((DetailsTabBarController*)self.tabBarController).selectedProposal;

   
    [self populateCommentsArray];
    
//    [self.commentsArray addObject:newComment]

}

-(void) populateCommentsArray
{
    for(FISDonation *eachDonation in self.proposal.donations)
    {
        ProposalComment *newComment = [ProposalComment initWithDonation: eachDonation];
        [self.commentsArray addObject:newComment];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //TODO: hook up sections by person
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //TODO: hook up rows by comments per donation / section
    return [self.commentsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell"];
    
    cell.comments = [self.commentsArray objectAtIndex:indexPath.row];
    
//        if (cell == nil)
//            {
//                cell = [CommentCell alloc] init];
//    //    }
    //
    //    FISDonation *thisDonation = self.comments[indexPath.row];
    //
    //    cell.commenterName.text = thisDonation.donor;
    //    cell.messageBody.text = thisDonation.donorMessage;
    
    return cell;
}



@end
