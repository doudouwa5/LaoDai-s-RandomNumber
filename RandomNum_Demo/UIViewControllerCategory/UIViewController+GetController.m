//
//  UIViewController+GetController.m
//  NearMerchant
//
//  Created by 陈玉龙 on 2018/3/28.
//  Copyright © 2018年 qmm. All rights reserved.
//

#import "UIViewController+GetController.h"

@implementation UIViewController (GetController)

#pragma mark - Controller
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)currentController {
    //获取Window
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    
    //获取当前Controller
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    
    return result;
}








@end
