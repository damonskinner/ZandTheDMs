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

@end
