//
//  FISDonorsChooseProposal.m
//  playingWithDonorsChooseAPI
//
//  Created by Damon Skinner on 3/30/15.
//  Copyright (c) 2015 Damon Skinner. All rights reserved.
//

#import "FISDonorsChooseProposal.h"
#import "NSDate+DateConvenienceMethods.h"
#import <NSString+HTML.h>

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
    NSString *encodedTitleString=proposalDictionary[@"title"];
    proposal.title=[encodedTitleString stringByDecodingHTMLEntities];
    proposal.totalPrice=proposalDictionary[@"totalPrice"];
    proposal.zip=proposalDictionary[@"zip"];
    proposal.zone=proposalDictionary[@"zone"];
    
    proposal.parseObjectId=proposalDictionary[@"objectId"];

    proposal.daysLeft = [NSDate daysBetweenDate:[NSDate date] andDate:[NSDate expirationDateFormatterWithDateString:proposalDictionary[@"expirationDate"]]];
    
    return proposal;
}


-(id)copyWithZone:(NSZone *)zone
{
    // We'll ignore the zone for now
    FISDonorsChooseProposal *proposalCopy = [[FISDonorsChooseProposal allocWithZone:zone]init];

    
    return proposalCopy;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _donations = [[NSMutableArray alloc] init];
    }
    return self;
}


@end
