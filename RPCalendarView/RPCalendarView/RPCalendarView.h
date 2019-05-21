//
//  RPCalendarView.h
//  RPCalendarView
//
//  Created by Tao on 2019/5/14.
//  Copyright © 2019 Tao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RPCalendarView;

@protocol RPCalendarViewDelegate <NSObject>
/*
 *  选择回调
 */
-(void)RPCalendarView:(RPCalendarView *)calendarView selectedDay:(NSString *)selectedDay;

@end

@interface RPCalendarView : UIView

@property(nonatomic,weak)id<RPCalendarViewDelegate> delegate;

@property (nonatomic, strong) NSArray * hadSelectedDaysArr;

@end
