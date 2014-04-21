//
//  LAPreviewViewController.h
//  LeyeApp
//
//  Created by kotone on 2014/04/20.
//  Copyright (c) 2014年 Kotone Itaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "CLImageEditor.h"

@interface LAPreviewViewController : UIViewController <CLImageEditorDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property UIImage *image;
@property BOOL savedSinceLastEdit;

- (IBAction)tapEdit:(id)sender;
- (IBAction)tapShare:(id)sender;
- (IBAction)tapSave:(id)sender;

@end
