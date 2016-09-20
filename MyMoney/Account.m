//
//  Account.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/24.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "Account.h"

@implementation Account

- (void)dealloc
{
    [_aName release];
    [_aPath release];
    [super dealloc];
}

@end
