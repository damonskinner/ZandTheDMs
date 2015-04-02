//
//  FISParseAPI.h
//  TeachersChoose
//
//  Created by Damon Skinner on 4/2/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISParseAPI : NSObject

+(void)addRandomTeacherId:(NSString *) randomTeacherId toNewUserWithObjectId:(NSString *) currentUserObjectId currentUserSessionToken: (NSString *) currentUserSessionToken  andCompletionBlock:(void (^)(void))completionBlock;


@end
