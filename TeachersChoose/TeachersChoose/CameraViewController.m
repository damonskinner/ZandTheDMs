//
//  CameraViewController.m
//  TeachersChoose
//
//  Created by Tom OMalley on 4/1/15.
//  Copyright (c) 2015 ZandTheDMs. All rights reserved.
//

#import "CameraViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface CameraViewController ()

@property (weak, nonatomic) IBOutlet UIView *frameForCapture;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCaptureDevice *captureDevice;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.captureSession = [[AVCaptureSession alloc] init];
    
    self.captureSession.sessionPreset = AVCaptureSessionPresetLow;

    // if there are devices, make self.captureDevice the first one (back camera, i think)
    if (AVCaptureDevice.devices)
    {
        self.captureDevice = AVCaptureDevice.devices[0];
        NSLog(@"%@", AVCaptureDevice.devices);
        NSLog(@"captureDevice: %@", self.captureDevice);
    }
    
}

-(void) viewWillAppear
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// invisible button is tapped to take a picture
- (IBAction)invisibleButtonTapped:(id)sender
{
    NSLog(@"invisible button tapped");
}


@end
