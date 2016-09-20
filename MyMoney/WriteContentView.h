//
//  WriteContentView.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/16.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WriteContentView : UIView
{
    NSMutableArray          *_controlArray;
}
- (id)initWithFrame:(CGRect)frame vc:(UIViewController *)vc action:(SEL)action;

@end
