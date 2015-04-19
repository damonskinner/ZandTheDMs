//
//  FISDonorsChooseDatastore.m
//  playingWithDonorsChooseAPI
//
//  Created by Damon Skinner on 3/30/15.
//  Copyright (c) 2015 Damon Skinner. All rights reserved.
//

#import "FISDonorsChooseDatastore.h"
#import "FISDonorsChooseAPI.h"
#import "FISDonorsChooseProposal.h"
#import "FISDonorsChooseCompletedProposal.h"
#import "FISDonorsChooseTeacher.h"
#import "FISParseAPI.h"

#import "ImagesAPI.h"

@implementation FISDonorsChooseDatastore

+ (instancetype)sharedDataStore {
    static FISDonorsChooseDatastore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[FISDonorsChooseDatastore alloc] init];
    });
    
    return _sharedDataStore;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _donorsChooseSearchResults=[NSMutableArray new];
        _loggedInTeacherProposals=[NSMutableArray new];
        _loggedInTeacherCompletedProposals=[NSMutableArray new];
        _loggedInTeacher=[FISDonorsChooseTeacher new];
    }
    return self;
}

-(void)getSearchResultsWithKeyword: (NSString *) keyword andCompletion:(void (^)(BOOL))completionBlock
{
    [FISDonorsChooseAPI getSearchResultsWithKeyword:keyword andCompletionBlock:^(NSArray *proposalDictionaries) {
        for (NSDictionary *proposalDict in proposalDictionaries) {
            [self.donorsChooseSearchResults addObject:[FISDonorsChooseProposal proposalFromDictionary:proposalDict]];
        }
        completionBlock(YES);
    }];
}

-(void)getSearchResultsWithLocation: (NSString *) location andCompletion:(void (^)(BOOL))completionBlock
{
    [FISDonorsChooseAPI getSearchResultsWithLocation:location andCompletionBlock:^(NSArray *proposalDictionaries) {
        for (NSDictionary *proposalDict in proposalDictionaries) {
            [self.donorsChooseSearchResults addObject:[FISDonorsChooseProposal proposalFromDictionary:proposalDict]];
        }
        completionBlock(YES);
    }];
}

-(void)getSearchResultsWithParams: (NSDictionary *) params andCompletion:(void (^)(BOOL))completionBlock
{
    [FISDonorsChooseAPI getSearchResultsWithParams:params andCompletionBlock:^(NSArray *proposalDictionaries) {
        for (NSDictionary *proposalDict in proposalDictionaries) {
            [self.donorsChooseSearchResults addObject:[FISDonorsChooseProposal proposalFromDictionary:proposalDict]];
        }
        completionBlock(YES);
    }];
}

-(void)getSearchResultsWithTeacherId: (NSString *) teacherId andCompletion:(void (^)(BOOL))completionBlock
{
    [FISDonorsChooseAPI getSearchResultsWithTeacherId:teacherId andCompletionBlock:^(NSArray *proposalDictionaries) {
        
            for (NSDictionary *proposalDict in proposalDictionaries) {
                [self.loggedInTeacherProposals addObject:[FISDonorsChooseProposal proposalFromDictionary:proposalDict]];
                self.loggedInTeacherProposals = [self sortArray:self.loggedInTeacherProposals];
            }
        [FISDonorsChooseAPI getHistoricalSearchResultsWithTeacherId:teacherId andCompletionBlock:^(NSArray *completedProposalDictionaries) {
            for(NSDictionary *completedProposalDictionary in completedProposalDictionaries) {
                [self.loggedInTeacherCompletedProposals addObject:[FISDonorsChooseCompletedProposal proposalFromDictionary:completedProposalDictionary]];
                self.loggedInTeacherCompletedProposals = [self sortArray:self.loggedInTeacherCompletedProposals];
            }
            if([self.loggedInTeacherProposals count]>0 || self.loggedInTeacherCompletedProposals >0) {
                completionBlock(YES);
            } else {
                completionBlock(NO);
            }
            
        }];
    }];
}

