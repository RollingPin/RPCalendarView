
//
//  RPTool.m
//  RPCalendarView
//
//  Created by Tao on 2019/5/14.
//  Copyright © 2019 Tao. All rights reserved.
//

#import "RPTool.h"

@implementation RPTool

#pragma mark -- 获取某Date上个月的Date
+ (NSDate *)getLastMonthTheDayWithCurrentDate:(NSDate *)currentDate
{
    NSDateComponents * dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate * newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:currentDate options:0];
    return newDate;
}
#pragma mark -- 获取某Date下个月的Date
+ (NSDate *)getNextMonthTheDayWithCurrentDate:(NSDate *)currentDate
{
    NSDateComponents * dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate * newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:currentDate options:0];
    return newDate;
}
#pragma mark -- 获取某个月第一天是星期几
+ (NSInteger)getFirstDayInMonthWithPertinentDate:(NSDate *)pertinentDate
{
    NSInteger needInt = [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:pertinentDate];
    return needInt;
}
#pragma mark -- 获取某个月有多少天
+ (NSInteger)getTotalDaysInMonthWithPertinentDate:(NSDate *)pertinentDate
{
    NSRange needRange = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:pertinentDate];
    return needRange.length;
}
#pragma mark -- 获取某date对应日
+ (NSInteger)getCurrentDay:(NSDate *)date
{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    NSInteger day = [components day];
    return day;
}
#pragma mark -- 获取某date对应月
+ (NSInteger)getCurrentMonth:(NSDate *)date
{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    NSInteger month = [components month];
    return month;
}
#pragma mark -- 获取某date对应年
+ (NSInteger)getCurrentYear:(NSDate *)date
{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    NSInteger year = [components year];
    return year;
}


@end
