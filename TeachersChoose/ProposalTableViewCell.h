//
//  ProposalTableViewCell.h
//  TeachersChoose
//
//  Created by Damon Skinner on 4/8/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FISDonorsChooseProposal.h"



@interface ProposalTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *costToCompleteLabel;
@property (weak, nonatomic) IBOutlet UILabel *expirationDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@property (nonatomic, strong) FISDonorsChooseProposal *proposal;

@end