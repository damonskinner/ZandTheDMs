//
//  FISParseAPI.h
//  TeachersChoose
//
//  Created by Damon Skinner on 4/2/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FISDonorsChooseProposal.h"
#import "FISConstants.h"
#import <Parse.h>

@interface FISParseAPI : NSObject

+(void)addRandomTeacherId:(NSString *) randomTeacherId toNewUserWithObjectId:(NSString *) currentUserObjectId currentUserSessionToken: (NSString *) currentUserSessionToken  andCompletionBlock:(void (^)(void))completionBlock;

+(void)addProposalObjectId:(NSString *) proposalObjectId toNewUserWithObjectId:(NSString *) currentUserObjectId currentUserSessionToken: (NSString *) currentUserSessionToken  andCompletionBlock:(void (^)(void))completionBlock;


+(void)createProposalWithId:(NSString *) proposalId withTeacherObjectId: (NSString *)teacherObjectId andCompletionBlock:(void (^)(NSDictionary *))completionBlock;

+(void) getDonationsListForProposalWithId: (NSString *) proposalId andCompletionBlock:(void (^)(NSArray *))completionBlock;

+(void) getProposalObjectIdForProposalId: (NSString *) proposalId andCompletionBlock:(void (^)(NSString *))completionBlock;

+(void) getDonationforDonationWithObjectId: (NSString *) donationObjectId andCompletionBlock:(void (^)(NSDictionary *))completionBlock;

+(void) getTeacherIdForObjectId: (NSString *) teacherObjectId andCompletionBlock:(void (^)(NSString *))completionBlock;

+(void) addDonationResponseMessage:(NSString *) responseMessage forDonationWithObjectId: (NSString *) donationObjectId andCompletionBlock:(void (^)(void))completionBlock;

@end
