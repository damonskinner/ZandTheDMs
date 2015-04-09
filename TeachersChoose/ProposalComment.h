//
//  Comments.h
//  TeachersChoose
//
//  Created by Cooper Veysey on 4/8/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FISDonation;
@interface ProposalComment : NSObject

@property (strong, nonatomic) NSString *donorName;
@property (nonatomic, strong) NSString *donorLocation;
@property (strong, nonatomic) NSDate *donationGivenDate;
@property (strong, nonatomic) NSString *donorMessageCopy;

+(ProposalComment*) initWithDonation:(FISDonation*) donation;

@end