-(void)getTeacherProfileWithTeacherId: (NSString *) teacherId andCompletion:(void (^)(BOOL))completionBlock
{
    [FISDonorsChooseAPI getTeacherProfileWithTeacherId:teacherId andCompletionBlock:^(NSDictionary *teacherDictionary) {
        
        self.loggedInTeacher = [FISDonorsChooseTeacher teacherFromDictionary:teacherDictionary];
        [ImagesAPI getImageWithURLString:self.loggedInTeacher.photoURL andCompletion:^(UIImage *teacherImage) {
//            CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//            gradientLayer.bounds=teacherImage.imageView
            

            self.loggedInTeacher.image=teacherImage;
            completionBlock(YES);
        }];
    }];
}


-(void) getDonationsListForProposal: (FISDonorsChooseProposal *) proposal andCompletion:(void (^)(BOOL))completionBlock {
    [FISParseAPI getDonationsListForProposalWithId:proposal.parseObjectId andCompletionBlock:^(NSArray *donations) {
        for (NSDictionary *donationDict in donations){
            [proposal.donations addObject:[FISDonation donationFromDictionary:donationDict]];
        }
        if([proposal.donations count]>0){
            completionBlock(YES);
        } else {
            completionBlock(NO);
        }
    }];
}


-(void) addNewDonationResponseMessage:(NSString *)responseMessage  forDonation: (FISDonation *) donation forProposal: (FISDonorsChooseProposal *) proposal andCompletion:(void (^)(BOOL))completionBlock {
    for (FISDonation *eachDonation in proposal.donations)
    {
        if (donation.donationObjectId == eachDonation.donationObjectId) {
            eachDonation.responseMessage=responseMessage;
        }
    }
    
    [FISParseAPI addDonationResponseMessage:responseMessage forDonationWithObjectId:donation.donationObjectId andCompletionBlock:^() {
        
        completionBlock(YES);
        
    }];
    
    
}



-(void) updateCurrentTeacherProposalsForCurrentTeacherId: (NSString *) currentTeacherId andCompletionBlock:(void (^)(void))completionBlock {
    [self getSearchResultsWithTeacherId:currentTeacherId andCompletion:^(BOOL completed) {
        
        //May need to insert more API stuff here to update any new proposals on parse
        if(completed) {
            [self createFakeFundedProposal];
            
            [self getTeacherProfileWithTeacherId:currentTeacherId andCompletion:^(BOOL completionCheck) {
                if (completionCheck) {
                    for (FISDonorsChooseProposal *eachProposal in self.loggedInTeacherProposals) {
                        [FISParseAPI getProposalObjectIdForProposalId:eachProposal.proposalId andCompletionBlock:^(NSString *returnedObjectId) {
                            eachProposal.parseObjectId=returnedObjectId;
                            [self getDonationsListForProposal:eachProposal andCompletion:^(BOOL completion) {
                                
                                if ([eachProposal isEqual:self.loggedInTeacherProposals.lastObject]) {
                                    completionBlock();
                                }
                            }];
                        }];
                    }
                }
                
            }];
        }
    }];
}

//TODO: Create sample donations function
//FIXME:
-(NSArray *) sampleDonations {

    
    
    return _sampleDonations;
}

-(NSMutableArray *) sortArray: (NSMutableArray *) proposals {
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"daysLeft"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray;
    sortedArray = [proposals sortedArrayUsingDescriptors:sortDescriptors];
    return [sortedArray mutableCopy];
}


-(void) createFakeFundedProposal {
    self.fakeFundedProposal = [((FISDonorsChooseProposal *)self.loggedInTeacherProposals[0]) copy];
    self.fakeFundedProposal.title = @"Almost there!";
    self.fakeFundedProposal.proposalId = @"9999999";
    self.fakeFundedProposal.costToComplete=@"0";
    self.fakeFundedProposal.fundingStatus=@"funded";
    self.fakeFundedProposal.expirationDate=@"2015-07-23";
    self.fakeFundedProposal.numDonors=@10;
    self.fakeFundedProposal.costToComplete=@"0";
    self.fakeFundedProposal.totalPrice=@"1000";
    [self.loggedInTeacherProposals addObject:self.fakeFundedProposal];
}

