//
//  HDDCommonViewController.m
//  NearMerchant
//
//  Created by 韩豆豆 on 2020/6/29.
//  Copyright © 2017年 qmm. All rights reserved.
//

#import "HDDCommonViewController.h"

@interface HDDCommonViewController ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIBarButtonItem *backItem;
@property(nonatomic,strong)UIBarButtonItem *rightItem;
//@property(nonatomic,strong)UIView *snapView;

@property(nonatomic,strong) UILabel *titLabel;
@property(nonatomic,strong) UIButton *rightBtn;

@end

@implementation HDDCommonViewController



- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationItem setHidesBackButton:YES animated:YES];
//    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavgationBarItmes];
    
    NSLog(@"*********=%@***********",NSStringFromClass([self class]));
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [self setupNavgationBar];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self setupSnapView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navgationBarImage  = nil;
}

-(void)setShowNavBar:(BOOL)showNavBar{
    _showNavBar = showNavBar;
    [self.navigationController setNavigationBarHidden:!_showNavBar animated:YES];
}

-(void)setShowCustomNavBar:(BOOL)showCustomNavBar{
    _showCustomNavBar = showCustomNavBar;
    self.showNavBar = NO;
    if(_showCustomNavBar && !_titLabel){
        //实际的蓝色部分的高度为98
        UIView *blueView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,  [self addTtatusBarHeigth] ? 118 + 24 : 118)];
        blueView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:blueView];
        
        UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftbtn.frame = CGRectMake(18, 28, 28, [self addTtatusBarHeigth] ? 28+44 : 28);
        [leftbtn setImage:[UIImage imageNamed:@"btn_back_BBL"] forState:UIControlStateNormal];
        [leftbtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
        [blueView addSubview:leftbtn];
        
        _titLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 22, kScreenWidth - 80, [self addTtatusBarHeigth] ? 40 + 44 : 40)];
        _titLabel.textColor = [UIColor whiteColor];
        _titLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
        _titLabel.textAlignment = NSTextAlignmentCenter;
        [blueView addSubview:_titLabel];
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(kScreenWidth - 18 - 28, 28, 28, [self addTtatusBarHeigth] ? 28+44 : 28);
        [_rightBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [blueView addSubview:_rightBtn];
        
        [self.view bringSubviewToFront:blueView];
    }
    if(self.title || self.rightBarItemImage){
        _titLabel.text = self.title;
        [_rightBtn setImage:self.rightBarItemImage forState:UIControlStateNormal];
    }
}

-(void)setTitle:(NSString *)title{
    [super setTitle:title];
    _titLabel.text = title;
}


-(void)backClick:(UIButton *)btn{
    if (self.presentingViewController){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (float) addTtatusBarHeigth{
    if([UIDeviceHardware is_iPhone_x]){
        return 24;
    }
    return 0;
}


-(void)setupNavgationBarItmes{
    self.backItemImage = [UIImage imageNamed:@"btn_back_BBL"];
}


-(void)setupNavgationBar{
    self.navTranslucent = NO;
    self.navgationBarImage = [self gradientImage];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold]}];


}


-(void)setBarTintColor:(UIColor *)barTintColor{
    _barTintColor = barTintColor;
    
    self.navigationController.navigationBar.barTintColor = _barTintColor;
}

-(void)setShadowImage:(UIImage *)shadowImage{
    _shadowImage = shadowImage;
    if (!self.navgationBarImage) {
        //只有设置了navgationbarImage 的时候，shadowImage 才会生效
        self.navgationBarImage = [UIImage new];
    }
    [self.navigationController.navigationBar setShadowImage:_shadowImage];
}


-(UIImage *)gradientImage{
    
    static UIImage *gImage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!gImage) {
            CAGradientLayer *layer = [[CAGradientLayer alloc] init];
            
            CGFloat heiht = CGRectGetHeight(self.navigationController.navigationBar.frame) + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
            layer.frame = CGRectMake(0, 0, kScreenWidth, heiht);
            layer.colors = @[(__bridge id)[HDDColor lightOrangeColor].CGColor,(__bridge id)[HDDColor darkOrangeColor].CGColor];
            layer.startPoint = CGPointMake(0, 0);
            layer.endPoint = CGPointMake(1.0, 0.0);
            UIGraphicsBeginImageContext(layer.frame.size);
            [layer renderInContext:UIGraphicsGetCurrentContext()];
            gImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    });
    return gImage;
}


-(void)setNavTranslucent:(BOOL)navTranslucent{
    _navTranslucent = navTranslucent;
    self.navigationController.navigationBar.translucent = _navTranslucent;
    if(navTranslucent){
        //把背景设为空
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        //处理导航栏有条线的问题
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }
}

