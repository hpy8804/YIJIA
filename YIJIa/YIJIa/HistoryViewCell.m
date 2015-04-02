//
//  HistoryViewCell.m
//  YIJIa
//
//  Created by sven on 3/19/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "HistoryViewCell.h"

@implementation HistoryViewCell

- (void)awakeFromNib {
    // Initialization code
    _price.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (id)reuseableCell:(UITableView*)tableView WithCellIdentifier:(NSString *)cellIdentifier
{
    HistoryViewCell *cell;
    cell = (HistoryViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
        cell = (HistoryViewCell *)[nibArray objectAtIndex:0];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}



@end
