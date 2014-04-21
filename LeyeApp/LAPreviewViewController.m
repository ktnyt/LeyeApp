//
//  LAPreviewViewController.m
//  LeyeApp
//
//  Created by kotone on 2014/04/20.
//  Copyright (c) 2014年 Kotone Itaya. All rights reserved.
//

#import "LAPreviewViewController.h"

@interface LAPreviewViewController ()

@end

@implementation LAPreviewViewController

@synthesize imageView;
@synthesize image;
@synthesize savedSinceLastEdit;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [imageView setImage:image];
    savedSinceLastEdit = NO;
}

- (void)showTweetSheet
{
    SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [tweetSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                break;
            case SLComposeViewControllerResultDone:
                if (!savedSinceLastEdit) {
                    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:finishedSavingWithError:contextInfo:), nil);
                    [self setSavedSinceLastEdit:YES];
                }
                break;
            default:
                break;
        }
    }];
    
    if (![tweetSheet addImage:image]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"addImage Failed" message: @"Failed to add image" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [tweetSheet setInitialText:@" #LeyeApp"];

    [self presentViewController:tweetSheet animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)tapEdit:(id)sender {
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:image delegate:self];
    [self presentViewController:editor animated:YES completion:nil];
}

- (IBAction)tapShare:(id)sender {
    [self showTweetSheet];
}

- (IBAction)tapSave:(id)sender {
    if (!savedSinceLastEdit) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:finishedSavingWithError:contextInfo:), nil);
        [self setSavedSinceLastEdit:YES];
    }
}

-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Save failed" message: @"Failed to save image" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Saved" message: nil delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

# pragma mark CLImageEditor delegate

- (void)imageEditor:(CLImageEditor *)editor didFinishEdittingWithImage:(UIImage *)returnImage
{
    [self setImage:returnImage];
    [imageView setImage:returnImage];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:finishedSavingWithError:contextInfo:), nil);
    [self setSavedSinceLastEdit:YES];
    [editor dismissViewControllerAnimated:YES completion:nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:returnImage forKey:@"Image"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ImageUpdated" object:self userInfo:userInfo];
}

@end
