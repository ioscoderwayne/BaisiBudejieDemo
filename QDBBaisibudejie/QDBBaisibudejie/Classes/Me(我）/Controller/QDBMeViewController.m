//
//  QDBMeViewController.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/10/24.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBMeViewController.h"

@interface QDBMeViewController ()

@end

@implementation QDBMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = GlobalBackGroundColor;
    
    self.navigationItem.title = @"我的";
    
    //右侧按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImageName:@"mine-setting-icon" selImageName:@"mine-setting-icon-click" target:self action:@selector(settingBtnClicked)];
    UIBarButtonItem *noonItem = [UIBarButtonItem itemWithImageName:@"mine-moon-icon" selImageName:@"mine-moon-icon-click" target:self action:@selector(noonBtnClicked)];
    self.navigationItem.rightBarButtonItems = @[settingItem,noonItem];
    
    
    QDBFunLog
}

-(void)settingBtnClicked
{
    QDBFunLog
}

-(void)noonBtnClicked
{
    QDBFunLog
}
@end
