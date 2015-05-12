//
//  Util.m
//  YIJIa
//
//  Created by sven on 3/16/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "Util.h"
#import "UINavigationBar+CustomBar.h"

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
    NSMutableArray *mutArrDates = [NSMutableArray array];

    [mutArrDates addObject:[NSString stringWithFormat:@"%d-%.2d-%.2d",[comps year],[comps month], [comps day]]];
    for (int i = 1; i < 6; i++) {
        NSDate *dateCur = [NSDate dateWithTimeIntervalSinceNow:i*3600*24];
        NSInteger year = [[calendar components:unitFlags fromDate:dateCur] year];
        NSInteger month = [[calendar components:unitFlags fromDate:dateCur] month];
        NSInteger day = [[calendar components:unitFlags fromDate:dateCur] day];
        [mutArrDates addObject:[NSString stringWithFormat:@"%d-%.2d-%.2d",year,month, day]];
    }
    
    return [NSArray arrayWithArray:mutArrDates];
    
}

+ (NSArray *)obtainOneWeekDaysFromNow
{
    NSMutableArray *mutArrWeeks = [NSMutableArray array];
    NSArray *arrdatas = [self judgeOneWeekDayFromNow];
    for (int i = 0; i < arrdatas.count; i++) {
        NSString *strDetail = arrdatas[i];
        NSDateComponents *_comps = [[NSDateComponents alloc] init];
        [_comps setDay:[[strDetail substringWithRange:NSMakeRange(8, 2)] integerValue]];
        [_comps setMonth:[[strDetail substringWithRange:NSMakeRange(5, 2)] integerValue]];
        [_comps setYear:[[strDetail substringWithRange:NSMakeRange(0, 4)] integerValue]];
        NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *_date = [gregorian dateFromComponents:_comps];
        NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:_date];
        int _weekday = [weekdayComponents weekday];
        NSString *strWeek = nil;
        switch (_weekday) {
            case 1:
            {
                strWeek = [NSString stringWithFormat:@"%d", SUN];
            }
                break;
            case 2:
            {
                strWeek = [NSString stringWithFormat:@"%d", MON];
            }
                break;
            case 3:
            {
                strWeek = [NSString stringWithFormat:@"%d", TUES];
            }
                break;
            case 4:
            {
                strWeek = [NSString stringWithFormat:@"%d", WED];
            }
                break;
            case 5:
            {
                strWeek = [NSString stringWithFormat:@"%d", THUR];
            }
                break;
            case 6:
            {
                strWeek = [NSString stringWithFormat:@"%d", FRI];
            }
                break;
            case 7:
            {
                strWeek = [NSString stringWithFormat:@"%d", SAT];
            }
                break;
                
            default:
                break;
        }
        
        [mutArrWeeks addObject:strWeek];
    }
    
    return mutArrWeeks;
}

+ (NSInteger)weekFromDateString:(NSString *)dateString
{
    NSDateComponents *_comps = [[NSDateComponents alloc] init];
    [_comps setDay:[[dateString substringWithRange:NSMakeRange(8, 2)] integerValue]];
    [_comps setMonth:[[dateString substringWithRange:NSMakeRange(5, 2)] integerValue]];
    [_comps setYear:[[dateString substringWithRange:NSMakeRange(0, 4)] integerValue]];
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *_date = [gregorian dateFromComponents:_comps];
    NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:_date];
    NSInteger _weekday = [weekdayComponents weekday];
    return _weekday;
}
@end
