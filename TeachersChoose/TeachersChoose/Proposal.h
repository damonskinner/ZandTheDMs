//
//  Proposal.h
//  TeachersChoose
//
//  Created by Cooper Veysey on 4/3/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Proposal : NSObject

@property (strong, nonatomic) NSString *proposalTitle;
@property (strong, nonatomic) NSString *proposalExpirationDate;
@property (strong, nonatomic) NSString *proposalNeed;

-(id)initWithProposalTitle: (NSString *)proposalTitle proposalExpirationDate: (NSString *)proposalExpirationDate proposalNeedMessage: (NSString *)proposalNeedMessage;

@end