//
//  HDDTableBarControllerViewController.m
//  RandomNum_Demo
//
//  Created by HanDD on 2020/6/29.
//  Copyright © 2020 AlezJi. All rights reserved.
//

#import "HDDTableBarControllerViewController.h"
#import "HDDHomeViewController.h"
#import "HDDFriendViewController.h"
#import "HDDDiscoverViewController.h"
#import "HDDMineViewController.h"
#import "HDDNavigationController.h"

@interface HDDTableBarControllerViewController ()<UITabBarControllerDelegate,UITabBarDelegate>
{
    NSUInteger          _lastSelectedIndex;
    BOOL                _isConfLoadFinish;
    BOOL                _isTabsLoadFinish;
}

@end

@implementation HDDTableBarControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    
    [self setChildCon];
}

-(void) setChildCon{
    
    HDDHomeViewController *vcHome = [[HDDHomeViewController alloc] init];
    HDDNavigationController* navHome = [[HDDNavigationController alloc] initWithRootViewController:vcHome];
    navHome.title = @"随机数";
    [navHome.tabBarItem setImage:[[UIImage imageNamed:@"jisuanqi-2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [navHome.tabBarItem  setSelectedImage:[[UIImage imageNamed:@"jisuanqi"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];



    HDDFriendViewController *vcFriend = [[HDDFriendViewController alloc] init];
    HDDNavigationController* navFriend = [[HDDNavigationController alloc] initWithRootViewController:vcFriend];
    navFriend.title = @"转换器";
    [navFriend.tabBarItem setImage:[[UIImage imageNamed:@"shuben-2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [navFriend.tabBarItem  setSelectedImage:[[UIImage imageNamed:@"shuben"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    HDDDiscoverViewController *vcDiscover = [[HDDDiscoverViewController alloc] init];
    HDDNavigationController* navDiscover = [[HDDNavigationController alloc] initWithRootViewController:vcDiscover];
    navDiscover.title = @"发现";
    [navDiscover.tabBarItem setImage:[[UIImage imageNamed:@"diqiuyi-2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [navDiscover.tabBarItem  setSelectedImage:[[UIImage imageNamed:@"diqiuyi"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    HDDMineViewController *vcMine = [[HDDMineViewController alloc] init];
    HDDNavigationController* navMine = [[HDDNavigationController alloc] initWithRootViewController:vcMine];
    navMine.title = @"我的";
    [navMine.tabBarItem setImage:[[UIImage imageNamed:@"biyesheng-2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [navMine.tabBarItem  setSelectedImage:[[UIImage imageNamed:@"biyesheng"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    self.viewControllers = @[navHome,navFriend,navDiscover,navMine];
    
}

#pragma mark -- touches
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSLog(@"controller === %@",viewController);

    NSUInteger currentIndex = tabBarController.selectedIndex;
    
    if ([[UIViewController currentController] isKindOfClass:[HDDDiscoverViewController class]] &&  currentIndex == _lastSelectedIndex) {
        [[NSNotificationCenter defaultCenter] postNotificationName:HDDNotificationRepeatClick object:nil];
        return;
    }

    _lastSelectedIndex = currentIndex;

}

@end
