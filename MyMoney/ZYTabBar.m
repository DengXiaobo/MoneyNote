//
//  ZYTabBar.m
//  Demo
//
//  Created by Dengxiaobo on 16/6/22.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "ZYTabBar.h"
#define TABBAR_COLOR       [UIColor colorWithRed:(90 / 255.0) green:(92 / 255.0) blue:(95 / 255.0) alpha:1]

@implementation ZYTabBar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = TABBAR_COLOR;
        
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.tag = 99;
        [_leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"toolbar_icon_arrow"] forState:UIControlStateNormal];
        _leftBtn.frame = CGRectMake(12, 12, 25, 25);
        [self addSubview:_leftBtn];
        
        NSArray *imgArr = @[@"toolbar_icon_transaction",@"toolbar_icon_account",@"toolbar_icon_report",@"toolbar_icon_finance",@"toolbar_icon_setting"];
        NSArray *titileArr = @[@"流水",@"账户",@"图表",@"理财",@"更多"];
        
        for (int i = 0 ; i < imgArr.count; i++)
        {
            UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(60+70*i, 25, 25, 30)];
            label.textColor =[UIColor whiteColor];
            label.text = titileArr[i];
            label.font = [UIFont systemFontOfSize:12];
            [self addSubview:label];
            [label release];
            
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = 100+i;
            btn.frame = CGRectMake(60+70*i, 0, 25, 49);
            [btn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
            btn.imageEdgeInsets =UIEdgeInsetsMake(-10, 0, 0, 0);
            btn.showsTouchWhenHighlighted = YES;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self addSubview:btn];
        }
    }
    return self;
}

- (void)btnClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(tabBarItemClicked:)])
    {
        [self.delegate tabBarItemClicked:sender.tag-99];
    }
}

- (void)changedOrientation:(CGFloat)angle
{
    _leftBtn.transform = CGAffineTransformMakeRotation(angle);
}
@end
