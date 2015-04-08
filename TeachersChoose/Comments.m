//
//  Comments.m
//  TeachersChoose
//
//  Created by Cooper Veysey on 4/8/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "Comments.h"

@implementation Comments

-(id)initWithCommentNameFromLocationCopy:(NSString *)commentNameFromLocationCopy
                commentDonationGivenDate: (NSString *)commentDonationGivenDate
                 commentDonorMessageCopy: (NSString *)commentDonorMessageCopy;
{
    self = [super init];
    if (self) {
        _commentNameFromLocationCopy = [commentNameFromLocationCopy  copy];
        _commentDonationGivenDate = [commentDonationGivenDate copy];
        _commentDonorMessageCopy = [commentDonorMessageCopy copy];
    }
    return self;
}

@end
