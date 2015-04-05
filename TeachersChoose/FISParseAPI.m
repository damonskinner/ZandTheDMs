//
//  FISParseAPI.m
//  TeachersChoose
//
//  Created by Damon Skinner on 4/2/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "FISParseAPI.h"
#import <AFNetworking.h>
#import "FISConstants.h"

@implementation FISParseAPI



+(void)addRandomTeacherId:(NSString *) randomTeacherId toNewUserWithObjectId:(NSString *) currentUserObjectId currentUserSessionToken: (NSString *) currentUserSessionToken  andCompletionBlock:(void (^)(void))completionBlock
{
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"https://api.parse.com/1/users/%@",currentUserObjectId];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    

    NSDictionary *params = @{@"teacherId":randomTeacherId};
    
    manager.requestSerializer=[[AFJSONRequestSerializer alloc] init];
    
    [manager.requestSerializer setValue:@"2EvZdDTprhbwbQ1Saz6Lz7YZ54qAKuFqv2j57Ezj" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:@"XScYXImf4BFkIRWGY5Xt61LfKQoC6JGSUWB5N3Un" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    
    [manager.requestSerializer setValue:currentUserSessionToken forHTTPHeaderField:@"X-Parse-Session-Token"];
    
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager PUT:donorsChooseURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        completionBlock();
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Fail: %@",error.localizedDescription);
    }];
    
}


+(void)addProposalObjectId:(NSString *) proposalObjectId toNewUserWithObjectId:(NSString *) currentUserObjectId currentUserSessionToken: (NSString *) currentUserSessionToken  andCompletionBlock:(void (^)(void))completionBlock {
    
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"https://api.parse.com/1/users/%@",currentUserObjectId];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    NSDictionary *params = @{@"proposals": @{@"__type":@"Pointer",
                                               @"className":@"Proposals",
                                               @"objectId": proposalObjectId}};
    
    manager.requestSerializer=[[AFJSONRequestSerializer alloc] init];
    
    [manager.requestSerializer setValue:@"2EvZdDTprhbwbQ1Saz6Lz7YZ54qAKuFqv2j57Ezj" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:@"XScYXImf4BFkIRWGY5Xt61LfKQoC6JGSUWB5N3Un" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    
    [manager.requestSerializer setValue:currentUserSessionToken forHTTPHeaderField:@"X-Parse-Session-Token"];
    
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager PUT:donorsChooseURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        completionBlock();
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Fail: %@",error.localizedDescription);
    }];
    
}

+(void)createProposalWithId:(NSString *) proposalId withTeacherObjectId: (NSString *)teacherObjectId andCompletionBlock:(void (^)(NSDictionary *))completionBlock {
    
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"https://api.parse.com/1/classes/Proposals/"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{@"proposalId":proposalId,@"teacherId": @{@"__type":@"Pointer",
                                                                      @"className":@"_User",
                                                                      @"objectId": teacherObjectId}};
    
    manager.requestSerializer=[[AFJSONRequestSerializer alloc] init];
    [manager.requestSerializer setValue:ParseApplicationId forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:ParseRestAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager POST:donorsChooseURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        completionBlock(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Create New Proposal Failed: %@",error.localizedDescription);
    }];
}

+(void) getDonationsListForProposalWithObjectId: (NSString *) proposalObjectId andCompletionBlock:(void (^)(NSArray *))completionBlock {
    
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"https://api.parse.com/1/classes/Proposals/"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{@"proposalId":proposalObjectId};
    
    manager.requestSerializer=[[AFJSONRequestSerializer alloc] init];
    [manager.requestSerializer setValue:ParseApplicationId forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:ParseRestAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager GET:donorsChooseURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        completionBlock(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Create New Proposal Failed: %@",error.localizedDescription);
    }];
}

+(void) getProposalObjectIdForProposalId: (NSString *) proposalId andCompletionBlock:(void (^)(NSString *))completionBlock {
    
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"https://api.parse.com/1/classes/Proposals/"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{@"proposalId":proposalId};
    
    manager.requestSerializer=[[AFJSONRequestSerializer alloc] init];
    [manager.requestSerializer setValue:ParseApplicationId forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:ParseRestAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager GET:donorsChooseURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        completionBlock(responseObject[@"objectId"]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Create New Proposal Failed: %@",error.localizedDescription);
    }];
}


@end
