//
//  QDBPictureView.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/11/4.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBPictureView.h"
#import <UIImageView+WebCache.h>
#import "QDBTopic.h"
#import "QDBCircleIndicatorView.h"
#import "QDBShowBigImageVC.h"

@interface QDBPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *gitImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigImagBtn;
@property (weak, nonatomic) IBOutlet QDBCircleIndicatorView *circleIndicatorView;

@end

@implementation QDBPictureView

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
    QDBShowBigImageVC *showBig = [[QDBShowBigImageVC alloc]init];
    showBig.topic = self.topic;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow.rootViewController presentViewController:showBig animated:YES completion:nil];    
}

-(void)setTopic:(QDBTopic *)topic
{
    _topic = topic;
    
    //先设置上次进度 防止网速慢显示异常问题
    [self.circleIndicatorView setProgress:topic.currentProgress animated:NO];
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:topic.bigImage] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //显示进度指示器
        self.circleIndicatorView.hidden = NO;
        
        topic.currentProgress = 1.0 * receivedSize / expectedSize;;
        
//        QDBLog(@"---------%.2f",topic.currentProgress);
        //设置进度条进度
        [self.circleIndicatorView setProgress:topic.currentProgress animated:NO];

    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //隐藏进度指示器
        self.circleIndicatorView.hidden = YES;
        // 如果是大图片, 才需要进行绘图处理
        if (topic.isBigPicture == NO) return;
        
        // 开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.picViewF.size, YES, 0.0);
        
        // 将下载完的image对象绘制到图形上下文
        CGFloat width = topic.picViewF.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        // 获得图片
        self.bgImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        // 结束图形上下文
        UIGraphicsEndImageContext();
    }];
    
    //控制git图片是否显示
    NSString *extension = topic.bigImage.pathExtension;
    self.gitImageView.hidden = ![extension isEqualToString:@"gif"];
    //控制显示全部按钮
    if (topic.isBigPicture) {
        self.seeBigImagBtn.hidden = NO;
        self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    }else{
        self.seeBigImagBtn.hidden = YES;
        self.bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
}

+(instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:0] lastObject];
}
@end
