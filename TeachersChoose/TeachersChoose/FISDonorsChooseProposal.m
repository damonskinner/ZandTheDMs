//
//  FISDonorsChooseProposal.m
//  playingWithDonorsChooseAPI
//
//  Created by Damon Skinner on 3/30/15.
//  Copyright (c) 2015 Damon Skinner. All rights reserved.
//

#import "FISDonorsChooseProposal.h"

@implementation FISDonorsChooseProposal


+(FISDonorsChooseProposal *)proposalFromDictionary:(NSDictionary *)proposalDictionary
{
    FISDonorsChooseProposal *proposal = [[FISDonorsChooseProposal alloc] init];
    proposal.title = proposalDictionary[@"title"];
    proposal.shortDesc=proposalDictionary[@"shortDescription"];
    proposal.proposalImageURL = proposalDictionary[@"imageURL"];
    proposal.numberOfDonors = proposalDictionary[@"numDonors"];

    return proposal;
}


@end
