//
//  DateNowString.m
//  YTZG
//
//  Created by 李 恒 on 16/7/26.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "DateNowString.h"

@implementation DateNowString
-(void)SetTitle{
    NSDate* now = [NSDate date];
    //获取本地时区(中国时区)
    NSTimeZone* localTimeZone = [NSTimeZone localTimeZone];
    //计算世界时间与本地时区的时间偏差值
    NSInteger offset = [localTimeZone secondsFromGMTForDate:now];
    //世界时间＋偏差值 得出中国区时间
    NSDate *localDate = [now dateByAddingTimeInterval:offset];
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMonth |NSCalendarUnitSecond;
    NSDateComponents *dd = [cal components:unitFlags fromDate:localDate];
    int y = [dd year];
    int m = [dd month];
    int d = [dd day];
    _dateNow = [NSString stringWithFormat:@"%d-%d-%d",y,m,d];
    _MDdateNow = [NSString stringWithFormat:@"%d月%d日",m,d];
}

@end
