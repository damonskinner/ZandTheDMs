//
//  Comments.m
//  TeachersChoose
//
//  Created by Cooper Veysey on 4/8/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "ProposalComment.h"
#import "FISDonation.h"

@implementation ProposalComment


+(ProposalComment*)initWithDonation:(FISDonation *)donation
{
    ProposalComment *newProposalComment = [[ProposalComment alloc] init];
    
    newProposalComment.donorName = donation.donorName;
    newProposalComment.donorLocation = donation.donorLocation;
    newProposalComment.donorMessageCopy = donation.donorMessage;
    newProposalComment.donationGivenDate = donation.donationDate;
    
    return newProposalComment;
}

@end
