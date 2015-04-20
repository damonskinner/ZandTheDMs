//
//  FISDonorsChooseAPI.m
//  playingWithDonorsChooseAPI
//
//  Created by Damon Skinner on 3/30/15.
//  Copyright (c) 2015 Damon Skinner. All rights reserved.
//

#import "FISDonorsChooseAPI.h"
#import "FISConstants.h"
#import <AFNetworking.h>

@implementation FISDonorsChooseAPI
//not used
+(void)getSearchResultsWithKeyword:(NSString *) keyword andCompletionBlock:(void (^)(NSArray *))completionBlock
{
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"%@/json_feed.html?",DonorsChooseBaseURL];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSDictionary *params = @{@"keywords":keyword,@"APIKEY":DonorsChooseAPIKey};
    
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    
    [manager GET:donorsChooseURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *rawResults = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        completionBlock(rawResults[@"proposals"]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Fail: %@",error.localizedDescription);
    }];
}
//not used
+(void)getSearchResultsWithLocation:(NSString *) location andCompletionBlock:(void (^)(NSArray *))completionBlock
{
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"%@/json_feed.html?",DonorsChooseBaseURL];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{@"location":location,@"APIKEY":DonorsChooseAPIKey};
    
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    
    [manager GET:donorsChooseURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *rawResults = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        
        completionBlock(rawResults[@"proposals"]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Fail: %@",error.localizedDescription);
    }];
}

+(void)getTeacherIdForProposalId:(NSString *) proposalId andCompletionBlock:(void (^)(NSDictionary *))completionBlock
{
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"%@/json_feed.html?",DonorsChooseBaseURL];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{@"id":proposalId,@"APIKEY":DonorsChooseAPIKey};
    
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    
    [manager GET:donorsChooseURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *rawResults = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        
        completionBlock(rawResults[@"proposals"][0]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Fail: %@",error.localizedDescription);
    }];
}


+(void)getSearchResultsWithTeacherId:(NSString *) teacherId andCompletionBlock:(void (^)(NSArray *))completionBlock
{
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"%@/json_feed.html?",DonorsChooseBaseURL];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{@"teacher":teacherId,@"APIKEY":DonorsChooseAPIKey};
    
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    
    [manager GET:donorsChooseURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *rawResults = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        
        completionBlock(rawResults[@"proposals"]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Fail: %@",error.localizedDescription);
    }];
}

+(void)getHistoricalSearchResultsWithTeacherId:(NSString *) teacherId andCompletionBlock:(void (^)(NSArray *))completionBlock
{
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"%@/json_feed.html?",DonorsChooseBaseURL];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{@"teacher":teacherId,@"historical":@"true",@"APIKEY":DonorsChooseAPIKey};
    
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    
    [manager GET:donorsChooseURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *rawResults = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        
        completionBlock(rawResults[@"proposals"]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Fail: %@",error.localizedDescription);
    }];
}

+(void)getSearchResultsWithParams:(NSDictionary *) params andCompletionBlock:(void (^)(NSArray *))completionBlock
{
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"%@/json_feed.html?&APIKEY=%@",DonorsChooseBaseURL,DonorsChooseAPIKey];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    
    [manager GET:donorsChooseURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *rawResults = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        
        completionBlock(rawResults[@"proposals"]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Fail: %@",error.localizedDescription);
    }];
}

+(void)getTeacherProfileWithTeacherId:(NSString *) teacherId andCompletionBlock:(void (^)(NSDictionary *))completionBlock
{
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"%@/json-teacher.html?&APIKEY=%@&teacher=%@",DonorsChooseBaseURL,DonorsChooseAPIKey,teacherId];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    
    [manager GET:donorsChooseURLString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *rawResults = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        
        completionBlock(rawResults);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Fail: %@",error.localizedDescription);
    }];
}


+(void)getProposalObjectForProposalId:(NSString *) proposalId andCompletionBlock:(void (^)(NSDictionary *))completionBlock
{
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"%@/json_feed.html?",DonorsChooseBaseURL];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{@"id":proposalId,@"APIKEY":DonorsChooseAPIKey};
    
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    
    [manager GET:donorsChooseURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *rawResults = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        
        completionBlock(rawResults[@"proposals"][0]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Fail: %@",error.localizedDescription);
    }];
}



@end
