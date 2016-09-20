//
//  BusinessTableDAO.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/24.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "BusinessTableDAO.h"
#import "DatabaseTool.h"

@implementation BusinessTableDAO

//CREATE TABLE "t_business" (businessID integer PRIMARY KEY,name text,usedCount integer)

+ (NSMutableArray *)getAllBusiness
{
    FMDatabase *db = [DatabaseTool sharedDataBase];
    if (![db open])
    {
        [db close];
        return nil;
    }
    
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_business"];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while ([rs next])
    {
        Business *business = [[Business alloc] init];
        business.bID = [rs intForColumn:@"businessID"];
        business.bName = [rs stringForColumn:@"name"];
        business.bUsedCount = [rs intForColumn:@"usedCount"];
        [array addObject:business];
        [business release];
    }
    [rs close];
    [db close];
    
    return [array autorelease];
}

+ (NSMutableArray *)getRecentBusiness
{
    FMDatabase *db = [DatabaseTool sharedDataBase];
    if (![db open])
    {
        [db close];
        return nil;
    }
    
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_business WHERE usedCount > 0"];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while ([rs next])
    {
        Business *business = [[Business alloc] init];
        business.bID = [rs intForColumn:@"businessID"];
        business.bName = [rs stringForColumn:@"name"];
        business.bUsedCount = [rs intForColumn:@"usedCount"];
        [array addObject:business];
        [business release];
    }
    [rs close];
    [db close];
    
    return [array autorelease];
}

+ (void)updateUsedCountWithBusinessID:(NSInteger)bID
{
    FMDatabase *db = [DatabaseTool sharedDataBase];
    if (![db open])
    {
        [db close];
        return;
    }
    
    [db executeUpdate:@"UPDATE t_business SET usedCount = usedCount + 1 WHERE businessID = ?",@(bID)];
    [db close];
}

@end
