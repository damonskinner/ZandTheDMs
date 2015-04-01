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

    NSArray *devices = AVCaptureDevice.devices;
    
    if (devices)
    {
        // loop through all capture devices on this phone
        for (AVCaptureDevice *device in AVCaptureDevice.devices)
        {
            // make sure this particular device supports video
            if ([device hasMediaType: AVMediaTypeVideo])
            {
                // confirm that its the back camera
                if(device.position == AVCaptureDevicePositionBack)
                {
                    self.captureDevice = device;
                }
            }
        }
    }
    if (self.captureDevice)
    {
        [self beginSession];
    }
}

-(void) viewWillAppear
{
}

-(void) beginSession
{
    // make an input from the device
    NSError *error;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:&error];

    // add the input to our capture session
    [self.captureSession addInput:input];

    if (error)
    {
        NSLog(@"AVCaptureDeviceInput Error: %@", error);
    }
    
    // make a preview layer
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];

    // add it to our main view
    [self.view.layer addSublayer: previewLayer];
    
    // make preview layer frame the same as our views frame
    previewLayer.frame = self.view.layer.frame;
    
    //start the capture session!
    [self.captureSession startRunning];
    
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
