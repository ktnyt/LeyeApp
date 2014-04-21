//
//  LAMainViewController.h
//  LeyeApp
//
//  Created by kotone on 2014/04/19.
//  Copyright (c) 2014年 Kotone Itaya. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LAPreviewViewController.h"

@interface LAMainViewController : UIViewController

@property UIImage *image;
@property BOOL recording;

- (IBAction)unwindToMain:(UIStoryboardSegue *)segue;
- (IBAction)tapHandler:(id)sender;

@end
