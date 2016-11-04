//
//  QDBRecommendTagModel.h
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/10/25.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDBRecommendTagModel : NSObject

@property (nonatomic,assign) NSInteger id;

@property (nonatomic,assign) NSInteger count;

@property (nonatomic,copy) NSString *name;

//用户数据
@property (nonatomic,strong) NSMutableArray *users;
//总数
@property (nonatomic,assign) NSInteger total;
//当前页
@property (nonatomic,assign) NSInteger currentpage;

@end
