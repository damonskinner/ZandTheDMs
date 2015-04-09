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
#import "FISDonorsChooseCompletedProposal.h"
#import "FISDonorsChooseTeacher.h"
#import "FISParseAPI.h"

#import "ImagesAPI.h"

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
        _loggedInTeacherCompletedProposals=[NSMutableArray new];
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
        
            for (NSDictionary *proposalDict in proposalDictionaries) {
                [self.loggedInTeacherProposals addObject:[FISDonorsChooseProposal proposalFromDictionary:proposalDict]];
            }
        [FISDonorsChooseAPI getHistoricalSearchResultsWithTeacherId:teacherId andCompletionBlock:^(NSArray *completedProposalDictionaries) {
            for(NSDictionary *completedProposalDictionary in completedProposalDictionaries) {
                [self.loggedInTeacherCompletedProposals addObject:[FISDonorsChooseCompletedProposal proposalFromDictionary:completedProposalDictionary]];
                
            }
            if([self.loggedInTeacherProposals count]>0 || self.loggedInTeacherCompletedProposals >0) {
                completionBlock(YES);
            } else {
                completionBlock(NO);
            }
            
        }];
    }];
}

-(void)getTeacherProfileWithTeacherId: (NSString *) teacherId andCompletion:(void (^)(BOOL))completionBlock
{
    [FISDonorsChooseAPI getTeacherProfileWithTeacherId:teacherId andCompletionBlock:^(NSDictionary *teacherDictionary) {
        
        self.loggedInTeacher = [FISDonorsChooseTeacher teacherFromDictionary:teacherDictionary];
        [ImagesAPI getImageWithURLString:self.loggedInTeacher.photoURL andCompletion:^(UIImage *teacherImage) {
            self.loggedInTeacher.image=teacherImage;
            completionBlock(YES);
        }];
    }];
}


-(void) getDonationsListForProposal: (FISDonorsChooseProposal *) proposal andCompletion:(void (^)(BOOL))completionBlock {
    [FISParseAPI getDonationsListForProposalWithId:proposal.proposalId andCompletionBlock:^(NSArray *donations) {
        for (NSDictionary *donationDict in donations){
            [proposal.donations addObject:[FISDonation donationFromDictionary:donationDict]];
        }
        if([proposal.donations count]>0){
            completionBlock(YES);
        } else {
            completionBlock(NO);
        }
    }];
}




-(void) updateCurrentTeacherProposalsForCurrentTeacherId: (NSString *) currentTeacherId andCompletionBlock:(void (^)(void))completionBlock {
    [self getSearchResultsWithTeacherId:currentTeacherId andCompletion:^(BOOL completion) {
        
        //May need to insert more API stuff here to update any new proposals on parse
        if(completion) {
            
            for (FISDonorsChooseProposal *eachProposal in self.loggedInTeacherProposals) {
                [self getDonationsListForProposal:eachProposal andCompletion:^(BOOL completion) {
                    if(completion) {
                        NSLog(@"%@",eachProposal.donations);
                    } else {
                        NSLog(@"Donations array not populated.  Check parse database and manually link if needed.");
                    }
                    
                }];
            }
            
        } else {
            NSLog(@"No active proposals");
        }
        [self getTeacherProfileWithTeacherId:currentTeacherId andCompletion:^(BOOL completion) {
            [ImagesAPI getImageWithURLString:self.loggedInTeacher.photoURL andCompletion:^(UIImage *teacherImage) {
                self.loggedInTeacher.image=teacherImage;
            completionBlock();
            }];
        }];
    }];
}

//TODO: Create sample donations function
//FIXME:
-(NSArray *) sampleDonations {

    
    
    return _sampleDonations;
}

@end
