//
//  LACameraViewController.h
//  LeyeApp
//
//  Created by kotone on 2014/04/19.
//  Copyright (c) 2014年 Kotone Itaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LACameraViewController : UIImagePickerController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property NSMutableArray *imageArray;

@end
