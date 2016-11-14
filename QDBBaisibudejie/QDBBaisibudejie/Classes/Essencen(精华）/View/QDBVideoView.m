//
//  QDBVideoView.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/11/14.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBVideoView.h"
#import "QDBTopic.h"
#import <UIImageView+WebCache.h>
#import "QDBShowBigImageVC.h"

@interface QDBVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@end

@implementation QDBVideoView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.bgImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage)];
    [self.bgImageView addGestureRecognizer:tap];
}

//显示大图控制器
-(void)showBigImage
{
    QDBLog(@"-------%@=======%@",self.bgImageView.image,self.topic);
    QDBShowBigImageVC *showBig = [[QDBShowBigImageVC alloc]init];
    showBig.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showBig animated:YES completion:nil];
    
}


+(instancetype)videoView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:0] lastObject];
}

-(void)setTopic:(QDBTopic *)topic
{
    _topic = topic;
    
    //设置数据
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:topic.bigImage]];
    
    //播放次数
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd次",topic.playcount];
    //播放时间
    NSInteger minute = topic.videotime/60;
    NSInteger second = topic.videotime%60;
    
    self.playTimeLable.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
}
@end
