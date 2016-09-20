//
//  MoneySingleton.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/23.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountBook.h"
#import "DDMenuController.h"

@interface MoneySingleton : NSObject

+ (MoneySingleton *)sharedMoneySingleton;

@property (nonatomic, retain)DDMenuController *menuController;

// 默认信息
@property (nonatomic, assign)NSInteger defaultAccountBookID;
@property (nonatomic, copy)NSString *defaultAccountBookImageName;

@end
