//
//  GraphViewController.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/1.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "GraphViewController.h"

@interface GraphViewController ()

@end

@implementation GraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavigationBarWithType:(NavBarTypeNotRoot | NavBarTypeString) leftItemTitleOrImageName:@"分类支出" leftAction:@selector(backBtnClick) centerTitle:nil rightItemTitleOrImageName:nil rightAction:nil];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    imageView.image = [UIImage imageNamed:@"graph.jpg"];
    [self.view addSubview:imageView];
    [imageView release];
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
