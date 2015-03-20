//
//  HistoryViewCell.h
//  YIJIa
//
//  Created by sven on 3/19/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *guest;
@property (weak, nonatomic) IBOutlet UIImageView *share;
@property (weak, nonatomic) IBOutlet UIImageView *young;
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
+ (id)reuseableCell:(UITableView*)tableView WithCellIdentifier:(NSString *)cellIdentifier;
@end
