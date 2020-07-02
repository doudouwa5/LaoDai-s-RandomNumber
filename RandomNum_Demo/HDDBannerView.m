//
//  HDDBannerView.m
//  RandomNum_Demo
//
//  Created by HanDD on 2020/7/2.
//  Copyright © 2020 AlezJi. All rights reserved.
//

#import "HDDBannerView.h"
#import "SDCycleScrollView.h"

@interface HDDBannerView()<SDCycleScrollViewDelegate>

@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property (weak, nonatomic) IBOutlet UILabel *createLbel;

@end

@implementation HDDBannerView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.cycleScrollView.delegate = self;
    [self setBannerView];
    [self bringSubviewToFront:self.createLbel];
}


-(void) setBannerView{
    
//    NSArray *imagesURLStrings = @[
//                              @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
//                              @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
//                              @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
//                              ];
//
//    // 情景三：图片配文字
//       NSArray *titles = @[@"新建交流QQ群：185534916 ",
//                           @"disableScrollGesture可以设置禁止拖动",
//                           @"感谢您的支持，如果下载的",
//                           @"如果代码在使用过程中出现问题",
//                           @"您可以发邮件到gsdios@126.com"
//                           ];
//
//    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(10, 280, kScreenWidth - 20, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
//
//    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//    _cycleScrollView.titlesGroup = titles;
//    _cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
//    [self addSubview:_cycleScrollView];
//    _cycleScrollView.sd_layout.leftSpaceToView(self, 10).rightSpaceToView(self, 10).topSpaceToView(self, 10).bottomSpaceToView(self, 10);
//
//    //         --- 模拟加载延迟
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self->_cycleScrollView.imageURLStringsGroup = imagesURLStrings;
//    });
//
//    /*
//     block监听点击方式
//
//     cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
//        NSLog(@">>>>>  %ld", (long)index);
//     };
//
//     */
    
    // 情景一：采用本地图片实现
       NSArray *imageNames = @[
                               @"liangren",
                               @"xiaohou",
                               @"xunxun.JPG",
                               @"piTang",
                               @"dai" // 本地图片请填写全名
                               ];
    // 本地加载 --- 创建不带标题的图片轮播器
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(15, 10, kScreenWidth-20, (kScreenWidth -20)/3*5) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    _cycleScrollView.layer.masksToBounds = YES;
    _cycleScrollView.layer.cornerRadius = 10.0;
    _cycleScrollView.delegate = self;
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self addSubview:_cycleScrollView];
    [_cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(10, 15, 10, 15));
    }];
    _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //         --- 轮播时间间隔，默认1.0秒，可自定义
    //cycleScrollView.autoScrollTimeInterval = 4.0;
    _cycleScrollView.clickItemOperationBlock = ^(NSInteger currentIndex) {
        NSLog(@"currentIndex = %ld",(long)currentIndex);
    };
}


@end
