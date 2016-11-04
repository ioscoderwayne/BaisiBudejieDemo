//
//  UIBarButtonItem+Extension.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/10/24.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+(instancetype)itemWithImageName:(NSString *)imageName selImageName:(NSString *)selImageName target:(id)target action:(SEL)action
{
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [Btn setBackgroundImage:[UIImage imageNamed:selImageName] forState:UIControlStateHighlighted];
    Btn.size = Btn.currentBackgroundImage.size;
    [Btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc]initWithCustomView:Btn];
}
@end