-(void) populateRandomDonationsForProposal:(FISDonorsChooseProposal *) proposal withCompletionblock:(void (^)(void))completionBlock {
    
    FISDonation *donation0=[[FISDonation alloc]initWithName:@"Johnny B. Gud" Location:@"San Francisco" Date:[NSDate date] DonorMessage:@"Good luck!" ResponseMessage:@"" DonationAmount:@"35.00"];
    FISDonation *donation1=[[FISDonation alloc]initWithName:@"Sandra Kyles" Location:@"New York" Date:[NSDate date] DonorMessage:@"Nice job" ResponseMessage:@"" DonationAmount:@"5.00"];
    FISDonation *donation2=[[FISDonation alloc]initWithName:@"Bartholomew Cubbins" Location:@"Idaho" Date:[NSDate date] DonorMessage:@"Wow, keep up the good work!" ResponseMessage:@"" DonationAmount:@"2.00"];
    FISDonation *donation3=[[FISDonation alloc]initWithName:@"Mimi Dieter" Location:@"Hawaii" Date:[NSDate date] DonorMessage:@"Yay learning!" ResponseMessage:@"" DonationAmount:@"40.00"];
    FISDonation *donation4=[[FISDonation alloc]initWithName:@"Adam Jones" Location:@"Miami" Date:[NSDate date] DonorMessage:@"Neat" ResponseMessage:@"" DonationAmount:@"6.00"];
    FISDonation *donation5=[[FISDonation alloc]initWithName:@"Clarissa Starling" Location:@"Texas" Date:[NSDate date] DonorMessage:@"Good job!  Hope they learn a lot." ResponseMessage:@"" DonationAmount:@"100.00"];
    FISDonation *donation6=[[FISDonation alloc]initWithName:@"Johnny English" Location:@"Ohio" Date:[NSDate date] DonorMessage:@"Super fun!" ResponseMessage:@"" DonationAmount:@"80.00"];
    FISDonation *donation7=[[FISDonation alloc]initWithName:@"Chad Hemmingsworth" Location:@"Chicago" Date:[NSDate date] DonorMessage:@"What a cool project.  Those kids sure are lucky" ResponseMessage:@"" DonationAmount:@"20.00"];
    FISDonation *donation8=[[FISDonation alloc]initWithName:@"Jasmine Yee" Location:@"Illinois" Date:[NSDate date] DonorMessage:@"Cooooool!" ResponseMessage:@"" DonationAmount:@"10.00"];
    FISDonation *donation9=[[FISDonation alloc]initWithName:@"Charlotte Kelly" Location:@"Los Angeles" Date:[NSDate date] DonorMessage:@"" ResponseMessage:@"" DonationAmount:@"400.00"];
    FISDonation *donation10=[[FISDonation alloc]initWithName:@"Justin Turnbull" Location:@"Los Angeles" Date:[NSDate date] DonorMessage:@"Hope the kids have fun!" ResponseMessage:@"Thanks so much for your donation!" DonationAmount:@"50.00"];
    FISDonation *donation11=[[FISDonation alloc]initWithName:@"Haley Kittredge" Location:@"Maine" Date:[NSDate date] DonorMessage:@"Impressive" ResponseMessage:@"Thanks so much for your donation!" DonationAmount:@"30.00"];
    FISDonation *donation12=[[FISDonation alloc]initWithName:@"Evan Halperstand" Location:@"Wisconsin" Date:[NSDate date] DonorMessage:@"Have fun!" ResponseMessage:@"Thanks so much for your donation!" DonationAmount:@"20.00"];
    FISDonation *donation13=[[FISDonation alloc]initWithName:@"Ian More" Location:@"Fargo" Date:[NSDate date] DonorMessage:@"Cool idea." ResponseMessage:@"Thanks so much for your donation!" DonationAmount:@"5.00"];
    FISDonation *donation14=[[FISDonation alloc]initWithName:@"Matthew Fredericks" Location:@"Oregon" Date:[NSDate date] DonorMessage:@"Looks cool." ResponseMessage:@"Thanks so much for your donation!" DonationAmount:@"5.00"];
    FISDonation *donation15=[[FISDonation alloc]initWithName:@"Kelly Harris" Location:@"Fort Lauderdale" Date:[NSDate date] DonorMessage:@"" ResponseMessage:@"Thanks so much for your donation!" DonationAmount:@"90.00"];
    FISDonation *donation16=[[FISDonation alloc]initWithName:@"Christina Sands" Location:@"Houston" Date:[NSDate date] DonorMessage:@"Such a cool idea." ResponseMessage:@"Thank you so much!" DonationAmount:@"1000.00"];
    FISDonation *donation17=[[FISDonation alloc]initWithName:@"Elliot Ness" Location:@"New York" Date:[NSDate date] DonorMessage:@"Hope your kids enjoy this project." ResponseMessage:@"Thank you!" DonationAmount:@"100.00"];
    FISDonation *donation18=[[FISDonation alloc]initWithName:@"Eric Dendy" Location:@"Brooklyn" Date:[NSDate date] DonorMessage:@"Good luck!" ResponseMessage:@"Thank you very much!" DonationAmount:@"50.00"];
    FISDonation *donation19=[[FISDonation alloc]initWithName:@"Aaron Wettle" Location:@"San Francisco" Date:[NSDate date] DonorMessage:@"Fantastic work you're doing.  Keep it up." ResponseMessage:@"You're amazing, thank you!" DonationAmount:@"20.00"];
    FISDonation *donation20=[[FISDonation alloc]initWithName:@"Michael Murray" Location:@"Sacramento" Date:[NSDate date] DonorMessage:@"Genius." ResponseMessage:@"Thanks!" DonationAmount:@"80.00"];
    FISDonation *donation21=[[FISDonation alloc]initWithName:@"Gary Oren" Location:@"New Jersey" Date:[NSDate date] DonorMessage:@"" ResponseMessage:@"Wow, thanks!" DonationAmount:@"10.00"];
    FISDonation *donation22=[[FISDonation alloc]initWithName:@"Andrea Hillen" Location:@"Pennsylvania" Date:[NSDate date] DonorMessage:@"" ResponseMessage:@"Thank you!" DonationAmount:@"10.00"];
    
    
    
    
    NSMutableArray *donationsArray = [@[donation0,donation1,donation2,donation3,donation4,donation5,donation6,donation7,donation8,donation9,donation10,donation11,donation12,donation13,donation14,donation15,donation16,donation17,donation18,donation19,donation20,donation21,donation22] mutableCopy];
    NSInteger randomNumberOfDonations = arc4random_uniform([donationsArray count]);
    if (randomNumberOfDonations<3) {
        randomNumberOfDonations=3;
    }
    for (NSInteger i=0; i<randomNumberOfDonations; i++) {
        NSInteger randomDonationIndex = arc4random_uniform([donationsArray count]-1);
        [proposal.donations addObject:donationsArray[randomDonationIndex]];
        [donationsArray removeObjectAtIndex:randomDonationIndex];
    }
    
    for (FISDonation *eachDonation in proposal.donations) {
        [FISParseAPI createDonationForProposalObjectId:proposal.parseObjectId withName:eachDonation.donorName withDonorLocation:eachDonation.donorLocation donorMessage:eachDonation.donorMessage responseMessage:eachDonation.responseMessage donationAmount:eachDonation.donationAmount andCompletionBlock:^(NSDictionary * responseObject) {
            
            eachDonation.donationObjectId=responseObject[@"objectId"];
            [FISParseAPI addDonationObjectId:eachDonation.donationObjectId toProposalWithObjectId:proposal.parseObjectId andCompletionBlock:^{
                
            }];
        }];
    }
}

@end
