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

@interface QDBPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *gitImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigImagBtn;

@end

@implementation QDBPictureView

-(void)setTopic:(QDBTopic *)topic
{
    _topic = topic;
    //设置数据
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:topic.bigImage]];
    
    //控制git图片
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
