//
//  QDBPictureView.h
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/11/4.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QDBTopic;

@interface QDBPictureView : UIView

@property (nonatomic,strong) QDBTopic *topic;

+(instancetype)pictureView;

@end
