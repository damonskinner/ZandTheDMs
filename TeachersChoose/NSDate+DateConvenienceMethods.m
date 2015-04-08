//
//  NSDate+DateConvenienceMethods.m
//  TeachersChoose
//
//  Created by Damon Skinner on 4/7/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "NSDate+DateConvenienceMethods.h"

@implementation NSDate (DateConvenienceMethods)

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}

+(NSDate *) expirationDateFormatterWithDateString: (NSString *) dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    NSDate *capturedExpirationDate = [dateFormatter dateFromString:dateString];
    NSLog(@"Captured Date %@", [capturedExpirationDate description]);

    
    return capturedExpirationDate;
}



@end
