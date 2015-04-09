//
//  FISDonation.m
//  TeachersChoose
//
//  Created by Damon Skinner on 4/5/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "FISDonation.h"

@implementation FISDonation

+(FISDonation *)donationFromDictionary:(NSDictionary *)donationDictionary
{
    FISDonation *donation = [[FISDonation alloc] init];
    
    donation.donorName=donationDictionary[@"donorName"];
    donation.donorLocation=donationDictionary[@"donorLocation"];
    donation.donorMessage=donationDictionary[@"donorMessage"];
    donation.donationDate=donationDictionary[@"donationDate"];
    donation.hasResponded=donationDictionary[@"hasResponded"];
    donation.responseMessage=donationDictionary[@"responseMessage"];
    donation.proposalId=donationDictionary[@"proposalId"];
    donation.donationAmount=donationDictionary[@"donationAmount"];
    
    
    
    return donation;
}


- (instancetype)initWithName: (NSString *) donorName Location: (NSString *) donorLocation Date: (NSDate *) donationDate DonorMessage: (NSString *) donorMessage ResponseMessage: (NSString *) responseMessage DonationAmount: (NSString *) donationAmount
{
    self = [super init];
    if (self) {
        _donorName=donorName;
        _donorLocation=donorLocation;
        _donorMessage=donorMessage;
        _responseMessage=responseMessage;
        _donationAmount=donationAmount;
        _donationDate=donationDate;
        if ([_responseMessage length]>0) {
            _hasResponded=YES;
        } else {
            _hasResponded=NO;
        }
    }
    return self;
}

@end
