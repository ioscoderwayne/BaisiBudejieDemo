//
//  QDBTextField.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/10/28.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBTextField.h"
#import <objc/runtime.h>

@implementation QDBTextField

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    unsigned int count;
    
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    
    for (int i =0; i< count; i++) {
        
        Ivar ivar = *(ivars+i);
        
        NSLog(@"---%s",ivar_getName(ivar));
    }
    self.tintColor = self.textColor;
    
    [self setValue:[UIColor whiteColor] forKeyPath:@"_clearButton.backgroundColor"];
    
    [self resignFirstResponder];
    
}

-(BOOL)becomeFirstResponder
{

    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    
   return [super becomeFirstResponder];
    
   
}

-(BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
   return  [super resignFirstResponder];
}
@end
