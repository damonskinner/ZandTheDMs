//
//  AppDelegate.m
//  TeachersChoose
//
//  Created by Damon Skinner on 4/1/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "FISDonorsChooseProposal.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Parse setApplicationId:@"2EvZdDTprhbwbQ1Saz6Lz7YZ54qAKuFqv2j57Ezj"
                  clientKey:@"cPiKWXa9xalCvk4Irtklchy4T8p90GwZJyxk0ZLK"];
    
//    self.datastore=[FISDonorsChooseDatastore sharedDataStore];
//    
//    NSDictionary *params = @{@"location":@"NY",@"max":@"50"};
//    
//    [self.datastore getSearchResultsWithParams:params andCompletion:^(BOOL completion) {
//        
//        NSUInteger r=arc4random_uniform(50);
//        FISDonorsChooseProposal *randomProposal = self.datastore.donorsChooseSearchResults[r];
//        
//        [self.datastore getSearchResultsWithTeacherId:randomProposal.teacherId andCompletion:^(BOOL completion) {
//            
//            FISDonorsChooseProposal *firstProposalTest = self.datastore.loggedInTeacherProposals[0];
////            NSLog(@"%@",firstProposalTest.title);
////            NSLog(@"%@",firstProposalTest.shortDescription);
//            NSLog(@"%@",firstProposalTest.teacherName);
//            
//            NSLog(@"%ld",[self.datastore.loggedInTeacherProposals count]);
//            for (FISDonorsChooseProposal *eachProposal in self.datastore.loggedInTeacherProposals) {
//                NSLog(@"%@",eachProposal.title);
//                NSLog(@"%@",eachProposal.imageURL);
//                NSLog(@"%@",eachProposal.thumbImageURL);
//                
//            }
//            
//            [self.datastore getTeacherProfileWithTeacherId:firstProposalTest.teacherId andCompletion:^(BOOL completion) {
//                
//                NSLog(@"Teacher Photo: %@",self.datastore.loggedInTeacher.photoURL);
//            }];
//        }];
//    }];

    // Override point for customization after application launch.
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
