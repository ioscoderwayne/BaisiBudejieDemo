//
//  QDBNewViewController.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/10/24.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBNewViewController.h"

@interface QDBNewViewController ()

@end

@implementation QDBNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = GlobalBackGroundColor;
    
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //左侧按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"MainTagSubIcon" selImageName:@"MainTagSubIconClick" target:self action:@selector(tagBtnClicked)];
    
    QDBFunLog
}

-(void)tagBtnClicked
{
    QDBFunLog
}

@end
