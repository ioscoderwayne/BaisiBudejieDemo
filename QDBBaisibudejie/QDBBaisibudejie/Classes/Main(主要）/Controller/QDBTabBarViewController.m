//
//  QDBTabBarViewController.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/10/24.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBTabBarViewController.h"
#import "QDBEssencialViewController.h"
#import "QDBNewViewController.h"
#import "QDBFriendTrendsViewController.h"
#import "QDBMeViewController.h"
#import "QDBTabBar.h"
#import "QDBNavgationController.h"

@interface QDBTabBarViewController ()

@end

@implementation QDBTabBarViewController

+(void)initialize
{
    //UIAppearance
    UITabBarItem *item = [UITabBarItem appearance];
    NSDictionary *arrDict = [NSMutableDictionary dictionary];
    [arrDict setValue:[UIFont systemFontOfSize:12.0] forKey:NSFontAttributeName];
    [arrDict setValue:[UIColor grayColor] forKey:NSForegroundColorAttributeName];
    [item setTitleTextAttributes:arrDict forState:UIControlStateNormal];
    
    NSDictionary *arrDictSel = [NSMutableDictionary dictionary];
    [arrDictSel setValue:[UIFont systemFontOfSize:12.0] forKey:NSFontAttributeName];
    [arrDictSel setValue:[UIColor darkGrayColor] forKey:NSForegroundColorAttributeName];
    [item setTitleTextAttributes:arrDictSel forState:UIControlStateSelected];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化自控制器
    [self setupChildVCS];
    
    //替换系统tabbar
    [self setValue:[[QDBTabBar alloc]init] forKeyPath:@"tabBar"];
}
//初始化自控制器
- (void)setupChildVCS
{
    //精华
    [self setUpChildVc:[[QDBEssencialViewController alloc]init] title:@"精华" imageName:@"tabBar_essence_icon" selImageName:@"tabBar_essence_click_icon"];
    //新帖
    [self setUpChildVc:[[QDBNewViewController alloc]init] title:@"新帖" imageName:@"tabBar_new_icon" selImageName:@"tabBar_new_click_icon"];
    //关注
    [self setUpChildVc:[[QDBFriendTrendsViewController alloc]init] title:@"关注" imageName:@"tabBar_friendTrends_icon" selImageName:@"tabBar_friendTrends_click_icon"];
    //我
    [self setUpChildVc:[[QDBMeViewController alloc]init] title:@"我" imageName:@"tabBar_me_icon" selImageName:@"tabBar_me_click_icon"];
}
//初始化自控制器
-(void)setUpChildVc:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName selImageName:(NSString *)selImageName
{

    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selImageName];
    
    QDBNavgationController *nav = [[QDBNavgationController alloc]initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}
@end
