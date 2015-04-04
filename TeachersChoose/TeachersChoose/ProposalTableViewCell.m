//
//  ProposalTableViewCell.m
//  TeachersChoose
//
//  Created by Cooper Veysey on 4/2/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "ProposalTableViewCell.h"
#import "Proposal.h"

@implementation ProposalTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//I'm a cell, I have a proposal (see ProposalTableViewCell.h's proposal property for reference, and I want it to be SET to the proposal in my array

-(void)setProposal:(Proposal *)proposal {
    _proposal = proposal;
    self.titleLabel.text = _proposal.proposalTitle;
    self.expirationDateLabel.text = _proposal.proposalExpirationDate;
    self.needLabel.text = _proposal.proposalNeed;
}


//[self.mainTableView removeConstraints:self.mainTableView.constraints];
//self.mainTableView.translatesAutoresizingMaskIntoConstraints = NO;

@end
