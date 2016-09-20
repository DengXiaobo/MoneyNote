//
//  SuperViewController.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/17.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "SuperViewController.h"

@interface SuperViewController ()

@end

@implementation SuperViewController

- (void)dealloc
{
    [_navImageView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)createNavigationBarWithType:(NavBarType)type leftItemTitleOrImageName:(NSString *)leftName leftAction:(SEL)leftAction centerTitle:(NSString *)centerName rightItemTitleOrImageName:(NSString *)rightName rightAction:(SEL)rightAction
{
    // 导航条
    UIImageView *navImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    navImageView.image = [UIImage imageNamed:@"NavigationBar"];
    [self.view addSubview:navImageView];
    [navImageView release];
    
    // 左边按钮
    if (leftName)
    {
        int width = 0;
        if (type & NavBarTypeNotRoot)
        {
            UIButton *backImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            backImageBtn.frame = CGRectMake(15, 33, 10, 18);
            [backImageBtn setBackgroundImage:[UIImage imageNamed:@"IOS7BackBarButton"] forState:UIControlStateNormal];
            [backImageBtn addTarget:self action:leftAction forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:backImageBtn];
            
            width = 10;
        }
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        
        if (type & NavBarTypeImage)
        {
            leftBtn.frame = CGRectMake(15 + width, 30, 23, 23);
            [leftBtn setBackgroundImage:[UIImage imageNamed:leftName] forState:UIControlStateNormal];
        }
        else
        {
            leftBtn.frame = CGRectMake(15 + width, 30, 150, 23);
            [leftBtn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
            leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [leftBtn setTitle:leftName forState:UIControlStateNormal];
        }
        [leftBtn addTarget:self action:leftAction forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:leftBtn];
    }
    
    // 标题
    if (centerName)
    {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, SCREENWIDTH - 200, 44)];
        titleLabel.text = @"记一笔";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:titleLabel];
        [titleLabel release];
    }
    
    // 右边按钮
    if (rightName)
    {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if (type & NavBarTypeImage)
        {
            rightBtn.frame = CGRectMake(SCREENWIDTH - 43, 30, 23, 23);
            [rightBtn setBackgroundImage:[UIImage imageNamed:rightName] forState:UIControlStateNormal];
        }
        else
        {
            rightBtn.frame = CGRectMake(SCREENWIDTH - 120, 30, 100, 23);
            [rightBtn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
            rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [rightBtn setTitle:rightName forState:UIControlStateNormal];
        }
        [rightBtn addTarget:self action:rightAction forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:rightBtn];
    }
}

- (void)createAddTypeNavigationBarWithLeftTitle:(NSString *)leftTitle leftAction:(SEL)leftAction rightAction:(SEL)rightAction
{
    // 导航条
    UIImageView *navImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -250, SCREENWIDTH, 314)];
    navImageView.image = [UIImage imageNamed:@"NavigationWall"];
    [self.view addSubview:navImageView];
    [navImageView release];
    
    navImageView.hidden = YES;
    self.navImageView = navImageView;
    
    // 左边按钮
    UIButton *backImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backImageBtn.frame = CGRectMake(15, 33, 10, 18);
    [backImageBtn setBackgroundImage:[UIImage imageNamed:@"IOS7BackBarButton"] forState:UIControlStateNormal];
    [backImageBtn addTarget:self action:leftAction forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backImageBtn];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(25, 30, 150, 23);
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [leftBtn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtn setTitle:leftTitle forState:UIControlStateNormal];
    [leftBtn addTarget:self action:leftAction forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    // 右边+号
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(SCREENWIDTH - 43, 30, 23, 23);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"AddBarButton"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:rightAction forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
