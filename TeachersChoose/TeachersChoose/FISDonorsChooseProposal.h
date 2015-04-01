//
//  FISDonorsChooseProposal.h
//  playingWithDonorsChooseAPI
//
//  Created by Damon Skinner on 3/30/15.
//  Copyright (c) 2015 Damon Skinner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISDonorsChooseProposal : NSObject


@property (nonatomic, strong) NSArray *additionalSubjects;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *costToComplete;
@property (nonatomic, strong) NSString *expirationDate;
@property (nonatomic) BOOL freeShipping;
@property (nonatomic, strong) NSString *fulfillmentTrailer;
@property (nonatomic, strong) NSString *fundURL;
@property (nonatomic, strong) NSString *fundingStatus;
@property (nonatomic, strong) NSDictionary *gradeLevel;
@property (nonatomic, strong) NSNumber *proposalId;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSDictionary *matchingFund;
@property (nonatomic, strong) NSNumber *numDonors;
@property (nonatomic, strong) NSNumber *percentFunded;
@property (nonatomic, strong) NSString *povertyLevel;
@property (nonatomic, strong) NSString *proposalURL;
@property (nonatomic, strong) NSDictionary *resource;
@property (nonatomic, strong) NSString *schoolName;
@property (nonatomic, strong) NSArray *schoolTypes;
@property (nonatomic, strong) NSString *schoolUrl;
@property (nonatomic, strong) NSString *shortDescription;
@property (nonatomic, strong) NSArray *snippets;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *stateFullName;
@property (nonatomic, strong) NSDictionary *subject;
@property (nonatomic, strong) NSNumber *teacherId;
@property (nonatomic, strong) NSString *teacherName;
@property (nonatomic, strong) NSArray *teacherTypes;
@property (nonatomic, strong) NSString *thumbImageURL;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, strong) NSString *zip;
@property (nonatomic, strong) NSDictionary *zone;



+(FISDonorsChooseProposal *)proposalFromDictionary:(NSDictionary *)proposalDictionary;

@end
