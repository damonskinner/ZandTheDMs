//
//  DetailsTabBarController.h
//  TeachersChoose
//
//  Created by Tom OMalley on 4/3/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FISDonorsChooseProposal.h"


@interface DetailsTabBarController : UITabBarController

@property (nonatomic, strong) FISDonorsChooseProposal *selectedProposal;

@end
