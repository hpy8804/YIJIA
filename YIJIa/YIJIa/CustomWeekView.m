//
//  CustomWeekView.m
//  YIJIa
//
//  Created by sven on 3/25/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "CustomWeekView.h"

@implementation CustomWeekView

+(instancetype)detailView{
    return [[[NSBundle mainBundle]loadNibNamed:@"CustomWeekView" owner:nil options:nil]lastObject];
}

@end
