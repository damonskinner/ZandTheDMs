//
//  FISDonorsChooseProposal.h
//  playingWithDonorsChooseAPI
//
//  Created by Damon Skinner on 3/30/15.
//  Copyright (c) 2015 Damon Skinner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISDonorsChooseProposal : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *shortDesc;
@property (nonatomic, strong) NSString *proposalImageURL;
@property (nonatomic, strong) NSNumber *numberOfDonors;

+(FISDonorsChooseProposal *)proposalFromDictionary:(NSDictionary *)proposalDictionary;

@end
