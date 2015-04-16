//
//  FISDonation.h
//  TeachersChoose
//
//  Created by Damon Skinner on 4/5/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISDonation : NSObject

@property (nonatomic, strong) NSString *donorName;
@property (nonatomic, strong) NSString *donorMessage;
@property (nonatomic, strong) NSString *donorLocation;
@property (nonatomic) BOOL hasResponded;
@property (nonatomic, strong) NSString *responseMessage;
@property (nonatomic, strong) NSString *proposalId;
@property (nonatomic, strong) NSDate *donationDate;
@property (nonatomic, strong) NSString *donationAmount;

@property (nonatomic, strong) NSString *donationObjectId;


+(FISDonation *)donationFromDictionary:(NSDictionary *)donationDictionary;
- (instancetype)initWithName: (NSString *) donorName Location: (NSString *) donorLocation Date: (NSDate *) donationDate DonorMessage: (NSString *) donorMessage ResponseMessage: (NSString *) responseMessage DonationAmount: (NSString *) donationAmount;

//+(BOOL) hasResponded;

@end
