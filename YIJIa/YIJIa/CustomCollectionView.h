//
//  CustomCollectionView.h
//  YIJIa
//
//  Created by sven on 4/7/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCollectionView : UICollectionView<UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) NSMutableArray *arrData;
@property (strong, nonatomic) NSMutableArray *arrServiceData;
@property (strong, nonatomic) NSString *strDate;
@property (assign, nonatomic) BOOL bIsChanging;
- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout array:(NSMutableArray *)arr servicesArr:(NSMutableArray *)arrayservices dateString:(NSString *)date;
@end
