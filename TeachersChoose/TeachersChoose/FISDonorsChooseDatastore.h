//
//  FISDonorsChooseDatastore.h
//  playingWithDonorsChooseAPI
//
//  Created by Damon Skinner on 3/30/15.
//  Copyright (c) 2015 Damon Skinner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISDonorsChooseDatastore : NSObject

@property (nonatomic, strong) NSMutableArray *donorsChooseSearchResults;

+ (instancetype)sharedDataStore;

-(void)getSearchResultsWithKeyword: (NSString *) keyword andCompletion:(void (^)(BOOL))completionBlock;
-(void)getSearchResultsWithLocation: (NSString *) location andCompletion:(void (^)(BOOL))completionBlock;

@end
