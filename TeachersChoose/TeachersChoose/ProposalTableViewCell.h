//
//  ProposalTableViewCell.h
//  TeachersChoose
//
//  Created by Cooper Veysey on 4/2/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Proposal;

@interface ProposalTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *expirationDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *costToCompleteLabel;

@property (strong,nonatomic) Proposal *proposal;

@end
