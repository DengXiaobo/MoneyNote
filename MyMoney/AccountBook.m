//
//  AccountBook.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/22.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "AccountBook.h"

@implementation AccountBook

- (void)dealloc
{
    [_abName release];
    [_abImageName release];
    [_abHomeImageName release];
    [super dealloc];
}

@end
