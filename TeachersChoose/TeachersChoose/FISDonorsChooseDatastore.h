//
//  FISDonorsChooseDatastore.h
//  playingWithDonorsChooseAPI
//
//  Created by Damon Skinner on 3/30/15.
//  Copyright (c) 2015 Damon Skinner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FISDonorsChooseTeacher.h"
#import "FISDonorsChooseProposal.h"
#import "FISDonation.h"


@interface FISDonorsChooseDatastore : NSObject

@property (nonatomic, strong) NSMutableArray *donorsChooseSearchResults;
@property (nonatomic, strong) FISDonorsChooseTeacher *loggedInTeacher;
@property (nonatomic, strong) NSMutableArray *loggedInTeacherProposals;
@property (nonatomic, strong) NSMutableArray *loggedInTeacherCompletedProposals;
@property (nonatomic, strong) NSArray *sampleDonations;
@property (nonatomic, strong) NSString *decodedDeviceToken;

+ (instancetype)sharedDataStore;

-(void)getSearchResultsWithKeyword: (NSString *) keyword andCompletion:(void (^)(BOOL))completionBlock;
-(void)getSearchResultsWithLocation: (NSString *) location andCompletion:(void (^)(BOOL))completionBlock;
-(void)getSearchResultsWithParams: (NSDictionary *) params andCompletion:(void (^)(BOOL))completionBlock;
-(void)getSearchResultsWithTeacherId: (NSString *) teacherId andCompletion:(void (^)(BOOL))completionBlock;
-(void)getTeacherProfileWithTeacherId: (NSString *) teacherId andCompletion:(void (^)(BOOL))completionBlock;
-(void) getDonationsListForProposal: (FISDonorsChooseProposal *) proposal andCompletion:(void (^)(BOOL))completionBlock;
-(void) addNewDonationResponseMessage:(NSString *)responseMessage  forDonation: (FISDonation *) donation forProposal: (FISDonorsChooseProposal *) proposal andCompletion:(void (^)(BOOL))completionBlock;

-(void) updateCurrentTeacherProposalsForCurrentTeacherId: (NSString *) currentTeacherId andCompletionBlock:(void (^)(void))completionBlock;

-(void) populateRandomDonationsForProposal:(FISDonorsChooseProposal *) proposal withCompletionblock:(void (^)(void))completionBlock;


@end
