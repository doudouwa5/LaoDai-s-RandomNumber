//
//  HDDNavigationController.m
//  RandomNum_Demo
//
//  Created by HanDD on 2020/6/29.
//  Copyright © 2020 AlezJi. All rights reserved.
//

#import "HDDNavigationController.h"

@interface HDDNavigationController ()<UINavigationControllerDelegate>

@end

@implementation HDDNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{

    if (viewController == navigationController.viewControllers[0])
    {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
    }else {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

@end
