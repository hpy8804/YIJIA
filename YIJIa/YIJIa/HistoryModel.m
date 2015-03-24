//
//  HistoryModel.m
//  YIJIa
//
//  Created by sven on 3/24/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "HistoryModel.h"

@implementation HistoryModel
- (NSString *)description
{
    return [NSString stringWithFormat:@"[order_id=%@, sub_name=%@, create_time=%@, address=%@, length=%@]", self.order_id, self.sub_name, self.create_time, self.address, self.length];
}
@end
