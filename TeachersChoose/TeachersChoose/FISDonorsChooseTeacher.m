//
//  FISDonorsChooseTeacher.m
//  TeachersChoose
//
//  Created by Damon Skinner on 4/1/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "FISDonorsChooseTeacher.h"

@implementation FISDonorsChooseTeacher


+(FISDonorsChooseTeacher *)teacherFromDictionary:(NSDictionary *)teacherDictionary
{
    FISDonorsChooseTeacher *teacher = [[FISDonorsChooseTeacher alloc] init];
    
    teacher.city=teacherDictionary[@"city"];
    teacher.teacherDescription=teacherDictionary[@"description"];
    teacher.donations=teacherDictionary[@"donations"];
    teacher.donationsTotalCount=teacherDictionary[@"donationsTotalCount"];
    teacher.gradeLevel=teacherDictionary[@"gradeLevel"];
    teacher.teacherId=teacherDictionary[@"id"];
    teacher.joinedOn=teacherDictionary[@"joinedOn"];
    teacher.name=teacherDictionary[@"name"];
    teacher.photoURL=teacherDictionary[@"photoURL"];
    teacher.povertyLevel=teacherDictionary[@"povertyLevel"];
    teacher.profileURL=teacherDictionary[@"profileURL"];
    teacher.proposalMessages=teacherDictionary[@"proposalMessages"];
    teacher.proposals=teacherDictionary[@"proposals"];
    teacher.schoolName=teacherDictionary[@"schoolName"];
    teacher.state=teacherDictionary[@"state"];
    teacher.supporters=teacherDictionary[@"supporters"];
    teacher.teacherChallengeId=teacherDictionary[@"teacherChallengeId"];
    teacher.totalProposals=teacherDictionary[@"totalProposals"];
    teacher.zip=teacherDictionary[@"zip"];
    teacher.zone=teacherDictionary[@"zone"];
    
    
    
    return teacher;
}

@end
