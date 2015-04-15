//
//  FISComment.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/10/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "FISComment.h"

@implementation FISComment

-(instancetype)initWithTeacherComment:(NSString *)teacherComment
{
    FISComment *newComment = [[FISComment alloc] init];
    
    newComment.commentBody = teacherComment;
    newComment.commentType = CommentFromTeacher;
    
    return newComment;
}

-(instancetype)initWithDonorComment:(NSString *)donorComment
{
    FISComment *newComment = [[FISComment alloc] init];
    
    newComment.commentBody = donorComment;
    newComment.commentType = CommentFromDonor;
    
    return newComment;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%d: %@", _commentType, _commentBody];
}

@end
