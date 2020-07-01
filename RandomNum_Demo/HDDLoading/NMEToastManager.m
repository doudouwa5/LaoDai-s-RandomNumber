//
//  NMEToast.m
//  NearMerchant
//
//  Created by 陈建国 on 2018/12/28.
//  Copyright © 2018 qmm. All rights reserved.
//

#import "NMEToastManager.h"
#import "UIViewController+GetController.h"

@interface NMEToastManager()

@property(nonatomic,strong)NSMutableArray *toastes;

@end

@implementation NMEToastManager


+(NMEToastManager *)manager{
    static NMEToastManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[NMEToastManager alloc] init];
        }
    });
    
    return manager;
}


-(NSMutableArray *)toastes{
    if (!_toastes) {
        _toastes = [NSMutableArray array];
    }
    return _toastes;
}

+(void)showToastWith:(NSString *)title position:(Position)position{
    
    [NMETitleToast showToastWith:title position:position];
    
}

+(void)showToastWith:(NSString *)title{
    [NMETitleToast showToastWith:title position:Position_Center];
}


+(void)showLoading{
    [NMELoadingToast showLoading];
}

+(void)hiddenLoading{
    [NMELoadingToast hiddenLoading];

}
@end



@interface NMETitleToast()


@property (weak, nonatomic) IBOutlet UILabel *msgLabel;


@end


@implementation NMETitleToast

+(void)showToastWith:(NSString *)title position:(Position)position{
    UIView *view = [UIViewController currentController].view;
    if (!view) {
        return;
    }
    NMETitleToast *toast = [[[NSBundle mainBundle] loadNibNamed:@"NMETitleToast" owner:self options:nil] firstObject];
    
    toast.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75];
    toast.msgLabel.text = title;
    
    toast.layer.cornerRadius = 4.0f;
    toast.layer.masksToBounds = YES;

    [view addSubview:toast];
    [toast mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(view.mas_left).with.offset(15);
        make.right.lessThanOrEqualTo(view.mas_right).with.offset(-15);
        if (position == Position_Top) {
            make.top.equalTo(view.mas_top).with.offset(120);
        }else if (position == Position_Center){
            make.centerY.equalTo(view.mas_centerY).with.offset(0);
        }else if (position == Position_Bottom){
            make.bottom.equalTo(view.mas_bottom).with.offset(-100);
        }
        make.centerX.equalTo(view.mas_centerX).with.offset(0);
    }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.25 animations:^{
            toast.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        } completion:^(BOOL finished) {
            [toast removeFromSuperview];
        }];
    });

}

@end



@interface NMELoadingToast()


//@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@property (weak, nonatomic) IBOutlet UIImageView *loadingImageView;

@end

@implementation NMELoadingToast


+(void)showLoading{
    NSMutableArray *toasts = [self manager].toastes;
    NMELoadingToast *toast = [toasts firstObject];
    
    UIViewController *controller = [UIViewController currentController];
    UIView *view = controller.view;
    
    if ([controller isBeingDismissed]) {
        UIViewController *pc = controller.presentingViewController;
        view = pc.view;
    }
    
    if (!view) {
        return;
    }
    
    if (!toast) {
        toast = [[[NSBundle mainBundle] loadNibNamed:@"NMELoadingToast" owner:self options:nil] firstObject];
        toast.layer.cornerRadius = 5.0f;
        toast.layer.masksToBounds = YES;
        //toast.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75];
        toast.backgroundColor = [UIColor clearColor];
        [[self manager].toastes addObject:toast];

//        //gif
//        NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"icon_loading" withExtension:@"gif"];//加载GIF图片
//        CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)fileUrl, NULL);//将GIF图片转换成对应的图片源
//        size_t frameCout=CGImageSourceGetCount(gifSource);//获取其中图片源个数，即由多少帧图片组成
//        NSMutableArray* frames=[[NSMutableArray alloc] init];//定义数组存储拆分出来的图片
//        for (size_t i=0; i<frameCout;i++){
//            CGImageRef imageRef=CGImageSourceCreateImageAtIndex(gifSource, i, NULL);//从GIF图片中取出源图片
//            UIImage* imageName=[UIImage imageWithCGImage:imageRef];//将图片源转换成UIimageView能使用的图片源
//            [frames addObject:imageName];//将图片加入数组中
//            CGImageRelease(imageRef);
//        }
//        toast.loadingImageView.animationImages=frames;//将图片数组加入UIImageView动画数组中
//        toast.loadingImageView.animationDuration=3;//每次动画时长
//        [toast.loadingImageView startAnimating];//开启动画，此处没有调用播放次数接口，UIImageView默认播放次数为无限次，故这里不做处理
        
        
        toast.loadingImageView.image = [UIImage imageNamed:@"loading-4"];

        //------- 旋转动画 -------//
        CABasicAnimation *animation = [ CABasicAnimation
                                      animationWithKeyPath: @"transform" ];
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        // 围绕Z轴旋转，垂直与屏幕
        animation.toValue = [ NSValue valueWithCATransform3D:
                            CATransform3DMakeRotation(M_PI, 0.0, 0.0, 1.0) ];
        animation.duration = 0.5;
        // 旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
        animation.cumulative = YES;
        animation.repeatCount = 1000;

        //在图片边缘添加一个像素的透明区域，去图片锯齿
        CGRect imageRrect = CGRectMake(0, 0,toast.loadingImageView.frame.size.width, toast.loadingImageView.frame.size.height);
        UIGraphicsBeginImageContext(imageRrect.size);
        [toast.loadingImageView.image drawInRect:CGRectMake(1,1,toast.loadingImageView.frame.size.width-2,toast.loadingImageView.frame.size.height-2)];
        toast.loadingImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        // 添加动画
        [toast.loadingImageView.layer addAnimation:animation forKey:nil];
    }


    [view addSubview:toast];
    
    [toast mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
        make.centerX.equalTo(view.mas_centerX).with.offset(0);
        make.centerY.equalTo(view.mas_centerY).with.offset(-30);
    }];

//    [toast.activityIndicatorView startAnimating];
    
}

+(void)hiddenLoading{
    NSMutableArray *toasts = [self manager].toastes;

    NMELoadingToast *toast = [toasts firstObject];
//    [toast.activityIndicatorView stopAnimating];
    
    [toast removeFromSuperview];
    
}



@end
