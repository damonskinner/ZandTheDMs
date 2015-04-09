//
//  CustomItemUIActivityItemProvider.h
//  TeachersChoose
//
//  Created by Ian Smith on 4/9/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FISDonorsChooseProposal;

@interface CustomItemUIActivityItemProvider : UIActivityItemProvider

-(id)initWithProposal:(FISDonorsChooseProposal *)proposal andPlaceholder:(NSString *)text;

@property (strong, nonatomic) FISDonorsChooseProposal *proposal;

@end
