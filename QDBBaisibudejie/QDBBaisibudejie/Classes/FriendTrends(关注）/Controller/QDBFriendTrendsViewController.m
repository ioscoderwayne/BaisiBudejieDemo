//
//  QDBFriendTrendsViewController.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/10/24.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBFriendTrendsViewController.h"
#import "QDBRecommendViewController.h"
#import "QDBLoginRegisterVC.h"

@interface QDBFriendTrendsViewController ()
- (IBAction)loginRegisterBtnClicked;

@end

@implementation QDBFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = GlobalBackGroundColor;
    
    self.navigationItem.title = @"我的关注";
    
    //左侧按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"friendsRecommentIcon" selImageName:@"friendsRecommentIcon-click" target:self action:@selector(FriendTrendsBtnClicked)];
    
    
}

-(void)FriendTrendsBtnClicked
{
    QDBRecommendViewController *recommendVc =[[QDBRecommendViewController alloc]init];
    [self.navigationController pushViewController:recommendVc animated:YES];
}
/**
 *  点击登录注册按钮
 */
- (IBAction)loginRegisterBtnClicked
{
    QDBLoginRegisterVC *loginVc = [[QDBLoginRegisterVC alloc]init];
    
    [self presentViewController:loginVc animated:YES completion:nil];
}
@end
