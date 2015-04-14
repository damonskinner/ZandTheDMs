//
//  FISCommentInputAccessoryView.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/13/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "FISCommentInputAccessoryView.h"

@implementation FISCommentInputAccessoryView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self){
        [self setBackgroundColor: [UIColor lightGrayColor]];
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (frame.size.width/2), frame.size.height)];
        [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];

        UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(cancelButton.frame.size.width, 0, cancelButton.frame.size.width, cancelButton.frame.size.height)];
        [saveButton setTitle:@"Save" forState:UIControlStateNormal];
        [saveButton setEnabled: NO];
        
        self.saveButton = saveButton;
        self.cancelButton = cancelButton;
        
        [self addSubview: self.cancelButton];
        [self addSubview: self.saveButton];
    }
    return self;
}



@end
