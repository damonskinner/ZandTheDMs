//
//  CustomItemUIActivityItemProvider.m
//  TeachersChoose
//
//  Created by Ian Smith on 4/9/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "CustomItemUIActivityItemProvider.h"
#import "FISDonorsChooseProposal.h"

@implementation CustomItemUIActivityItemProvider

- (id)initWithProposal:(FISDonorsChooseProposal *)proposal andPlaceholder:(NSString *)text {
	self = [super initWithPlaceholderItem:text];

	if (self) {
		_proposal = proposal;
	}

	return self;
}

- (id)item {
	NSString *formattedURL = [self.proposal.proposalURL componentsSeparatedByString:@"?"][0];
	NSString *shareText = [NSString stringWithFormat:@"Hi Friends,\n\nI want to make sure my students have the materials they need to suceed, so I just created a request for my classroom on DonorsChoose.org:\n\n%@\n\nYour support would mean so much to my students. If you chip in to help, we'll send awesome photos and our heartfelt thanks.\n\nThanks so much,\n%@\n\nP.S. If you know anyone who may want to help my classroom, please pass this along!", formattedURL, self.proposal.teacherName];

	if (self.activityType == UIActivityTypeMail || self.activityType == UIActivityTypePostToFacebook) {
		return [NSString stringWithFormat:@"%@", shareText];
	}
	else if (self.activityType == UIActivityTypePostToTwitter || self.activityType == UIActivityTypeMessage) {
		NSString *tweetText = [NSString stringWithFormat:@"Check out my DonorsChoose.org project %@ - %@", self.proposal.title, formattedURL];
		return [NSString stringWithFormat:@"%@", tweetText];
	}
	else {
		return [NSString stringWithFormat:@"%@", shareText];
	}
}

@end
