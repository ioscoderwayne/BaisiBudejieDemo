//
//  QDBTabBar.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/10/24.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBTabBar.h"

@interface QDBTabBar()
@property (nonatomic,weak) UIButton *publishBtn;
@end

@implementation QDBTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        //添加发布按钮
        UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        
        [self addSubview:publishBtn];
        self.publishBtn = publishBtn;

    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //布局子发布按钮
    self.publishBtn.size = self.publishBtn.currentBackgroundImage.size;
    self.publishBtn.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
    //布局系统tabbarButton
    CGFloat btnW = self.width/5;
    CGFloat btnH = self.height;
    CGFloat btnY = 0;
    CGFloat btnX = 0;
    NSInteger index = 0;
    for (UIView *view in self.subviews) {
        if (![view isKindOfClass:[UIControl class]]||view == self.publishBtn) continue;
        btnX= btnW * ((index > 1)? (index+1):index);
        view.frame = CGRectMake(btnX, btnY, btnW, btnH);
        index ++ ;
        
    }
    
}

@end
