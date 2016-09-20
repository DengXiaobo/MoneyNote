//
//  CategoryM.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/24.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "CategoryM.h"

@implementation CategoryM

- (void)dealloc
{
    [_cName release];
    [_cPath release];
    [_cIconName release];
    [super dealloc];
}

@end
