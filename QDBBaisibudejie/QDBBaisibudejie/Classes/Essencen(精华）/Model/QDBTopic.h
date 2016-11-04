//
//  QDBTopic.h
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/11/1.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDBTopic : NSObject
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
/** 图片宽度 */
@property (nonatomic, assign) NSInteger width;
/** 图片高度 */
@property (nonatomic, assign) NSInteger height;
/** 帖子类型 */
@property (nonatomic, assign) QDBTopicType type;
/** 小图 */
@property (nonatomic, copy) NSString *smallImage;
/** 中图 */
@property (nonatomic, copy) NSString *midImage;
/** 大图 */
@property (nonatomic, copy) NSString *bigImage;


//附加属性
@property (nonatomic,assign,readonly) CGFloat rowHeight;
//图片viewFrame
@property (nonatomic,assign,readonly) CGRect picViewF;
//是否是大图
@property (nonatomic,assign) BOOL isBigPicture;
@end
