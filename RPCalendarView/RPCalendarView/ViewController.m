//
//  ViewController.m
//  RPCalendarView
//
//  Created by Tao on 2019/5/14.
//  Copyright © 2019 Tao. All rights reserved.
//

#import "ViewController.h"
#import "RPCalendarView.h"

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    RPCalendarView * calendarView = [[RPCalendarView alloc]initWithFrame:CGRectMake(0, 100, Width, 320)];
    [self.view addSubview:calendarView];
}


@end
