//
//  FISDonorsChooseDatastore.m
//  playingWithDonorsChooseAPI
//
//  Created by Damon Skinner on 3/30/15.
//  Copyright (c) 2015 Damon Skinner. All rights reserved.
//

#import "FISDonorsChooseDatastore.h"
#import "FISDonorsChooseAPI.h"
#import "FISDonorsChooseProposal.h"
#import "FISDonorsChooseTeacher.h"
#import "FISParseAPI.h"
#import "FISDonation.h"

@implementation FISDonorsChooseDatastore

+ (instancetype)sharedDataStore {
    static FISDonorsChooseDatastore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[FISDonorsChooseDatastore alloc] init];
    });
    
    return _sharedDataStore;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _donorsChooseSearchResults=[NSMutableArray new];
        _loggedInTeacherProposals=[NSMutableArray new];
        _loggedInTeacher=[FISDonorsChooseTeacher new];
    }
    return self;
}

-(void)getSearchResultsWithKeyword: (NSString *) keyword andCompletion:(void (^)(BOOL))completionBlock
{
    [FISDonorsChooseAPI getSearchResultsWithKeyword:keyword andCompletionBlock:^(NSArray *proposalDictionaries) {
        for (NSDictionary *proposalDict in proposalDictionaries) {
            [self.donorsChooseSearchResults addObject:[FISDonorsChooseProposal proposalFromDictionary:proposalDict]];
        }
        completionBlock(YES);
    }];
}

-(void)getSearchResultsWithLocation: (NSString *) location andCompletion:(void (^)(BOOL))completionBlock
{
    [FISDonorsChooseAPI getSearchResultsWithLocation:location andCompletionBlock:^(NSArray *proposalDictionaries) {
        for (NSDictionary *proposalDict in proposalDictionaries) {
            [self.donorsChooseSearchResults addObject:[FISDonorsChooseProposal proposalFromDictionary:proposalDict]];
        }
        completionBlock(YES);
    }];
}

-(void)getSearchResultsWithParams: (NSDictionary *) params andCompletion:(void (^)(BOOL))completionBlock
{
    [FISDonorsChooseAPI getSearchResultsWithParams:params andCompletionBlock:^(NSArray *proposalDictionaries) {
        for (NSDictionary *proposalDict in proposalDictionaries) {
            [self.donorsChooseSearchResults addObject:[FISDonorsChooseProposal proposalFromDictionary:proposalDict]];
        }
        completionBlock(YES);
    }];
}

-(void)getSearchResultsWithTeacherId: (NSString *) teacherId andCompletion:(void (^)(BOOL))completionBlock
{
    [FISDonorsChooseAPI getSearchResultsWithTeacherId:teacherId andCompletionBlock:^(NSArray *proposalDictionaries) {
        if ([proposalDictionaries count]>0) {
            for (NSDictionary *proposalDict in proposalDictionaries) {
                [self.loggedInTeacherProposals addObject:[FISDonorsChooseProposal proposalFromDictionary:proposalDict]];
                
            }
            
            
            completionBlock(YES);
        } else {
            completionBlock(NO);
        }
    }];
}

-(void)getTeacherProfileWithTeacherId: (NSString *) teacherId andCompletion:(void (^)(BOOL))completionBlock
{
    [FISDonorsChooseAPI getTeacherProfileWithTeacherId:teacherId andCompletionBlock:^(NSDictionary *teacherDictionary) {
        
        self.loggedInTeacher = [FISDonorsChooseTeacher teacherFromDictionary:teacherDictionary];
        
        completionBlock(YES);
    }];
}


-(void) getDonationObjectsWithDonationIDList: (NSArray *) donationIdList forEachProposal: (FISDonorsChooseProposal *) eachProposal andCompletion:(void (^)(BOOL))completionBlock {
    
    for (NSDictionary *eachDonationObject in donationIdList) {
        
        [FISParseAPI getDonationforDonationWithObjectId:eachDonationObject[@"objectId"] andCompletionBlock:^(NSDictionary * donationDict) {
            FISDonation *newDonation = [FISDonation donationFromDictionary:donationDict];
            newDonation.donationObjectId = eachDonationObject[@"objectId"];
            [eachProposal.donations addObject:newDonation];
            
        }];
        
    }
}


@end
