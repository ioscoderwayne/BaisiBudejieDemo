//
//  QDBCircleIndicatorView.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/11/7.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBCircleIndicatorView.h"

@implementation QDBCircleIndicatorView
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.roundedCorners = YES;
//    self.trackTintColor = [UIColor clearColor];
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}
@end
