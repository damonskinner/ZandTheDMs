//
//  AppDelegate.m
//  TeachersChoose
//
//  Created by Damon Skinner on 4/1/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "AppDelegate.h"
#import "FISDonorsChooseDatastore.h"
#import "FISDonorsChooseProposal.h"


@interface AppDelegate ()

@property (nonatomic, strong) FISDonorsChooseDatastore *datastore;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.datastore = [FISDonorsChooseDatastore sharedDataStore];
    
//    [self.datastore getSearchResultsWithLocation:@"Brooklyn" andCompletion:^(BOOL completion) {
//        for (FISDonorsChooseProposal *eachProposal in self.datastore.donorsChooseSearchResults)
//        {
//            NSLog(@"%@",eachProposal.title);
//            NSLog(@"%@",eachProposal.teacherId);
//        }
//        
//        NSLog(@"%ld",[self.datastore.donorsChooseSearchResults count]);
//    }];
//    
//
//    
//    [self.datastore getTeacherProfileWithTeacherId:@"58164" andCompletion:^(BOOL completion) {
//        NSLog(@"%@",self.datastore.currentTeacher.name);
//
//
//        
//    }];
    [self.datastore getSearchResultsWithTeacherId:@"2800005" andCompletion:^(BOOL completion) {
        
        
        NSLog(@"%@",self.datastore.currentTeacherProposals);
        
    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
