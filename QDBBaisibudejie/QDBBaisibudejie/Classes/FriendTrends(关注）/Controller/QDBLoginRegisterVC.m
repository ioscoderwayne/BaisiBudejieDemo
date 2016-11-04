//
//  QDBLoginRegisterVC.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/10/28.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBLoginRegisterVC.h"

@interface QDBLoginRegisterVC ()
- (IBAction)closeBtnClicked;
- (IBAction)rightBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;

@end

@implementation QDBLoginRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)closeBtnClicked {
    UIButton *btn = nil;
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)rightBtnClicked:(UIButton *)sender {
    //关闭键盘
    [self.view endEditing:YES];
    
    if (self.leftConstraint.constant==0) {
        //修改按钮文字
        [sender setTitle:@"已有账号" forState:UIControlStateNormal];
        //跳转到注册
        self.leftConstraint.constant = -self.view.width;
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
    }else{
        //修改按钮文字
        [sender setTitle:@"注册账号" forState:UIControlStateNormal];

        //跳转到登录
        self.leftConstraint.constant = 0;
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)even{
    [self.view endEditing:YES];
}
@end
