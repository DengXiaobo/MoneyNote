//
//  ZYTabBar.h
//  Demo
//
//  Created by Dengxiaobo on 16/6/22.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZYTabBarDelegate;

@interface ZYTabBar : UIView
{
    UIButton *_leftBtn;
}

- (void)changedOrientation:(CGFloat)angle;

@property (nonatomic,assign) id <ZYTabBarDelegate>delegate;
@end

@protocol ZYTabBarDelegate <NSObject>

- (void)tabBarItemClicked:(NSInteger)itemTag;

@end
