//
//  GlobalDefine.h
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/10/24.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#ifndef GlobalDefine_h
#define GlobalDefine_h
//log相关
#ifdef DEBUG
#define QDBLog(...) NSLog(__VA_ARGS__)
#else
#define QDBLog(...)
#endif

#define QDBFunLog QDBLog(@"%s",__func__);

//颜色
#define RGBColor(r,g,b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define GlobalBackGroundColor  RGBColor(233,233,233)  

//屏幕宽度高度
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

#endif /* GlobalDefine_h */
