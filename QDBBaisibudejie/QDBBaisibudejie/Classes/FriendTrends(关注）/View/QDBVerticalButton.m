//
//  QDBVerticalButton.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/10/28.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBVerticalButton.h"

@implementation QDBVerticalButton

-(void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setup];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.width;
    //文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}
@end
