//
//  Proposal.m
//  TeachersChoose
//
//  Created by Cooper Veysey on 4/3/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "Proposal.h"

@implementation Proposal

-(id)initWithProposalTitle: (NSString *)proposalTitle proposalExpirationDate: (NSString *)proposalExpirationDate proposalNeedMessage: (NSString *)proposalNeedMessage
{
    self = [super init];
    if (self) {
        _proposalTitle = [proposalTitle  copy];
        _proposalExpirationDate = [proposalExpirationDate copy];
        _proposalNeed = [proposalNeedMessage copy];
    }
    return self;
}


@end
