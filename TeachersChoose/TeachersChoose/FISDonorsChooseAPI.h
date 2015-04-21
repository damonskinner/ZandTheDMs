//
//  FISDonorsChooseAPI.h
//  playingWithDonorsChooseAPI
//
//  Created by Damon Skinner on 3/30/15.
//  Copyright (c) 2015 Damon Skinner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISDonorsChooseAPI : NSObject


+(void)getSearchResultsWithKeyword:(NSString *) keyword andCompletionBlock:(void (^)(NSArray *))completionBlock;
+(void)getSearchResultsWithLocation:(NSString *) keyword andCompletionBlock:(void (^)(NSArray *))completionBlock;
+(void)getSearchResultsWithParams:(NSDictionary *) params andCompletionBlock:(void (^)(NSArray *))completionBlock;
+(void)getSearchResultsWithTeacherId:(NSString *) teacherId andCompletionBlock:(void (^)(NSArray *))completionBlock;
+(void)getTeacherProfileWithTeacherId:(NSString *) teacherId andCompletionBlock:(void (^)(NSDictionary *))completionBlock;
+(void)getHistoricalSearchResultsWithTeacherId:(NSString *) teacherId andCompletionBlock:(void (^)(NSArray *))completionBlock;
+(void)getTeacherIdForProposalId:(NSString *) proposalId andCompletionBlock:(void (^)(NSDictionary *))completionBlock;
+(void)getProposalObjectForProposalId:(NSString *) proposalId andCompletionBlock:(void (^)(NSDictionary *))completionBlock;


@end
