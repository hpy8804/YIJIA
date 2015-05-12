//
//  Util.h
//  YIJIa
//
//  Created by sven on 3/16/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum{
    SUN = 1,
    MON,
    TUES,
    WED,
    THUR,
    FRI,
    SAT
}Week;

@interface Util : NSObject
+ (void)setNavigationCtrollerBackImg:(UINavigationController *)naviCtl;
+ (UIImage*)imageWithColor:(UIColor*)color;
+ (NSString *)countTimeFromTimeCount:(double)timeCount;
+ (NSArray *)judgeOneWeekDayFromNow;
+ (NSArray *)obtainOneWeekDaysFromNow;
+ (NSInteger)weekFromDateString:(NSString *)dateString;
@end
