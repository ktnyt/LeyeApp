/******************************************************************************
**  LACameraViewController.m
**  LeyeApp
**
**  Created by kotone on 2014/04/19.
**  Copyright (c) 2014 Kotone Itaya. All rights reserved.
**
** This file is part of LeyeApp.
**
** LeyeApp is free software: you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation, either version 3 of the License, or
** (at your option) any later version.
**
** LeyeApp is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with LeyeApp.  If not, see <http://www.gnu.org/licenses/>.
******************************************************************************/

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
