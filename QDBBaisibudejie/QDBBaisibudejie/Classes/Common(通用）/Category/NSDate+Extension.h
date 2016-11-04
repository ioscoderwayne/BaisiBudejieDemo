//
//  NSDate+Extension.h
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/11/2.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
//日期增量
-(NSDateComponents *)deltaFrom:(NSDate *)from;

//是否是今年
-(BOOL)isThisYear;

//是否是今天
-(BOOL)isToday;

//是否是昨天
-(BOOL)isYesteday;
@end
