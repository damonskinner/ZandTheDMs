//
//  FISComment.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/10/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "FISComment.h"
#import "FISDonation.h"

NSString * const COMMENT_PLACEHOLDER = @"Tap here to reply"; // there is a matching one in FISComment

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

+(FISComment*) createDonorCommentFromDonation: (FISDonation*) donation
{
    FISComment *donorComment;
    if (!donation.donorMessage || [donation.donorMessage isEqualToString:@""])
    {
        NSString *automatedComment = [NSString stringWithFormat:@"%@ donated $%@.", donation.donorName, donation.donationAmount];
        NSLog(@"automatedComment:%@", automatedComment);
        donorComment = [[FISComment alloc] initWithDonorComment: automatedComment];
    }
    else
    {
        donorComment = [[FISComment alloc] initWithDonorComment:donation.donorMessage];
    }
    return donorComment;
}

+(FISComment*) createTeacherCommentFromDonation: (FISDonation*) donation
{
    FISComment *teacherResponse;
    if (!donation.responseMessage || [donation.responseMessage isEqualToString:@""])
    {
        NSString *tapMeText = COMMENT_PLACEHOLDER;
        teacherResponse = [[FISComment alloc] initWithTeacherComment:tapMeText];
    }
    else
    {
        teacherResponse = [[FISComment alloc] initWithTeacherComment:donation.responseMessage];
    }
    return teacherResponse;
}


-(NSString *)description
{
    return [NSString stringWithFormat:@"%d: %@", _commentType, _commentBody];
}

@end
