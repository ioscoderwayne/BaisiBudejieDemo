//
//  QDBTopicCell.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/11/1.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBTopicCell.h"
#import "QDBTopic.h"
#import <UIImageView+WebCache.h>
#import "QDBPictureView.h"
#import "QDBVoiceView.h"
#import "QDBVideoView.h"

@interface QDBTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *commendBtn;
@property (weak, nonatomic) IBOutlet UIButton *repostBtn;
@property (weak, nonatomic) IBOutlet UILabel *text_Label;

@property (nonatomic,weak) QDBPictureView *picView;

@property (nonatomic,weak) QDBVoiceView *voiceView;

@property (nonatomic,weak) QDBVideoView *videoView;

@end

@implementation QDBTopicCell

-(QDBPictureView *)picView
{
    if (_picView == nil) {
        QDBPictureView *picView = [QDBPictureView pictureView];
        [self.contentView addSubview:picView];
        _picView = picView;
    }
    return _picView;
}

-(QDBVoiceView *)voiceView
{
    if (_voiceView == nil) {
        QDBVoiceView *voiceView = [QDBVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    
    return _voiceView;
}

-(QDBVideoView *)videoView
{
    if (_videoView == nil) {
        QDBVideoView *videoView = [QDBVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    
    return _videoView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // 设置背景
    UIImageView *bgView =[[UIImageView alloc]init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

-(void)setTopic:(QDBTopic *)topic
{
    _topic = topic;
    //设置数据
    [self.profileImage sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    
    self.createTimeLabel.text = topic.create_time;
    
    self.text_Label.text = topic.text;
    //设置按钮
    [self setupButton:self.dingBtn count:topic.ding placeholder:@"顶"];
    [self setupButton:self.caiBtn count:topic.cai placeholder:@"踩"];
    [self setupButton:self.commendBtn count:topic.comment placeholder:@"评论"];
    [self setupButton:self.repostBtn count:topic.repost placeholder:@"分享"];
    if (topic.type == QDBTopicTypePicture) {
        //图片帖子
        self.picView.topic = topic;
        self.picView.frame = topic.picViewF;
        
        self.picView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;

    }else if(topic.type == QDBTopicTypeVoice) {
        //声音帖子
        self.voiceView.frame = topic.voiceViewF;
        self.voiceView.topic = topic;
        
        self.picView.hidden = YES;
        self.voiceView.hidden = NO;
        self.videoView.hidden = YES;

    }else if (topic.type == QDBTopicTypeVideo){
        //视频帖子
        self.videoView.frame =topic.videoViewF;
        self.videoView.topic = topic;
        
        self.picView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = NO;
    }else{
        //段子帖子
        self.picView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
}

-(void)setFrame:(CGRect)frame
{
//    frame.origin.x = margin;
//    frame.size.width -= 2*margin;
    frame.origin.y += kTopicCellMargin;
    frame.size.height -= kTopicCellMargin;
    
    [super setFrame:frame];
}

-(void)setupButton:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万",count/10000.0];
    }else{
        placeholder = [NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
    [button setTitle:placeholder forState:UIControlStateHighlighted];
}
@end
