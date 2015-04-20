//
//  ParsePopulateDonations.h
//  RemoteApp
//
//  Created by Ian Smith on 4/16/15.
//  Copyright (c) 2015 Ian Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParsePopulateDonations : NSObject


+(void) populateDonationsForProposalWithObjectId: (NSString *) proposalObjectId andproposalId: (NSString *) proposalId;

@end
