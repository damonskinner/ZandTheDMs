//
//  AppDelegate.h
//  TeachersChoose
//
//  Created by Damon Skinner on 4/1/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FISDonorsChooseDatastore.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) FISDonorsChooseDatastore *datastore;


@end

