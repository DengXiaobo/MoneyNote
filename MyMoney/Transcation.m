//
//  Transcation.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/26.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "Transcation.h"

@implementation Transcation

- (void)dealloc
{
    [_tCategoryName release];
    [_tCategoryPath release];
    [_tAccountPath release];
    [_tRemark release];
    [_tImgName release];
    [_tIconName release];
    [super dealloc];
}

@end
