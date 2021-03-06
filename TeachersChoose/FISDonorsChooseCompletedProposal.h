//
//  FISDonorsChooseCompletedProposal.h
//  TeachersChoose
//
//  Created by Damon Skinner on 4/8/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FISDonorsChooseProposal.h"

@interface FISDonorsChooseCompletedProposal : FISDonorsChooseProposal

@property (nonatomic, strong) NSString *fullyFundedDate;
@property (nonatomic, strong) NSString *waitingForCheckPayment;
@property (nonatomic, strong) NSString *modifiedDate;
@property (nonatomic, strong) NSDictionary *thankYouAssets;


+(FISDonorsChooseCompletedProposal *)proposalFromDictionary:(NSDictionary *)proposalDictionary;


-(NSString *)updatingFullyFundedDate;
    

+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSDate *)dateFromString:(NSString *)fullyFundedDate;


@end
