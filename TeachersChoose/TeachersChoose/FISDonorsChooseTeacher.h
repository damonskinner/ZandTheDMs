//
//  FISDonorsChooseTeacher.h
//  TeachersChoose
//
//  Created by Damon Skinner on 4/1/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FISDonorsChooseTeacher : NSObject

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *teacherDescription;
@property (nonatomic, strong) NSArray *donations;
@property (nonatomic, strong) NSString *donationsTotalCount;
@property (nonatomic, strong) NSDictionary *gradeLevel;
@property (nonatomic, strong) NSString *teacherId;
@property (nonatomic, strong) NSString *joinedOn;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *photoURL;
@property (nonatomic, strong) NSString *povertyLevel;
@property (nonatomic, strong) NSString *profileURL;
@property (nonatomic, strong) NSArray *proposalMessages;
@property (nonatomic, strong) NSArray *proposals;
@property (nonatomic, strong) NSString *schoolName;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSArray *supporters;
@property (nonatomic, strong) NSString *teacherChallengeId;
@property (nonatomic, strong) NSString *totalProposals;
@property (nonatomic, strong) NSString *zip;
@property (nonatomic, strong) NSDictionary *zone;

@property (nonatomic, strong) UIImage *image;

+(FISDonorsChooseTeacher *)teacherFromDictionary:(NSDictionary *)teacherDictionary;



@end
