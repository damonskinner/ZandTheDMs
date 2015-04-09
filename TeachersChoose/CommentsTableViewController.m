//
//  CommentsTableViewController.m
//  TeachersChoose
//
//  Created by Cooper Veysey on 4/8/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "CommentsTableViewController.h"
#import "ProposalComment.h"
#import "FISDonorsChooseProposal.h"
#import "DetailsTabBarController.h"
#import "FISDonation.h"


@interface CommentsTableViewController ()

@property (nonatomic, strong) FISDonorsChooseProposal *proposal;
@property (strong, nonatomic) NSMutableArray *donorsWhoCommented;
@property (strong, nonatomic) NSMutableDictionary *donorsAndComments;

@end

@implementation CommentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.donorsAndComments = [[NSMutableDictionary alloc] init];

    self.proposal=((DetailsTabBarController*)self.tabBarController).selectedProposal;
    
    self.donorsWhoCommented = [[NSMutableArray alloc] init];
   
    [self populateCommentsArray];
    
}

-(void) populateCommentsArray
{
    for(FISDonation *eachDonation in self.proposal.donations)
    {
        //ProposalComment *newComment = [ProposalComment initWithDonation: eachDonation];
        //[self.commentsArray addObject:newComment];
        
        if ([eachDonation.donorMessage isEqualToString:@""]) {
            NSLog(@"nil message");
        } else {
            [self.donorsWhoCommented addObject:eachDonation.donorName];
            [self.donorsAndComments setObject:@[eachDonation.donorMessage] forKey:eachDonation.donorName];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //TODO: hook up sections by person
    return [self.donorsWhoCommented count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //TODO: hook up rows by comments per donation / section
    NSString *donorName = self.donorsWhoCommented[section];
    NSArray *thisDonorsComments = self.donorsAndComments[donorName];
    return [thisDonorsComments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"basicCell"];
    }
    
    NSString *donorName = self.donorsWhoCommented[indexPath.section];
    NSArray *thisDonorsComments = self.donorsAndComments[donorName];
    
    cell.textLabel.text = thisDonorsComments[indexPath.row];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%@", self.donorsWhoCommented[section]];
}




@end
