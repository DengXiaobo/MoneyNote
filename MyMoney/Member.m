//
//  Member.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/25.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "Member.h"

@implementation Member

- (void)dealloc
{
    [_mName release];
    [super dealloc];
}

@end
