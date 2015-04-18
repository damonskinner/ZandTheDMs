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
        
        
        completionBlock();
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Fail: %@",error.localizedDescription);
    }];
    
}


+(void)addProposalObjectId:(NSString *) proposalObjectId toNewUserWithObjectId:(NSString *) currentUserObjectId currentUserSessionToken: (NSString *) currentUserSessionToken  andCompletionBlock:(void (^)(void))completionBlock {
    
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"https://api.parse.com/1/users/%@",currentUserObjectId];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    

    
    NSDictionary *params = @{@"proposals": @{
                                 @"__op": @"AddRelation",
                                 @"objects": @[@{@"__type":@"Pointer",
                                               @"className":@"Proposals",
                                               @"objectId": proposalObjectId}]
                                             }};
    
    
    manager.requestSerializer=[[AFJSONRequestSerializer alloc] init];
    
    [manager.requestSerializer setValue:@"2EvZdDTprhbwbQ1Saz6Lz7YZ54qAKuFqv2j57Ezj" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:@"XScYXImf4BFkIRWGY5Xt61LfKQoC6JGSUWB5N3Un" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    
    [manager.requestSerializer setValue:currentUserSessionToken forHTTPHeaderField:@"X-Parse-Session-Token"];
    
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager PUT:donorsChooseURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        completionBlock();
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Adding Parse Proposal Failed: %@",error.localizedDescription);
    }];
    
}

+(void) attachTeacherId:(NSString *) teacherId toInstallationWithObjectId: (NSString *) installObjectId  andCompletionBlock:(void (^)(void))completionBlock {
    
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"https://api.parse.com/1/installations/%@",installObjectId];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{@"teacherId":teacherId};
    
    manager.requestSerializer=[[AFJSONRequestSerializer alloc] init];
    [manager.requestSerializer setValue:ParseApplicationId forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:ParseRestAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager PUT:donorsChooseURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        completionBlock();
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Attach TeacherId To Installation Failed: %@",error.localizedDescription);
    }];
}




+(void)createProposalWithId:(NSString *) proposalId proposalTitle: (NSString *) proposalTitle withTeacherObjectId: (NSString *)teacherObjectId andCompletionBlock:(void (^)(NSDictionary *))completionBlock {
    
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"https://api.parse.com/1/classes/Proposals/"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{@"proposalId":proposalId,
                             @"title":proposalTitle,
                             @"teacherId": @{@"__type":@"Pointer",
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
    
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"https://api.parse.com/1/classes/Donations/"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//    NSDictionary *params = @{@"where":@[@{@"$relatedTo":
//                                            @{@"object": @{
//                                                      @"__type": @"Pointer",
//                                                      @"className": @"Proposals",
//                                                      @"objectId":proposalId},@"key":@"proposal"
//        }}]};
    
    NSDictionary *params = @{@"where": @{@"proposal": @{@"__type": @"Pointer",
                                                        @"className": @"Proposals",
                                                        @"objectId":proposalId}}};
    
    
    manager.requestSerializer=[[AFJSONRequestSerializer alloc] init];
    [manager.requestSerializer setValue:ParseApplicationId forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:ParseRestAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager GET:donorsChooseURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        completionBlock(responseObject[@"results"]);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Create New Proposal Failed: %@",error.localizedDescription);
    }];
}

+(void) getInstallationObjectIdForDeviceToken: (NSString *) deviceToken andCompletionBlock:(void (^)(NSString *))completionBlock {
    
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"https://api.parse.com/1/installations/"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    NSDictionary *params = @{@"where": @{@"deviceToken":deviceToken}};
    
    manager.requestSerializer=[[AFJSONRequestSerializer alloc] init];
    [manager.requestSerializer setValue:ParseApplicationId forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:ParseRestAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [manager.requestSerializer setValue:@"N38N3gE53WDaot5TOhAcHl494hrSrAAtLKepqyLM" forHTTPHeaderField:@"X-Parse-Master-Key"];
    
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager GET:donorsChooseURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        completionBlock(responseObject[@"results"][0][@"objectId"]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Retrieve Installation ObjectId Failed: %@",error.localizedDescription);
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

+(void) addDonationResponseMessage:(NSString *) responseMessage forDonationWithObjectId: (NSString *) donationObjectId andCompletionBlock:(void (^)(void))completionBlock {
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"https://api.parse.com/1/classes/Donations/%@",donationObjectId];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{@"responseMessage":responseMessage};
    
    manager.requestSerializer=[[AFJSONRequestSerializer alloc] init];
    [manager.requestSerializer setValue:ParseApplicationId forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:ParseRestAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager PUT:donorsChooseURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        completionBlock();
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Add Donation Response Message Failed: %@",error.localizedDescription);
    }];
}
#pragma mark - Push Notifications
+(void)sendPushNotificationToEveryone {
    NSString *pushURLString = [NSString stringWithFormat:@"https://api.parse.com/1/push"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{       @"where": @{@"deviceType": @"ios"},
                                    @"data": @{@"alert": @"Don't fuck up your interview again !"}};
    
    manager.requestSerializer=[[AFJSONRequestSerializer alloc] init];
    
    [manager.requestSerializer setValue:@"2EvZdDTprhbwbQ1Saz6Lz7YZ54qAKuFqv2j57Ezj" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:@"XScYXImf4BFkIRWGY5Xt61LfKQoC6JGSUWB5N3Un" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [manager.requestSerializer setValue:@"application/json"                         forHTTPHeaderField:@"Content-Type"];
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager POST:pushURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Fail: %@",error.localizedDescription);
    }];
}




+(void)createDonationForProposalObjectId:(NSString *)proposalObjectId withName:(NSString *) donorName withDonorLocation: (NSString *)donorLocation donorMessage: (NSString *) donorMessage responseMessage: (NSString *) responseMessage donationAmount: (NSString *) donationAmount andCompletionBlock:(void (^)(NSDictionary *))completionBlock {
    
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"https://api.parse.com/1/classes/Donations/"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{@"donorName":donorName,
                             @"donorLocation":donorLocation,
                             @"donorMessage":donorMessage,
                             @"responseMessage":responseMessage,
                             @"donationAmount":donationAmount,
                             @"proposal": @{@"__type":@"Pointer",
                                             @"className":@"Proposals",
                                             @"objectId": proposalObjectId}};
    
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


+(void)addDonationObjectId:(NSString *) donationObjectId toProposalWithObjectId:(NSString *) proposalObjectId andCompletionBlock:(void (^)(void))completionBlock {
    
    NSString *donorsChooseURLString = [NSString stringWithFormat:@"https://api.parse.com/1/classes/Proposals/%@",proposalObjectId];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    
    NSDictionary *params = @{@"donations": @{
                                     @"__op": @"AddRelation",
                                     @"objects": @[@{@"__type":@"Pointer",
                                                     @"className":@"Donations",
                                                     @"objectId": donationObjectId}]
                                     }};
    
    
    manager.requestSerializer=[[AFJSONRequestSerializer alloc] init];
    
    [manager.requestSerializer setValue:@"2EvZdDTprhbwbQ1Saz6Lz7YZ54qAKuFqv2j57Ezj" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:@"XScYXImf4BFkIRWGY5Xt61LfKQoC6JGSUWB5N3Un" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager PUT:donorsChooseURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        completionBlock();
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Adding Parse Donation Relation Failed: %@",error.localizedDescription);
    }];
    
}

@end
