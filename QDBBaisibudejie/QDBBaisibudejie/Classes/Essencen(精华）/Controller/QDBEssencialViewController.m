//
//  QDBEssencialViewController.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/10/24.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBEssencialViewController.h"
#import "QDBRecommendTagsVC.h"
//#import "QDBAllViewController.h"
//#import "QDBVideoController.h"
//#import "QDBVoiceController.h"
//#import "QDBPictureController.h"
//#import "QDBWordController.h"
#import "QDBTopicViewController.h"

@interface QDBEssencialViewController ()<UIScrollViewDelegate>
//记录选中按钮
@property (nonatomic,weak) UIButton *selectedBtn;

@property (nonatomic,weak) UIView *indcatorView;

@property (nonatomic,weak) UIView *topMenuView;

@property (nonatomic,weak) UIScrollView *scrollView;
@end

@implementation QDBEssencialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景色
    self.view.backgroundColor = GlobalBackGroundColor;
    //设置导航栏
    [self setupNav];
    
    //添加子控制器
    [self addChildVCs];
    
    //设置顶部菜单
    [self setupTopMenuView];
    
    //设置scrollView
    [self setupScrollView];

}

-(void)setupNav
{
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //左侧按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"MainTagSubIcon" selImageName:@"MainTagSubIconClick" target:self action:@selector(tagBtnClicked)];

}

/**
 * 添加子控制器
 */

-(void)addChildVCs
{
    
    QDBTopicViewController *pic = [[QDBTopicViewController alloc]init];
    pic.title = @"图片";
    pic.topicType = QDBTopicTypePicture;
    [self addChildViewController:pic];
   
    QDBTopicViewController *allVc = [[QDBTopicViewController alloc]init];
    allVc.title = @"全部";
    allVc.topicType = QDBTopicTypeAll;
    [self addChildViewController:allVc];
    
    QDBTopicViewController *video = [[QDBTopicViewController alloc]init];
    video.title = @"视频";
    video.topicType = QDBTopicTypeVideo;
    [self addChildViewController:video];
    
    QDBTopicViewController *voice = [[QDBTopicViewController alloc]init];
    voice.title = @"声音";
    voice.topicType = QDBTopicTypeVoice;
    [self addChildViewController:voice];
    
    QDBTopicViewController *word = [[QDBTopicViewController alloc]init];
    word.title = @"段子";
    word.topicType = QDBTopicTypeWord;
    [self addChildViewController:word];
    
}
/**
 * 设置ScrollView
 */
-(void)setupScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view insertSubview:scrollView atIndex:0];
    self.scrollView = scrollView;
    
    //滚动到第一个
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
/**
 * 设置顶部菜单按钮
 */
-(void)setupTopMenuView
{
    UIView *topMenuView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavH, self.view.width, kTopMenuH)];
    topMenuView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.7];
    //底部的指示线
    UIView *indcatorView = [[UIView alloc]init];
    indcatorView.height = 2;
    indcatorView.y = kTopMenuH - indcatorView.height;
    indcatorView.backgroundColor = [UIColor redColor];
//    [topMenuView addSubview:indcatorView];
    self.indcatorView = indcatorView;
    //添加5个按钮
    CGFloat titileBtnW = self.view.width/self.childViewControllers.count;
    CGFloat titleBtnH = kTopMenuH;
    for (int i= 0; i < self.childViewControllers.count; i++) {
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.tag = i;
//        titleBtn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
        titleBtn.width = titileBtnW;
        titleBtn.height = titleBtnH;
        titleBtn.x = i * titileBtnW;
        UIViewController *vc = self.childViewControllers[i];
        [titleBtn setTitle:vc.title forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [titleBtn addTarget:self action:@selector(titleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [topMenuView addSubview:titleBtn];
        //默认选中第一个按钮
        if (i == 0) {
            titleBtn.enabled = NO;
            self.selectedBtn = titleBtn;
            
            [titleBtn.titleLabel sizeToFit];
            //指示线
            self.indcatorView.width = titleBtn.titleLabel.width;
            self.indcatorView.centerX = titleBtn.centerX;
            
            
            QDBLog(@"----------%@",NSStringFromCGRect(self.indcatorView.frame));
            QDBLog(@"==%f==%f",titleBtn.centerX,self.indcatorView.centerX);
    
        }
    }
    
    [topMenuView addSubview:indcatorView];
    
    [self.view addSubview:topMenuView];
    self.topMenuView = topMenuView;
}
/**
 * 点击顶部菜单按钮
 */
-(void)titleBtnClicked:(UIButton *)btn
{
    btn.enabled = NO;
    self.selectedBtn.enabled = YES;
    self.selectedBtn = btn;
    
    [UIView animateWithDuration:0.25 animations:^{
        //指示线位置调整
        self.indcatorView.centerX = btn.centerX;
        self.indcatorView.width = btn.titleLabel.width;
    }];
    QDBLog(@"==%@",NSStringFromCGRect(self.indcatorView.frame));
    //滚动scrollView
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = btn.tag * self.view.width;
    [self.scrollView setContentOffset:offset animated:YES];

}
/**
 * 点击tag
 */
-(void)tagBtnClicked
{
    QDBRecommendTagsVC *recommendTags = [[QDBRecommendTagsVC alloc]init];
    
    [self.navigationController pushViewController:recommendTags animated:YES];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //添加控制器的view
    NSInteger index = scrollView.contentOffset.x/self.view.width;
    
    UIViewController *vc = self.childViewControllers[index];

    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    vc.view.width = scrollView.width;
    
    
    //添加到scrollView
    [scrollView addSubview:vc.view];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //点击按钮
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    
    [self titleBtnClicked:self.topMenuView.subviews[index]];
}
@end
