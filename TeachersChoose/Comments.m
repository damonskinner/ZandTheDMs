//
//  Comments.m
//  TeachersChoose
//
//  Created by Cooper Veysey on 4/8/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "Comments.h"

@implementation Comments

-(id)initWithDonorName:(NSString *)donorName
         donorLocation:(NSString *)donorLocation
     donationGivenDate:(NSDate *)donationGivenDate
donorMessageCopy:(NSString *)donorMessageCopy
{
    self = [super init];
    if (self) {
        _donorName = [donorName copy];
        _donorLocation = [donorLocation copy];
        _donationGivenDate = donationGivenDate;
        _donorMessageCopy = [donorMessageCopy copy];
    }
    return self;
}

@end
