//
//  CustomCollectionView.m
//  YIJIa
//
//  Created by sven on 4/7/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "CustomCollectionView.h"
#import "CollectionViewCell.h"
#import "ComMacros.h"

#define CELLIDENTIFIER @"cell"

@interface CustomCollectionView ()
{
    NSArray *_constArrData;
}
@end

@implementation CustomCollectionView

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout array:(NSMutableArray *)arr dateString:(NSString *)date
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self customSelfData];
        _arrData = arr;
        _strDate = date;
        [self customSelfUI];
    }
    return self;
}

- (void)customSelfData
{
    _constArrData = @[ @"8:30", @"9:00", @"9:30", @"10:00", @"10:30", @"11:00",
                       @"11:30", @"12:00", @"12:30", @"13:00", @"13:30", @"14:00",
                       @"14:30", @"15:00", @"15:30", @"16:00", @"16:30", @"17:00",
                       @"17:30", @"18:00", @"18:30", @"19:00", @"19:30", @"20:00",
                       @"20:30", @"21:00", @"21:30", @"22:00"];
}

- (void)customSelfUI
{
    [self registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:CELLIDENTIFIER];
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = [UIColor colorWithRed:243/255.0f green:242/255.0f blue:240/255.0f alpha:1.0];
}

#pragma mark -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _constArrData.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELLIDENTIFIER forIndexPath:indexPath];
    NSString *strTitleTime = _constArrData[indexPath.row];
    cell.text.text = strTitleTime;
    if ([_arrData containsObject:strTitleTime]) {
        cell.textStatus.text = @"休息";
        cell.backgroundColor = [UIColor colorWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1.0];
    }else{
        cell.textStatus.text = @"空闲";
        cell.backgroundColor = [UIColor colorWithRed:249/255.0f green:127/255.0f blue:164/255.0f alpha:1.0];
    }
    [cell sizeToFit];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((APP_Frame_Width-4)/4, (APP_Frame_Width-4)/6);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.bIsChanging) {
        NSString *strTitleTime = _constArrData[indexPath.row];
        if ([_arrData containsObject:strTitleTime]) {
            [_arrData removeObject:strTitleTime];
        }else{
            [_arrData addObject:strTitleTime];
        }
        
        [self reloadData];
    }
}

@end
