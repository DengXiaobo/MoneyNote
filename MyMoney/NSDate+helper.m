//
//  NSDate+helper.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/29.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "NSDate+helper.h"

@implementation NSDate (helper)


// 获取某一个时间点(本日 本周 本月 本年)的时间戳
+ (NSTimeInterval)getTimestampWithType:(DateType)type;
{
//    年 / 月/ 日 / 周几
//    2016/05/06/周五
//    
//    2016-05-01 00:00:00
//
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    formatter1.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
   // [formatter1 setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    [formatter1 setDateFormat:@"yyyy/M/dd/E"];
    NSArray *array = [[formatter1 stringFromDate:[NSDate date]] componentsSeparatedByString:@"/"];
    
    NSArray *weekArray = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    NSInteger index = [weekArray indexOfObject:array[3]];
    
    NSString *dateString = @"";
    
    switch (type) {
        case DateTypeToday:
        {
            dateString = [NSString stringWithFormat:@"%@-%@-%@ 00:00:00",array[0],array[1],array[2]];
        }
            break;
        case DateTypeWeekend:
        {
            dateString = [NSString stringWithFormat:@"%@-%@-%ld 00:00:00",array[0],array[1],[array[2] integerValue] - index];
        }
            break;
        case DateTypeMonth:
        {
            dateString = [NSString stringWithFormat:@"%@-%@-01 00:00:00",array[0],array[1]];
        }
            break;
        case DateTypeYear:
        {
            dateString = [NSString stringWithFormat:@"%@-01-01 00:00:00",array[0]];
        }
            break;
        default:
            break;
    }
 
    //    NSLog(@"%@",dateString);
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"yyyy-M-dd HH:mm:ss"];
    
    NSDate *date = [formatter2 dateFromString:dateString];
    
    NSTimeInterval timestmap = [date timeIntervalSince1970];
    return timestmap;
}

+ (NSInteger)getCurrentDateWithType:(DateType)type
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [formatter setDateFormat:@"dd/E/M/yyyy"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    
    // 替换周几为数字
    NSString *week = [[dateString componentsSeparatedByString:@"/"] objectAtIndex:1];
    NSArray *weekArray = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    NSInteger index = [weekArray indexOfObject:week];
    dateString = [dateString stringByReplacingOccurrencesOfString:week withString:[NSString stringWithFormat:@"%ld",index + 1]];
    
    return [[[dateString componentsSeparatedByString:@"/"] objectAtIndex:type] integerValue];
}

//获取周几的 日期号  week代表你想知道的周几的日期
+ (NSString *)getDateOfCurrentWeek:(NSInteger)week
{
    //  今天周五
    NSInteger weekDay = [self getCurrentDateWithType:DateTypeWeekend];
    NSTimeInterval secondsPerDay1 = 24 * 60 * 60 * (weekDay - week);
    NSDate *destinationDay = [[NSDate date] dateByAddingTimeInterval:-secondsPerDay1];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"M月d日"];
    NSString *dateString = [formater stringFromDate:destinationDay];
    
    return dateString;
}

+ (NSInteger)getLastDayOfCurrentMonth
{
    NSInteger m = [self getCurrentDateWithType:DateTypeMonth];
    NSInteger y = [self getCurrentDateWithType:DateTypeYear];
//    2015 6 1 - 一整天
    if (m == 12)
    {
        y++;
        m = 1;
    }
    else
    {
        m++;
    }
    
    NSString *dateString = [NSString stringWithFormat:@"%ld-%ld-1 00:00:00",y,m];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-M-d HH:mm:ss"];
    NSDate *date = [formatter dateFromString:dateString];
    date = [date dateByAddingTimeInterval:-24*60*60];
    
    [formatter setDateFormat:@"d"];
    dateString = [formatter stringFromDate:date];
    [formatter release];
    
    return [dateString integerValue];
}

+ (NSString *)getDateWithTimestamp:(NSTimeInterval)timestamp type:(DateType)type
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [formatter setDateFormat:@"dd/E/M/yyyy"];
    NSString *dateString = [formatter stringFromDate:date];
    
    return [[dateString componentsSeparatedByString:@"/"] objectAtIndex:type];
}


@end
