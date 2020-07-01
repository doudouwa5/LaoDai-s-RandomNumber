//
//  HDDCommonViewController.h
//  NearMerchant
//
//  Created by 韩豆豆 on 2020/6/29.
//  Copyright © 2019年 qmm. All rights reserved.
//

/**
 该基类controller 目前只针对下面几个属性进行了简单的封装；
 建议：
 1、将下面标记为 navgationBar 的属性赋值语句写在 viewWillAppear 中，或重写 setupNavgationBar 方法，
        ps：不可写在 viewDidLoad 方法中
 
2、将下面标记为 navgationBarItems 的属性赋值语句写在 viewDidLoad 中，或重写 setupNavgationBarItmes 方法，不建议写在 viewWillAppear 方法中
3、本类只简单的封装了 rightBarItme、backBarItem以及navBar的title 的字体颜色，如果需要进行复杂定制，考虑到无论怎么封装，使用者在传递参数的时候，都不会很方便，所以使用者调用系统方法就行，建议将对navbaritem 的赋值语句写在viewDidLoad里或者setupNavgationBarItmes方法中
 */

#import <UIKit/UIKit.h>

@interface HDDCommonViewController : UIViewController
#pragma -mark navgationBar

//是否显示蓝色的背景图
@property(nonatomic)BOOL isBlueView;

//是否显示navBar
@property(nonatomic)BOOL showNavBar;
//是否显示自定义的navBar
@property(nonatomic)BOOL showCustomNavBar;
//title的颜色
@property(nonatomic,strong)UIColor *titleColor;
//navgationbar 背景颜色
@property(nonatomic,strong)UIColor *barTintColor;
//navgationbar 下面的那条线
@property(nonatomic,strong)UIImage *shadowImage;
//navgationbar 是否半透明
@property(nonatomic)BOOL navTranslucent;

#pragma -mark navgationBarItems
//返回按钮图片
@property(nonatomic,strong)UIImage *backItemImage;
//navgationbar 的背景图片
@property(nonatomic,strong)UIImage *navgationBarImage;
// rightbarItme 背景图片
@property(nonatomic,strong)UIImage *rightBarItemImage;
// rightbarItem title 背景图片与title 不能同时使用，优先使用图片
@property(nonatomic,strong)NSString *rightBarTitle;

-(void)setupNavgationBar;

-(void)setupNavgationBarItmes;

//-(void)rightBtnClick:(UIButton *)btn
//-(void)backAction:(UIButton *)btn

@end
