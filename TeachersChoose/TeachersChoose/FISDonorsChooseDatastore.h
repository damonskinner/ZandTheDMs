//
//  FISDonorsChooseDatastore.h
//  playingWithDonorsChooseAPI
//
//  Created by Damon Skinner on 3/30/15.
//  Copyright (c) 2015 Damon Skinner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FISDonorsChooseTeacher.h"

@interface FISDonorsChooseDatastore : NSObject

@property (nonatomic, strong) NSMutableArray *donorsChooseSearchResults;
@property (nonatomic, strong) FISDonorsChooseTeacher *loggedInTeacher;
@property (nonatomic, strong) NSMutableArray *loggedInTeacherProposals;

+ (instancetype)sharedDataStore;

-(void)getSearchResultsWithKeyword: (NSString *) keyword andCompletion:(void (^)(BOOL))completionBlock;
-(void)getSearchResultsWithLocation: (NSString *) location andCompletion:(void (^)(BOOL))completionBlock;
-(void)getSearchResultsWithParams: (NSDictionary *) params andCompletion:(void (^)(BOOL))completionBlock;
-(void)getSearchResultsWithTeacherId: (NSString *) teacherId andCompletion:(void (^)(BOOL))completionBlock;
-(void)getTeacherProfileWithTeacherId: (NSString *) teacherId andCompletion:(void (^)(BOOL))completionBlock;
-(void) getDonationsListForProposalId: (NSString *) proposalObjectId andCompletion:(void (^)(BOOL))completionBlock;

@end
