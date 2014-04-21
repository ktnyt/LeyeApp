//
//  LACameraViewController.m
//  LeyeApp
//
//  Created by ;; on 2014/04/19.
//  Copyright (c) 2014年 Kotone Itaya. All rights reserved.
//

#import "LACameraViewController.h"

@interface LACameraViewController ()

@end

@implementation LACameraViewController

@synthesize imageArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(takePicture:) name:@"CameraContainerTapped" object:nil];
    [self setDelegate:self];
    [self setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self setCameraDevice:UIImagePickerControllerCameraDeviceFront];
    [self setMediaTypes:[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera]];
    [self setShowsCameraControls:NO];
}

- (void)takePicture:(NSNotification *)notification
{
    [self setCameraCaptureMode:UIImagePickerControllerCameraCaptureModePhoto];
    [self takePicture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([info valueForKey:UIImagePickerControllerOriginalImage] != nil) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:image forKey:@"Image"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ImageUpdated" object:self userInfo:userInfo];
        return;
    }
}

@end
