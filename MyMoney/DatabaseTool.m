//
//  DatabaseTool.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/22.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "DatabaseTool.h"

@implementation DatabaseTool

+ (FMDatabase *)sharedDataBase
{
    static FMDatabase *db = nil;
    
    if (db == nil)
    {
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/money.sqlite"];
        db = [[FMDatabase alloc] initWithPath:path];
        [db setShouldCacheStatements:YES];
    }
    
    return db;
}

@end
