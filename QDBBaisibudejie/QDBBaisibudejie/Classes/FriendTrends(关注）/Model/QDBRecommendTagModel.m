//
//  QDBRecommendTagModel.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/10/25.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBRecommendTagModel.h"

@implementation QDBRecommendTagModel
/**
 *懒加载
 */
-(NSMutableArray *)users
{
    if (_users == nil) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
