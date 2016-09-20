//
//  MoneySingleton.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/23.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "MoneySingleton.h"

@implementation MoneySingleton

+ (MoneySingleton *)sharedMoneySingleton
{
    static MoneySingleton *singleton = nil;
    if (singleton == nil)
    {
        singleton = [[MoneySingleton alloc] init];
        
        // 初始化账本id
        NSInteger abID = [[NSUserDefaults standardUserDefaults] integerForKey:@"abID"];
        singleton.defaultAccountBookID = (abID == 0) ? 1 : abID;
        
        // 初始化账本图片
        NSString *imageName = [[NSUserDefaults standardUserDefaults] objectForKey:@"abImageName"];
        singleton.defaultAccountBookImageName = (imageName == nil) ? @"bookTemplateBg_1" : imageName;
    }
    return singleton;
}

- (void)setDefaultAccountBookID:(NSInteger)defaultAccountBookID
{
    _defaultAccountBookID = defaultAccountBookID;
    
    [[NSUserDefaults standardUserDefaults] setInteger:defaultAccountBookID forKey:@"abID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setDefaultAccountBookImageName:(NSString *)defaultAccountBookImageName
{
    _defaultAccountBookImageName = defaultAccountBookImageName;
    
    [[NSUserDefaults standardUserDefaults] setObject:defaultAccountBookImageName forKey:@"abImageName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
