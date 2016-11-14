//
//  QDBVoiceView.h
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/11/14.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QDBTopic;

@interface QDBVoiceView : UIView

@property (nonatomic,strong) QDBTopic *topic;

+(instancetype)voiceView;
@end
