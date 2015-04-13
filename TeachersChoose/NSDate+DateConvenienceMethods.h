//
//  NSDate+DateConvenienceMethods.h
//  TeachersChoose
//
//  Created by Damon Skinner on 4/7/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DateConvenienceMethods)

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;
+(NSDate *) expirationDateFormatterWithDateString: (NSString *) dateString;

- (NSDate *)randomDateInYearOfDate;

@end
