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

@end
