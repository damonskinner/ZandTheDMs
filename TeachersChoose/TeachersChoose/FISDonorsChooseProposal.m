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
    proposal.additionalSubjects=proposalDictionary[@"additionalSubjects"];
    proposal.city=proposalDictionary[@"city"];
    proposal.costToComplete=proposalDictionary[@"costToComplete"];
    proposal.expirationDate=proposalDictionary[@"expirationDate"];
    proposal.freeShipping=proposalDictionary[@"freeShipping"];
    proposal.fulfillmentTrailer=proposalDictionary[@"fulfillmentTrailer"];
    proposal.fundURL=proposalDictionary[@"fundURL"];
    proposal.fundingStatus=proposalDictionary[@"fundingStatus"];
    proposal.gradeLevel=proposalDictionary[@"gradeLevel"];
    proposal.proposalId=proposalDictionary[@"id"];
    proposal.imageURL=proposalDictionary[@"imageURL"];
    proposal.latitude=proposalDictionary[@"latitude"];
    proposal.longitude=proposalDictionary[@"longitude"];
    proposal.matchingFund=proposalDictionary[@"matchingFund"];
    proposal.numDonors = proposalDictionary[@"numDonors"];
    proposal.percentFunded=proposalDictionary[@"percentFunded"];
    proposal.povertyLevel=proposalDictionary[@"povertyLevel"];
    proposal.proposalURL=proposalDictionary[@"proposalURL"];
    proposal.resource=proposalDictionary[@"resource"];
    proposal.schoolName=proposalDictionary[@"schoolName"];
    proposal.schoolTypes=proposalDictionary[@"schoolTypes"];
    proposal.schoolUrl=proposalDictionary[@"schoolUrl"];
    proposal.shortDescription=proposalDictionary[@"shortDescription"];
    proposal.snippets=proposalDictionary[@"snippets"];
    proposal.state=proposalDictionary[@"state"];
    proposal.stateFullName=proposalDictionary[@"stateFullName"];
    proposal.subject=proposalDictionary[@"subject"];
    proposal.teacherId=proposalDictionary[@"teacherId"];
    proposal.teacherName=proposalDictionary[@"teacherName"];
    proposal.teacherTypes=proposalDictionary[@"teacherTypes"];
    proposal.thumbImageURL=proposalDictionary[@"thumbImageURL"];
    proposal.title=proposalDictionary[@"title"];
    proposal.totalPrice=proposalDictionary[@"totalPrice"];
    proposal.zip=proposalDictionary[@"zip"];
    proposal.zone=proposalDictionary[@"zone"];


    return proposal;
}


@end