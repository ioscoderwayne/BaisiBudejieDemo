//
//  QDBConstant.h
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/10/24.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    QDBTopicTypeAll = 1,
    QDBTopicTypeVideo = 41,
    QDBTopicTypeVoice = 31,
    QDBTopicTypePicture = 10,
    QDBTopicTypeWord = 29
    
} QDBTopicType;


UIKIT_EXTERN CGFloat const kNavH;
UIKIT_EXTERN CGFloat const kTopMenuH;

//精华cell间距
UIKIT_EXTERN CGFloat const kTopicCellMargin;
//cell Label y值
UIKIT_EXTERN CGFloat const kTopictCellTextY;
//cell 底部栏高度
UIKIT_EXTERN CGFloat const kTopictCellBottomBarH;

//cell 大图高度
UIKIT_EXTERN CGFloat const kTopictCellMaxImageH;
//cell 大图调整高度
UIKIT_EXTERN CGFloat const kTopictCellAdjustImageH;




