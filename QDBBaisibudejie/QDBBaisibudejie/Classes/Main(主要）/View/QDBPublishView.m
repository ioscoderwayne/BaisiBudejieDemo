//
//  QDBPublishView.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/11/7.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBPublishView.h"
#import "QDBVerticalButton.h"
#import <POP.h>

@interface QDBPublishView()

@end

@implementation QDBPublishView
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    //动画过程让view不能交互
    self.userInteractionEnabled = NO;
    [UIApplication sharedApplication].keyWindow.rootViewController.view.userInteractionEnabled = NO;
    
    //添加6个按钮
    NSInteger cols = 3;
    CGFloat btnW = 70;
    CGFloat btnH = 120;
    CGFloat marginLeft = 15;
    CGFloat beginY = kScreenH *0.5 - btnH;
    CGFloat marginX = (kScreenW - 2*marginLeft - cols*btnW)/(cols-1);
    //数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    for (int i= 0; i< 6; i++) {
        QDBVerticalButton *btn = [[QDBVerticalButton alloc]init];
        btn.tag = i;
        NSInteger row = i/cols;
        NSInteger col = i%cols;
        CGFloat btnX = marginLeft + col*(btnW+marginX);
        CGFloat btnY = beginY + row *btnH;
        CGFloat orignY = beginY - kScreenH;
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(btnX, orignY, btnW, btnH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnY, btnW, btnH)];
        anim.beginTime = CACurrentMediaTime() + i*0.1;
        anim.springBounciness = 10;
        anim.springSpeed = 10;
        [btn pop_addAnimation:anim forKey:nil];

    }
    
    //顶部图片
    UIImageView *topImageView = [[UIImageView alloc]init];
    topImageView.image = [UIImage imageNamed:@"app_slogan"];
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    CGFloat sloganW = 202;
    CGFloat sloganH = 20;
    CGFloat sloganX = kScreenW *0.5 - sloganW*0.5;
    anim.fromValue = [NSValue valueWithCGRect:CGRectMake(sloganX, kScreenH*0.2-kScreenH,sloganW , sloganH)];
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(sloganX, kScreenH*0.2, sloganW, sloganH)];
    anim.beginTime = CACurrentMediaTime() + 0.1*self.subviews.count;
    anim.springBounciness = 10;
    anim.springSpeed = 10;
    [anim setCompletionBlock:^(POPAnimation *ani, BOOL finished) {
        //让view回复交互
        self.userInteractionEnabled = YES;
        [UIApplication sharedApplication].keyWindow.rootViewController.view.userInteractionEnabled = YES;
    }];
    [topImageView pop_addAnimation:anim forKey:nil];

    [self addSubview:topImageView];
}

//点击了取消按钮
- (IBAction)cancleBtnClicked:(id)sender
{
    [self cancleWithCompleteBlock:nil];
}


+(instancetype)publishView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:0]lastObject];
}

-(void)btnClicked:(QDBVerticalButton *)btn
{
    [self cancleWithCompleteBlock:^{
        if (btn.tag == 0) {
            QDBLog(@"===发视频");
        }
    }];
}

-(void)cancleWithCompleteBlock:(void(^)())completeBlock
{
    self.userInteractionEnabled = NO;
     [UIApplication sharedApplication].keyWindow.rootViewController.view.userInteractionEnabled = NO;
    //先执行动画 动画结束移除view
    for (int i=2; i< 8; i++) {
        QDBVerticalButton *btn = self.subviews[i];
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.toValue =[NSValue valueWithCGRect:CGRectMake(btn.x, btn.y+kScreenH, btn.width, btn.height)];
        anim.beginTime = CACurrentMediaTime() + i*0.1;
        [btn pop_addAnimation:anim forKey:nil];
        
    }
    UIImageView *sloganImageView = self.subviews[8];
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    anim.toValue =[NSValue valueWithCGRect:CGRectMake(sloganImageView.x, sloganImageView.y+kScreenH, sloganImageView.width, sloganImageView.height)];
    anim.beginTime = CACurrentMediaTime() + 0.8;
    [sloganImageView pop_addAnimation:anim forKey:nil];
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        //恢复交互
        self.userInteractionEnabled = YES;
        [UIApplication sharedApplication].keyWindow.rootViewController.view.userInteractionEnabled = YES;
        //移除view
        [self removeFromSuperview];
        //有代码则执行
        !completeBlock?:completeBlock();
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancleWithCompleteBlock:nil];
}
@end
