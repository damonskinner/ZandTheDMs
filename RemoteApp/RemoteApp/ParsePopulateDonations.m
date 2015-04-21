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
#import "FISDonorsChooseAPI.h"


@implementation ParsePopulateDonations


+(void) populateDonationsForProposalWithObjectId: (NSString *) proposalObjectId andproposalId: (NSString *) proposalId {
    
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
    NSMutableArray *newDonationArray= [[NSMutableArray alloc]init];
    
    [FISDonorsChooseAPI getProposalObjectForProposalId:proposalId andCompletionBlock:^(NSDictionary *proposalDict) {
        NSInteger currentTotalDonated = [proposalDict[@"totalPrice"] integerValue] - [proposalDict[@"costToComplete"] integerValue];
        

        
        NSInteger numberOfDonors = [proposalDict[@"numDonors"] integerValue];
        for (NSInteger i=0; i<numberOfDonors; i++) {
            NSInteger randomDonationIndex = arc4random_uniform([donationsArray count]-1);
            [newDonationArray addObject:donationsArray[randomDonationIndex]];
            if ([donationsArray count] >2) {
                [donationsArray removeObjectAtIndex:randomDonationIndex];
            }
        }
        
        for (FISDonation *eachDonation in newDonationArray) {
            if ([eachDonation isEqual:newDonationArray.lastObject]) {
                eachDonation.donationAmount = [NSString stringWithFormat:@"%ld",currentTotalDonated];
            } else {
                eachDonation.donationAmount =[NSString stringWithFormat:@"%u",arc4random_uniform(.5*currentTotalDonated)];
                if ([eachDonation.donationAmount integerValue]<1) {
                    eachDonation.donationAmount=[NSString stringWithFormat:@"1"];
                }
                currentTotalDonated -= [eachDonation.donationAmount integerValue];
            }
        }
        
        for (FISDonation *eachDonation in newDonationArray) {
            [FISParseAPI createDonationForProposalObjectId:proposalObjectId withName:eachDonation.donorName withDonorLocation:eachDonation.donorLocation donorMessage:eachDonation.donorMessage responseMessage:eachDonation.responseMessage donationAmount:eachDonation.donationAmount andCompletionBlock:^(NSDictionary *responseObject) {
                eachDonation.donationObjectId=responseObject[@"objectId"];
                [FISParseAPI addDonationObjectId:eachDonation.donationObjectId toProposalWithObjectId:proposalObjectId andCompletionBlock:^{
                    
                }];
            }];
        }
        
    }];
    
//    NSInteger randomNumberOfDonations = arc4random_uniform([donationsArray count]);
//    
//    if (randomNumberOfDonations<3) {
//        randomNumberOfDonations=3;
//    }
//    for (NSInteger i=0; i<randomNumberOfDonations; i++) {
//        NSInteger randomDonationIndex = arc4random_uniform([donationsArray count]-1);
//        [newDonationArray addObject:donationsArray[randomDonationIndex]];
//        [donationsArray removeObjectAtIndex:randomDonationIndex];
//    }
    
    
    
    
}

@end
