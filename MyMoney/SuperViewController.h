//
//  SuperViewController.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/17.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, NavBarType)
{
    NavBarTypeRoot          = 0 << 4,//导航的第一级     默认
    NavBarTypeNotRoot       = 1 << 4,//非导航的第一级
    NavBarTypeString        = 0 << 8,//文字            默认
    NavBarTypeImage         = 1 << 8,//图片
};

@interface SuperViewController : UIViewController

@property (nonatomic, retain)UIImageView *navImageView;

- (void)createNavigationBarWithType:(NavBarType)type leftItemTitleOrImageName:(NSString *)leftName leftAction:(SEL)leftAction centerTitle:(NSString *)centerName rightItemTitleOrImageName:(NSString *)rightName rightAction:(SEL)rightAction;

- (void)createAddTypeNavigationBarWithLeftTitle:(NSString *)leftTitle leftAction:(SEL)leftAction rightAction:(SEL)rightAction;

@end
