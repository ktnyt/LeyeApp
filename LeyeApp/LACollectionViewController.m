//
//  LACollectionViewController.m
//  LeyeApp
//
//  Created by kotone on 2014/04/19.
//  Copyright (c) 2014年 Kotone Itaya. All rights reserved.
//

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
