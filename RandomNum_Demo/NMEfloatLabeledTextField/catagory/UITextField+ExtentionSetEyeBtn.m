//
//  UITextField+ExtentionSetEyeBtn.m
//  NearMerchant
//
//  Created by 韩豆豆 on 2019/7/26.
//  Copyright © 2019年 qmm. All rights reserved.
//

#import "UITextField+ExtentionSetEyeBtn.h"
#import "UIView+Utils.h"

@implementation UITextField (ExtentionSetEyeBtn)

- (void)setTextFieldEyeBtn{
    
    UIButton *rightImageV = [[UIButton alloc] init];
    self.secureTextEntry = YES;
    [rightImageV setBackgroundImage:[UIImage imageNamed:@"eyeHide"] forState:UIControlStateNormal];
    [rightImageV setBackgroundImage:[UIImage imageNamed:@"eye"] forState:UIControlStateSelected];

    rightImageV.size = CGSizeMake(20, 20);
    rightImageV.contentMode = UIViewContentModeCenter;
    self.rightView = rightImageV;
    self.rightViewMode = UITextFieldViewModeAlways;
    [rightImageV addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];

}
//监听右边按钮的点击,切换密码输入明暗文状态
-(void)btnClick:(UIButton *)btn{
    //解决明暗文切换后面空格的问题的两种方式
    //NSString* text = self.text;
    //self.text = @" ";
    //self.text = text;
    //[self becomeFirstResponder];
    
    [self resignFirstResponder];//取消第一响应者
    btn.selected = !btn.selected;
    if (!btn.selected) {
        self.secureTextEntry = YES;
    }else{
        self.secureTextEntry = NO;
    }
    [self becomeFirstResponder];//第一响应者
}


@end
