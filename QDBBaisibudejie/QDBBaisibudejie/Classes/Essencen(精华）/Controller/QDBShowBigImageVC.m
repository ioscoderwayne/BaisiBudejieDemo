//
//  QDBShowBigImageVC.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/11/7.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBShowBigImageVC.h"
#import "QDBTopic.h"
#import <UIImageView+WebCache.h>
#import "QDBCircleIndicatorView.h"

@interface QDBShowBigImageVC ()<UIScrollViewDelegate>
- (IBAction)saveBtnClicked:(id)sender;

- (IBAction)backBtnClicked;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet QDBCircleIndicatorView *circleIndicatorView;

@property (nonatomic,weak) UIImageView *imageView;
@end

@implementation QDBShowBigImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //uiimageView
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backBtnClicked)];
    [imageView addGestureRecognizer:tap];
    [self.scrollView addSubview:imageView];
    
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 2.0;

    self.imageView = imageView;
    
//    CGFloat originalH = self.topic.height;
    CGFloat originalW = self.topic.width;

    CGFloat imageH = kScreenH*originalW /kScreenW;
    if (imageH <=kScreenH) {
        //小图显示在中间
        imageView.size = CGSizeMake(kScreenW,imageH);
        imageView.centerY = kScreenH*0.5;

    }else{
        //从左上角开始显示大图
        imageView.frame = CGRectMake(0, 0, kScreenW, imageH);
        self.scrollView.contentSize = CGSizeMake(0, imageH);
    }
    
    //显示当前进度
    [self.circleIndicatorView setProgress:self.topic.currentProgress animated:NO];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:_topic.bigImage] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [self.circleIndicatorView setProgress:1.0 *receivedSize/expectedSize animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.circleIndicatorView.hidden = YES;
    }];
    
}
//点击保存按钮
- (IBAction)saveBtnClicked:(id)sender {
    if (!self.imageView.image) {
        //图片还没有下载完成
        [SVProgressHUD showErrorWithStatus:@"图片还没有下载完成！"];
        return;
    }
    
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
//点击返回按钮
- (IBAction)backBtnClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        //图片保存成功
        [SVProgressHUD showSuccessWithStatus:@"图片保存成功！"];
    }else{
        //图片保存失败
        [SVProgressHUD showSuccessWithStatus:@"图片保存失败！"];
    }
}

#pragma mark - scrolldelegate
-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    QDBLog(@"缩放ing-----%f", scrollView.zoomScale);
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
@end
