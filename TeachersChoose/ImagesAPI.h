//
//  ImagesAPI.h
//  TeachersChoose
//
//  Created by Damon Skinner on 4/8/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImagesAPI : NSObject

+(void) getImageWithURLString:(NSString *)URLString andCompletion:(void (^)(UIImage *))completionBlock;

@end
