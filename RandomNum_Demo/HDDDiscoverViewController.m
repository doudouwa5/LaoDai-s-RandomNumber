//
//  HDDDiscoverViewController.m
//  RandomNum_Demo
//
//  Created by HanDD on 2020/6/29.
//  Copyright © 2020 AlezJi. All rights reserved.
//

#import "HDDDiscoverViewController.h"
#import <WebKit/WebKit.h>


@interface HDDDiscoverViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation HDDDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发现";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadView) name:HDDNotificationRepeatClick object:nil];
    self.webView.delegate =self;
    [self setWebView];
}

- (void) setWebView{
    
    NSURLRequest *request  = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://sina.cn"]];
    [_webView loadRequest:request];
    
}

-(void) reloadView{
    
    [self setWebView];
}

#pragma delegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [NMEToastManager showLoading];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [NMEToastManager hiddenLoading];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [NMEToastManager hiddenLoading];
}



-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
