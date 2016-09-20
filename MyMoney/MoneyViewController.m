//
//  MoneyViewController.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/1.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "MoneyViewController.h"

@interface MoneyViewController ()

@end

@implementation MoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavigationBarWithType:(NavBarTypeNotRoot | NavBarTypeString) leftItemTitleOrImageName:@"随手理财" leftAction:@selector(backBtnClick) centerTitle:nil rightItemTitleOrImageName:nil rightAction:nil];
    
    // 加载网页用的控件
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    
    NSString *urlstring = @"http://bbs.feidee.com";
    NSURL *url = [NSURL URLWithString:urlstring];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    
    
    [self.view addSubview:webView];
    [webView release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
