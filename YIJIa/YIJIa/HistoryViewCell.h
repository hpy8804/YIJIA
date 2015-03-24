//
//  HistoryViewCell.h
//  YIJIa
//
//  Created by sven on 3/19/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryModel.h"

@interface HistoryViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *guest;
@property (weak, nonatomic) IBOutlet UIImageView *share;
@property (weak, nonatomic) IBOutlet UIImageView *young;
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *sub_name;
@property (weak, nonatomic) IBOutlet UILabel *order_time;
@property (weak, nonatomic) IBOutlet UILabel *adress;
@property (weak, nonatomic) IBOutlet UILabel *price;
+ (id)reuseableCell:(UITableView*)tableView WithCellIdentifier:(NSString *)cellIdentifier;
@end
