//
//  FISParseAPI.m
//  TeachersChoose
//
//  Created by Damon Skinner on 4/2/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "FISParseAPI.h"
#import <AFNetworking.h>

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
        
        
        //        completionBlock(responseObject[@"results"]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Fail: %@",error.localizedDescription);
    }];
    
}


@end
