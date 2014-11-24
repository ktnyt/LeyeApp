/******************************************************************************
**  LACollectionViewController.m
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

#import "LACollectionViewController.h"

@interface LACollectionViewController ()

@end

@implementation LACollectionViewController

@synthesize imageArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    imageArray = [[NSMutableArray alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageUpdate:) name:@"ImageUpdated" object:nil];
}

- (void)imageUpdate:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    UIImage *image = [userInfo objectForKey:@"Image"];
    [imageArray insertObject:image atIndex:0];
    [[self collectionView] insertItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]]];
}

- (UIImage *)resetImage:(UIImage*)originalImage {
    CGSize newSize = CGSizeMake(90, 120);
    
    UIGraphicsBeginImageContext(newSize);
    [originalImage drawInRect:CGRectMake(0, 0, 90, 120)];
    UIImage *theImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [imageArray count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [[self collectionView] dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    UIImage *image =[imageArray objectAtIndex:[indexPath row]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[self resetImage:image]];
    [cell addSubview:imageView];
    return cell;
}

- (IBAction)tapHandler:(UITapGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:[self collectionView]];
    NSIndexPath *indexPath = [[self collectionView] indexPathForItemAtPoint:location];
    if (0 < [imageArray count] && [indexPath row] < [imageArray count]) {
        UIImage *image = [imageArray objectAtIndex:[indexPath row]];
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:image forKey:@"Image"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CellTapped" object:self userInfo:userInfo];
    }
}

- (IBAction)swipeHandler:(UISwipeGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:[self collectionView]];
    NSIndexPath *indexPath = [[self collectionView] indexPathForItemAtPoint:location];
    if (0 < [imageArray count] && [indexPath row] < [imageArray count]) {
        [imageArray removeObjectAtIndex:[indexPath row]];
        [[self collectionView] deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    }
}

@end
