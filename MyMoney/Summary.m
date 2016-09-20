//
//  Summary.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/29.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "Summary.h"

@implementation Summary

- (void)dealloc
{
    [_sIconName release];
    [_sTime release];
    [_sIntro release];
    [super dealloc];
}

@end
