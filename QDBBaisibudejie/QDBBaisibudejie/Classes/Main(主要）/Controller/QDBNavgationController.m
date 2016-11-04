//
//  QDBNavgationController.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/10/25.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBNavgationController.h"

@interface QDBNavgationController ()

@end

@implementation QDBNavgationController

+(void)initialize
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count>0) {
        //不是栈底控制器
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.size = CGSizeMake(70, 30);
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

-(void)back
{
    [self popViewControllerAnimated:YES];
}
@end
