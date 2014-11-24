/******************************************************************************
**  LAMainViewController.m
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

#import "LAMainViewController.h"

@interface LAMainViewController ()

@end

@implementation LAMainViewController

@synthesize image;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setRecording:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showPreview:) name:@"CellTapped" object:nil];
}

- (void)showPreview:(NSNotification *)notifiation
{
    NSDictionary *userInfo = [notifiation userInfo];
    [self setImage:[userInfo objectForKey:@"Image"]];
    [self performSegueWithIdentifier:@"PreviewSegue" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"PreviewSegue"]) {
        LAPreviewViewController *destination = [segue destinationViewController];
        [destination setImage:image];
    }
}

- (IBAction)unwindToMain:(UIStoryboardSegue *)segue
{

}

- (IBAction)tapHandler:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CameraContainerTapped" object:self];
}

@end
