//
//  UIBarButtonItem+Extension.h
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/10/24.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+(instancetype)itemWithImageName:(NSString*)imageName selImageName:(NSString *)selImageName target:(id)target action:(SEL)action;
@end
