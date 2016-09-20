//
//  DatabaseTool.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/22.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface DatabaseTool : NSObject

+ (FMDatabase *)sharedDataBase;

@end
