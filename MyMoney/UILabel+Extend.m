//
//  UILabel+Extend.m
//  Demo
//
//  Created by Dengxiaobo on 16/6/2.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "UILabel+Extend.h"

@implementation UILabel (Extend)



- (void)animateWithNumber:(CGFloat)number
{
    self.text = @"0.00";
    
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(animateChanged:) userInfo:@(number) repeats:YES];
}

- (void)animateChanged:(NSTimer *)timer{

    float number = [timer.userInfo floatValue];
    float currentNumber = [self.text floatValue];
    // 每隔0.01 秒 就改变label上的文字,每次加
//    0.00      @"189";
//    6.3
//    12.6
    
    
    currentNumber += (number/30);
    
    if (fabs(currentNumber) >= fabs(number))
    {
        self.text = [NSString stringWithFormat:@"%.2f",number];
        [timer invalidate];
    }
    else
    {
        self.text = [NSString stringWithFormat:@"%.2f",currentNumber];
    }
}
@end
