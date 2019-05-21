
//
//  RPCalendarView.m
//  RPCalendarView
//
//  Created by Tao on 2019/5/14.
//  Copyright © 2019 Tao. All rights reserved.
//

#import "RPCalendarView.h"
#import "UIView+Ext.h"
#import "RPTool.h"

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
#define randomColor [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0f]

@interface RPCalendarView ()

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIView * daysView;

@property (nonatomic, strong) NSDate * currentDate;
@property (nonatomic, strong) NSMutableArray * showDaysBtnArr;

@property (nonatomic, strong) NSMutableArray * markArr;

@end

@implementation RPCalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.markArr = [NSMutableArray arrayWithObjects:@"6",@"8",@"9", nil];
        
        self.showDaysBtnArr = [NSMutableArray array];
        self.currentDate = [NSDate date];
        [self createUI];
    }
    return self;
}
- (void)createUI
{
    UIButton *beforeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [beforeBtn setTitle:@"<" forState:UIControlStateNormal];
    [beforeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [beforeBtn addTarget:self action:@selector(beforeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:beforeBtn];
    
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(Width-44, 0, 44, 44)];
    [nextBtn setTitle:@">" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:nextBtn];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 0, Width-88, 44)];
    self.titleLabel.text = @"2019-09-09";
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor blackColor];
    [self addSubview:self.titleLabel];

    NSArray * weekArr = [NSArray arrayWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六", nil];
    CGFloat weekWH = Width/weekArr.count;
    for (int i = 0; i<weekArr.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(weekWH*i, self.titleLabel.bottomY, weekWH, weekWH)];
        label.text = weekArr[i];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    self.daysView = [[UIView alloc]initWithFrame:CGRectMake(0, self.titleLabel.bottomY+weekWH, Width, weekWH*6)];
    [self addSubview:self.daysView];
    
    [self checkData];
}
- (void)beforeBtnClick
{
    self.currentDate = [RPTool getLastMonthTheDayWithCurrentDate:self.currentDate];
    [self checkData];
}
- (void)nextBtnClick
{
    self.currentDate = [RPTool getNextMonthTheDayWithCurrentDate:self.currentDate];
    [self checkData];
}

- (void)checkData
{
    //=================
    // 此处可添加编辑数据用于标记mark某天
    
    [self.markArr removeAllObjects];
    for (int i = 0; i<6; i++) {
        int randomInt = arc4random() % 25+1;
        [self.markArr addObject:[NSString stringWithFormat:@"%d",randomInt]];
    }
    
    //=================
    
    [self reloadView];
}

- (void)reloadView
{
    [self.daysView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    NSInteger totalDays = [RPTool getTotalDaysInMonthWithPertinentDate:self.currentDate];
    NSInteger firstDay = [RPTool getFirstDayInMonthWithPertinentDate:self.currentDate];

    self.titleLabel.text = [NSString stringWithFormat:@"%04zd-%02zd",[RPTool getCurrentYear:self.currentDate],[RPTool getCurrentMonth:self.currentDate]];
    
    CGFloat btnWH = self.daysView.width/7;
    CGFloat btnX = (firstDay==7) ? 0 : btnWH*firstDay;
    CGFloat btnY = 0;
    for (NSInteger i = 1; i<=totalDays; i++) {
        
        UIButton * daysBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        daysBtn.frame = CGRectMake(btnX, btnY, btnWH, btnWH);
        daysBtn.tag = 100+i;
        [daysBtn setTitle:[NSString stringWithFormat:@"%ld",(long)i] forState:UIControlStateNormal];
        [daysBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        daysBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        daysBtn.layer.cornerRadius = btnWH/2;
        daysBtn.layer.masksToBounds = YES;
        [daysBtn addTarget:self action:@selector(daysBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.daysView addSubview:daysBtn];
        
        btnY = ((btnX+btnWH) > btnWH*6) ? btnY+btnWH : btnY;
        btnX = ((btnX+btnWH) > btnWH*6) ? 0 : btnX+btnWH;
        
        for (NSString * markStr in self.markArr) {
            if (markStr.integerValue == i) {
                UIView * markView = [[UIView alloc]initWithFrame:CGRectMake(0, daysBtn.height*4/5, 6, 6)];
                markView.centerX = daysBtn.width/2;
                markView.backgroundColor = [UIColor orangeColor];
                markView.layer.cornerRadius = 3;
                markView.layer.masksToBounds = YES;
                [daysBtn addSubview:markView];
            }
        }
        
        if (i == totalDays) self.height = daysBtn.bottomY;
    }
}

- (void)daysBtnClick:(UIButton *)btn
{
//    NSInteger selectedIndex = btn.tag-100;
    
    NSInteger totalDays = [RPTool getTotalDaysInMonthWithPertinentDate:self.currentDate];
    for (NSInteger i = 1; i<=totalDays; i++) {
        UIButton * daysBtn = [self viewWithTag:100+i];
        [daysBtn setBackgroundColor:[UIColor clearColor]];
    }
    
    [btn setBackgroundColor:randomColor];
    
}


@end
