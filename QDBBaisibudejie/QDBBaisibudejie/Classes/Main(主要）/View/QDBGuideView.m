//
//  QDBGuideView.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/10/31.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBGuideView.h"

@interface QDBGuideView()

@end

@implementation QDBGuideView

+(instancetype)guideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+(void)show
{
    NSString *key = @"CFBundleShortVersionString";
    NSString *bundleVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:key];
    NSString *sandBoxVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([bundleVersion compare:sandBoxVersion]== NSOrderedDescending) {
        //添加view
        [window addSubview:[QDBGuideView guideView]];
        //存储
        [[NSUserDefaults standardUserDefaults] setObject:bundleVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (IBAction)btnClicked:(id)sender {
    //移除自己
    [self removeFromSuperview];
}
@end
