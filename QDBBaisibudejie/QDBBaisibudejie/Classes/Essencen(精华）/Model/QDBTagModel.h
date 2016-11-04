//
//  QDBTagModel.h
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/10/28.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDBTagModel : NSObject
/** 图片 */
@property (nonatomic, copy) NSString *image_list;
/** 名字 */
@property (nonatomic, copy) NSString *theme_name;
/** 订阅数 */
@property (nonatomic, assign) NSInteger sub_number;
@end
