/******************************************************************************
**  LAPreviewViewController.h
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
