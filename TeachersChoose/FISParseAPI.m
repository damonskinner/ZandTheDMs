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


+(void)createDonationWithName:(NSString *) donorName withDonorLocation: (NSString *)donorLocation donorMessage: (NSString *) donorMessage responseMessage: (NSString *) responseMessage donationAmount: (NSString *) donationAmount donationDate: (NSDate *)donationDate andCompletionBlock:(void (^)(NSDictionary *))completionBlock {
    
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"https://api.parse.com/1/classes/Donations/"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{@"donorName":donorName,@"donorLocation":donorLocation,@"donorMessage":donorMessage,@"responseMessage":responseMessage,@"donationAmount":donationAmount,@"donationDate":donationDate};
    
    manager.requestSerializer=[[AFJSONRequestSerializer alloc] init];
    [manager.requestSerializer setValue:ParseApplicationId forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:ParseRestAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager POST:donorsChooseURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        completionBlock(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Create New Donation Failed: %@",error.localizedDescription);
    }];
}

//need to test this method
+(void) getDonationsListForProposalWithId: (NSString *) proposalId andCompletionBlock:(void (^)(NSArray *))completionBlock {
    
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"https://api.parse.com/1/classes/Proposals/"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{@"where": @{@"proposalId":proposalId},
                             @"limit":@20,
                             @"include":@"donationsList"};
    
    manager.requestSerializer=[[AFJSONRequestSerializer alloc] init];
    [manager.requestSerializer setValue:ParseApplicationId forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:ParseRestAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager GET:donorsChooseURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"results"] count]!=0) {
            completionBlock(responseObject[@"results"][0][@"donationsList"]);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Create New Proposal Failed: %@",error.localizedDescription);
    }];
}


+(void) getDonationforDonationWithObjectId: (NSString *) donationObjectId andCompletionBlock:(void (^)(NSDictionary *))completionBlock {
    
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"https://api.parse.com/1/classes/Donations/%@",donationObjectId];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //    NSDictionary *params = @{@"proposalId":proposalObjectId};
    
    manager.requestSerializer=[[AFJSONRequestSerializer alloc] init];
    [manager.requestSerializer setValue:ParseApplicationId forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:ParseRestAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager GET:donorsChooseURLString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        completionBlock(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Retrieve Donation Object Failed: %@",error.localizedDescription);
    }];
}


//need to test this method
+(void) getProposalObjectIdForProposalId: (NSString *) proposalId andCompletionBlock:(void (^)(NSString *))completionBlock {
    
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"https://api.parse.com/1/classes/Proposals/"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    NSDictionary *params = @{@"where": @{@"proposalId":proposalId}};
    
    manager.requestSerializer=[[AFJSONRequestSerializer alloc] init];
    [manager.requestSerializer setValue:ParseApplicationId forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:ParseRestAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager GET:donorsChooseURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        completionBlock(responseObject[@"results"][0][@"objectId"]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Create New Proposal Failed: %@",error.localizedDescription);
    }];
}



+(void) getTeacherIdForObjectId: (NSString *) teacherObjectId andCompletionBlock:(void (^)(NSString *))completionBlock {
    
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"https://api.parse.com/1/users/%@",teacherObjectId];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
//    NSDictionary *params = @{@"where": @{@"proposalId":proposalId}};
    //    NSDictionary *params = @{@"proposalId":proposalId};
    
    manager.requestSerializer=[[AFJSONRequestSerializer alloc] init];
    [manager.requestSerializer setValue:ParseApplicationId forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:ParseRestAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager GET:donorsChooseURLString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        completionBlock(responseObject[@"teacherId"]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Create New Proposal Failed: %@",error.localizedDescription);
    }];
}

+(void) addDonationResponseMessage:(NSString *) responseMessage forDonationWithObjectId: (NSString *) donationObjectId andCompletionBlock:(void (^)(NSDictionary *))completionBlock {
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"https://api.parse.com/1/classes/Donations/%@",donationObjectId];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{@"responseMessage":responseMessage};
    
    manager.requestSerializer=[[AFJSONRequestSerializer alloc] init];
    [manager.requestSerializer setValue:ParseApplicationId forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:ParseRestAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager POST:donorsChooseURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        completionBlock(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Retrieve Donation Object Failed: %@",error.localizedDescription);
    }];
}




@end
