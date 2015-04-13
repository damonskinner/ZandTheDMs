//
//  FISComment.h
//  TeachersChoose
//
//  Created by Tom OMalley on 4/10/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum commentType{
    CommentFromDonor, CommentFromTeacher
} commentType;

@interface FISComment : NSObject

@property (strong, nonatomic) NSString *commentBody;
@property (assign, nonatomic) enum commentType commentType;

-(instancetype) initWithTeacherComment:(NSString*) teacherComment;
-(instancetype) initWithDonorComment:(NSString *)donorComment;

@end
