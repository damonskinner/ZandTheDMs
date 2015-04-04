//
//  MainTableViewViewController.h
//  TeachersChoose
//
//  Created by Cooper Veysey on 4/2/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FISDonorsChooseDatastore.h"

@interface MainTableViewViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) FISDonorsChooseDatastore *datastore;

@end
