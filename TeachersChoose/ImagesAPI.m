//
//  ImagesAPI.m
//  TeachersChoose
//
//  Created by Damon Skinner on 4/8/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "ImagesAPI.h"
#import <AFNetworking.h>

@implementation ImagesAPI



+(void) getImageWithURLString:(NSString *)URLString andCompletion:(void (^)(UIImage *))completionBlock {
    
    NSString *randomPugImageURL = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [[AFImageResponseSerializer alloc] init];
    
    [manager GET:randomPugImageURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        completionBlock(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Failed Image Download: %@",error.localizedDescription);
    }];
    
    
}

@end
