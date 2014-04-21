//
//  LAMainViewController.m
//  LeyeApp
//
//  Created by kotone on 2014/04/19.
//  Copyright (c) 2014年 Kotone Itaya. All rights reserved.
//

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
