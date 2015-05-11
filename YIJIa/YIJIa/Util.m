//
//  Util.m
//  YIJIa
//
//  Created by sven on 3/16/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "Util.h"
#import "UINavigationBar+CustomBar.h"

typedef enum{
    SUN = 1,
    MON,
    TUES,
    WED,
    THUR,
    FRI,
    SAT
}Week;

@implementation Util

+ (void)setNavigationCtrollerBackImg:(UINavigationController *)naviCtl
{
    [naviCtl.navigationBar customNavigationBar];
}

//根据颜色返回图片
+ (UIImage*)imageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (NSString *)countTimeFromTimeCount:(double)timeCount
{
    double lastactivityInterval = timeCount/1000;
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY年MM月dd日 HH:mm"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:lastactivityInterval];
    
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSArray *)judgeOneWeekDayFromNow
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    NSInteger week = [comps weekday];
    
    NSMutableArray *mutArrDates = [NSMutableArray array];
    if (week - 1 == 0) {
        //sun
        for (int i = 1; i < 7; i++) {
            NSDate *dateCur = [NSDate dateWithTimeIntervalSinceNow:i*3600*24];
            NSInteger month = [[calendar components:unitFlags fromDate:dateCur] month];
            NSInteger day = [[calendar components:unitFlags fromDate:dateCur] day];
            [mutArrDates addObject:[NSString stringWithFormat:@"%d.%d", month, day]];
        }
    }else if (week - 1 == 6){
        //sat
        for (int i = 1; i < 7; i++) {
            NSDate *dateCur = [NSDate dateWithTimeIntervalSinceNow:-i*3600*24];
            NSInteger month = [[calendar components:unitFlags fromDate:dateCur] month];
            NSInteger day = [[calendar components:unitFlags fromDate:dateCur] day];
            [mutArrDates addObject:[NSString stringWithFormat:@"%d.%d", month, day]];
        }
    }else{
        //between
        for (int i = MON; i < week; i++) {
            NSDate *dateCur = [NSDate dateWithTimeIntervalSinceNow:-i*3600*24];
            NSInteger month = [[calendar components:unitFlags fromDate:dateCur] month];
            NSInteger day = [[calendar components:unitFlags fromDate:dateCur] day];
            [mutArrDates addObject:[NSString stringWithFormat:@"%d.%d", month, day]];
        }
        
        for (int j = 0; j < (SAT-week)+1; j++) {
            NSDate *dateCur = [NSDate dateWithTimeIntervalSinceNow:j*3600*24];
            NSInteger month = [[calendar components:unitFlags fromDate:dateCur] month];
            NSInteger day = [[calendar components:unitFlags fromDate:dateCur] day];
            [mutArrDates addObject:[NSString stringWithFormat:@"%d.%d", month, day]];
        }
    }
    
    return [NSArray arrayWithArray:mutArrDates];
    
}
@end
