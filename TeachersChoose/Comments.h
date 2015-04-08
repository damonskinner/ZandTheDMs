//
//  Comments.h
//  TeachersChoose
//
//  Created by Cooper Veysey on 4/8/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comments : NSObject

@property (strong, nonatomic) NSString *commentNameFromLocationCopy;
@property (strong, nonatomic) NSString *commentDonationGivenDate;
@property (strong, nonatomic) NSString *commentDonorMessageCopy;

-(id)initWithCommentNameFromLocationCopy:(NSString *)commentNameFromLocationCopy
                commentDonationGivenDate: (NSString *)commentDonationGivenDate
                 commentDonorMessageCopy: (NSString *)commentDonorMessageCopy;
@end
