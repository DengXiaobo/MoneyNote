//
//  NSDate+helper.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/29.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DateType)
{
    DateTypeToday = 0,
    DateTypeWeekend,
    DateTypeMonth,
    DateTypeYear
};

@interface NSDate (helper)

+ (NSTimeInterval)getTimestampWithType:(DateType)type;
+ (NSInteger)getCurrentDateWithType:(DateType)type;
+ (NSString *)getDateOfCurrentWeek:(NSInteger)week;
+ (NSInteger)getLastDayOfCurrentMonth;
+ (NSString *)getDateWithTimestamp:(NSTimeInterval)timestamp type:(DateType)type;

@end
