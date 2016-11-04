//
//  NSDate+Extension.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/11/2.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

-(NSDateComponents *)deltaFrom:(NSDate *)from
{
    NSCalendar *calender = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    
    return [calender components:unit fromDate:from toDate:self options:0];
}

-(BOOL)isThisYear
{
    NSCalendar *calerdar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calerdar component:NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSInteger selfYear = [calerdar component:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return nowYear==selfYear;
}

-(BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    
    NSDateComponents *selfComponents = [calendar components:unit fromDate:self];
    
    NSDateComponents *nowComponents = [calendar components:unit fromDate:[NSDate date]];
    
    return (selfComponents.year== nowComponents.year)&&(selfComponents.month == nowComponents.month)&&(selfComponents.day == nowComponents.day);
}

-(BOOL)isYesteday
{
    //忽略时分秒
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yy-MM-hh";
    
    NSDate *selfDate = [formatter dateFromString:[formatter stringFromDate:self]];
    NSDate *nowDate = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return comp.year == 0 && comp.month == 0 && comp.day == 1;
}
@end
