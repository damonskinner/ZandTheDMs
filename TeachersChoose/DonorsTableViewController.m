//
//  DonorsTableViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/3/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "DonorsTableViewController.h"
#import "FISDonorsChooseProposal.h"
#import "FISDonation.h"
#import "UIColor+DonorsChooseColors.h"

@interface DonorsTableViewController ()

@end

@implementation DonorsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    

    
    [self.tableView setBackgroundColor: [UIColor DonorsChooseBlueLight]];
    [self.tableView setSeparatorColor: [UIColor DonorsChooseBlueBorder]];
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.proposal.donations count] +1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"basicCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    FISDonation *thisDonation =[[FISDonation alloc] initWithName:@"" Location:@"" Date:nil DonorMessage:@"" ResponseMessage:@"" DonationAmount:@""];
    // get appropriate donation item
    if(indexPath.row>0){
        thisDonation= self.proposal.donations[indexPath.row-1];
    }
    
    
    // set standard properties
    cell.textLabel.text = thisDonation.donorName;
    cell.detailTextLabel.text = thisDonation.donorLocation;
    cell.detailTextLabel.textColor = [UIColor grayColor];
    
    // make a new label, format it and set it as accessory view
    UILabel *amountDonatedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, cell.frame.size.height)];
    if (indexPath.row!=0) {
        amountDonatedLabel.text = [NSString stringWithFormat:@"$%@", thisDonation.donationAmount];
        amountDonatedLabel.textAlignment = NSTextAlignmentRight;
        [cell setAccessoryView: amountDonatedLabel];
    }
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    return NO;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