-(void)setBackItemImage:(UIImage *)backItemImage{
    if (!backItemImage) {
        self.navigationItem.leftBarButtonItem.customView.hidden = YES;
        return;
    }
    _backItemImage = backItemImage;
    self.navigationItem.leftBarButtonItem = self.backItem;
    UIButton *btn = (UIButton *)self.backItem.customView;
    [btn setImage:_backItemImage forState:UIControlStateNormal];
}

-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:[UIFont systemFontOfSize:17 weight:UIFontWeightSemibold]}];
}

-(void)setRightBarItemImage:(UIImage *)rightBarItemImage{
    if(!rightBarItemImage){
        return;
    }
    _rightBarItemImage = rightBarItemImage;
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    [self.rightBtn setImage:rightBarItemImage forState:UIControlStateNormal];
}

-(void)setRightBarTitle:(NSString *)rightBarTitle{
    _rightBarTitle = rightBarTitle;
    self.navigationItem.rightBarButtonItem = self.rightItem;
}


-(void)setNavgationBarImage:(UIImage *)navgationBarImage{
    _navgationBarImage = navgationBarImage;
    [self.navigationController.navigationBar setBackgroundImage:_navgationBarImage forBarMetrics:UIBarMetricsDefault];
}


-(UIBarButtonItem *)backItem{
    if (!_backItem) {
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 65, 44);
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        _backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    }
    return _backItem;
}

-(UIBarButtonItem *)rightItem{
    if (!_rightItem) {
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        if (self.rightBarItemImage) {
            [rightButton setImage:self.rightBarItemImage forState:UIControlStateNormal];
        }else{
            [rightButton setTitle:self.rightBarTitle forState:UIControlStateNormal];
            [rightButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
        }
        
        [rightButton addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        rightButton.frame = CGRectMake(0, 0, 80, 44);
        rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        
    }
    
    return _rightItem;
}

-(void) setIsBlueView:(BOOL)isBlueView{
    _isBlueView = isBlueView;
    self.showNavBar = NO;
    if(_isBlueView){
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)[HDDColor lightOrangeColor].CGColor,(__bridge id)[HDDColor darkOrangeColor].CGColor];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 1.0);
        //gradientLayer.frame = self.view.bounds;
        gradientLayer.frame = [UIScreen mainScreen].bounds;
        [self.view.layer insertSublayer:gradientLayer atIndex:0];
    }
}


-(void)rightBtnClick:(UIButton *)btn{
    NSLog(@"子类自己实现%s", __FUNCTION__);
}



-(void)backAction:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//-(void)setupSnapView{
//    if (_snapView) {
//        return;
//    }
//
//    [self.view insertSubview:self.snapView atIndex:0];
//
////    self.snapView.layer.shadowColor = [UIColor blackColor].CGColor;
////    self.snapView.layer.shadowOffset = CGSizeMake(-5, 0);
////    self.snapView.layer.shadowOpacity = 0.2;
//
//}
//
//-(UIView *)snapView{
//    if (!_snapView) {
//        _snapView = [[UIView alloc] init];
//        if (isIPHONE_X) {
//            _snapView.frame = CGRectMake(0, -88, kScreenWidth, 88);
//        }else{
//            _snapView.frame = CGRectMake(0, -64, kScreenWidth, 64);
//        }
//
//        NSArray *arr = [self screenShotWith:_snapView];
//
//        [_snapView addSubview:[arr firstObject]];
//        [_snapView addSubview:arr[1]];
//        [_snapView addSubview:[arr lastObject]];
//
//
//
//    }
//    return _snapView;
//}
//
//
//- (NSArray *)screenShotWith:(UIView *)snapView
//{
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(kScreenWidth,CGRectGetHeight(snapView.frame)), YES, 0);  //NO，YES 控制是否透明
//
//    UIView *view = [self.navigationController.navigationBar.subviews firstObject];
//
//    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image_1 = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    UIImageView *imageView_1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, CGRectGetHeight(snapView.frame))];
//    imageView_1.image = image_1;
//
//
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(kScreenWidth,44), YES, 0);  //NO，YES 控制是否透明
//
//    [self.navigationController.navigationBar.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image_2 = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    UIImageView *imageView_2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(snapView.frame) - 44, kScreenWidth, 44)];
//    imageView_2.image = image_2;
//
//
//    UIImageView *imageView_3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(snapView.frame) - 1, kScreenWidth, 1)];
//    imageView_3.image = self.navigationController.navigationBar.shadowImage;
//    return @[imageView_1,imageView_2,imageView_3];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
