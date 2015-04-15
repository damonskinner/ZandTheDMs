//
//  HomePageTableViewController.h
//  TeachersChoose
//
//  Created by Damon Skinner on 4/8/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import <JPBFloatingTextViewController.h>
#import "FISDonorsChooseDatastore.h"

@interface HomePageTableViewController : JPBFloatingTextViewController

@property (nonatomic, strong) FISDonorsChooseDatastore *datastore;

@end
