//
//  ParsePopulateDonations.m
//  RemoteApp
//
//  Created by Ian Smith on 4/16/15.
//  Copyright (c) 2015 Ian Smith. All rights reserved.
//

#import "ParsePopulateDonations.h"
#import "FISDonation.h"
#import "FISParseAPI.h"


@implementation ParsePopulateDonations


+(void) populateDonationsForProposalWithObjectId: (NSString *) proposalId {
    
    FISDonation *donation0=[[FISDonation alloc]initWithName:@"Johnny B. Gud" Location:@"San Francisco" Date:[NSDate date] DonorMessage:@"Good luck!" ResponseMessage:@"" DonationAmount:@"35.00"];
    FISDonation *donation1=[[FISDonation alloc]initWithName:@"Sandra Kyles" Location:@"New York" Date:[NSDate date] DonorMessage:@"" ResponseMessage:@"" DonationAmount:@"5.00"];
    FISDonation *donation2=[[FISDonation alloc]initWithName:@"Bartholomew Cubbins" Location:@"Idaho" Date:[NSDate date] DonorMessage:@"Wow, keep up the good work!" ResponseMessage:@"" DonationAmount:@"2.00"];
    FISDonation *donation3=[[FISDonation alloc]initWithName:@"Mimi Dieter" Location:@"Hawaii" Date:[NSDate date] DonorMessage:@"Yay learning!" ResponseMessage:@"" DonationAmount:@"40.00"];
    FISDonation *donation4=[[FISDonation alloc]initWithName:@"Adam Jones" Location:@"Miami" Date:[NSDate date] DonorMessage:@"" ResponseMessage:@"" DonationAmount:@"6.00"];
    FISDonation *donation5=[[FISDonation alloc]initWithName:@"Clarissa Starling" Location:@"Texas" Date:[NSDate date] DonorMessage:@"Good job!  Hope they learn a lot." ResponseMessage:@"" DonationAmount:@"100.00"];
    FISDonation *donation6=[[FISDonation alloc]initWithName:@"Johnny English" Location:@"Ohio" Date:[NSDate date] DonorMessage:@"Super fun!" ResponseMessage:@"" DonationAmount:@"80.00"];
    FISDonation *donation7=[[FISDonation alloc]initWithName:@"Chad Hemmingsworth" Location:@"Chicago" Date:[NSDate date] DonorMessage:@"What a cool project.  Those kids sure are lucky" ResponseMessage:@"" DonationAmount:@"20.00"];
    FISDonation *donation8=[[FISDonation alloc]initWithName:@"Jasmine Yee" Location:@"Illinois" Date:[NSDate date] DonorMessage:@"Cooooool!" ResponseMessage:@"" DonationAmount:@"10.00"];
    FISDonation *donation9=[[FISDonation alloc]initWithName:@"Charlotte Kelly" Location:@"Los Angeles" Date:[NSDate date] DonorMessage:@"" ResponseMessage:@"" DonationAmount:@"400.00"];
    
    
    NSMutableArray *donationsArray = [@[donation0,donation1,donation2,donation3,donation4,donation5,donation6,donation7,donation8,donation9] mutableCopy];
    NSMutableArray *newDonationArray= [[NSMutableArray alloc]init];
    
    NSInteger randomNumberOfDonations = arc4random_uniform([donationsArray count]);
    for (NSInteger i=0; i<randomNumberOfDonations; i++) {
        NSInteger randomDonationIndex = arc4random_uniform([donationsArray count]-1);
        [newDonationArray addObject:donationsArray[randomDonationIndex]];
        [donationsArray removeObjectAtIndex:randomDonationIndex];
    }
    
    for (FISDonation *eachDonation in newDonationArray) {
        [FISParseAPI createDonationForProposalObjectId:proposalId withName:eachDonation.donorName withDonorLocation:eachDonation.donorLocation donorMessage:eachDonation.donorMessage responseMessage:eachDonation.responseMessage donationAmount:eachDonation.donationAmount andCompletionBlock:^(NSDictionary *responseObject) {
            eachDonation.donationObjectId=responseObject[@"objectId"];
            [FISParseAPI addDonationObjectId:eachDonation.donationObjectId toProposalWithObjectId:proposalId andCompletionBlock:^{
                
            }];
        }];
    }
    
    
}

@end
