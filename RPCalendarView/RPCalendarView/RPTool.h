//
//  RPTool.h
//  RPCalendarView
//
//  Created by Tao on 2019/5/14.
//  Copyright © 2019 Tao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RPTool : NSObject
/*
 * 获取某Date上个月的Date
 */
+ (NSDate *)getLastMonthTheDayWithCurrentDate:(NSDate *)currentDate;
/*
 * 获取某Date下个月的Date
 */
+ (NSDate *)getNextMonthTheDayWithCurrentDate:(NSDate *)currentDate;
/*
 * 获取某个月第一天是星期几
 */
+ (NSInteger)getFirstDayInMonthWithPertinentDate:(NSDate *)pertinentDate;
/*
 * 获取某个月有多少天
 */
+ (NSInteger)getTotalDaysInMonthWithPertinentDate:(NSDate *)pertinentDate;
/*
 * 获取某date对应日
 */
+ (NSInteger)getCurrentDay:(NSDate *)date;
/*
 *  获取某date对应月
 */
+ (NSInteger)getCurrentMonth:(NSDate *)date;
/*
 *  获取某date对应年
 */
+ (NSInteger)getCurrentYear:(NSDate *)date;


@end

NS_ASSUME_NONNULL_END
