//
//  MemberTableDAO.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/24.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "MemberTableDAO.h"
#import "DatabaseTool.h"

@implementation MemberTableDAO

//CREATE TABLE "t_member" (memberID integer PRIMARY KEY,name text,usedCount integer)

+ (NSMutableArray *)getAllMember
{
    FMDatabase *db = [DatabaseTool sharedDataBase];
    if (![db open])
    {
        [db close];
        return nil;
    }
    
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_member"];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while ([rs next])
    {
        Member *member = [[Member alloc] init];
        member.mID = [rs intForColumn:@"memberID"];
        member.mName = [rs stringForColumn:@"name"];
        member.mUsedCount = [rs intForColumn:@"usedCount"];
        [array addObject:member];
        [member release];
    }
    [rs close];
    [db close];
    
    return [array autorelease];
}

+ (NSMutableArray *)getRecentMember
{
    FMDatabase *db = [DatabaseTool sharedDataBase];
    if (![db open])
    {
        [db close];
        return nil;
    }
    
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_member WHERE usedCount > 0"];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while ([rs next])
    {
        Member *member = [[Member alloc] init];
        member.mID = [rs intForColumn:@"memberID"];
        member.mName = [rs stringForColumn:@"name"];
        member.mUsedCount = [rs intForColumn:@"usedCount"];
        [array addObject:member];
        [member release];
    }
    [rs close];
    [db close];
    
    return [array autorelease];
}

+ (void)updateUsedCountWithMemberID:(NSInteger)mID
{
    FMDatabase *db = [DatabaseTool sharedDataBase];
    if (![db open])
    {
        [db close];
        return;
    }
    
    [db executeUpdate:@"UPDATE t_member SET usedCount = usedCount + 1 WHERE memberID = ?",@(mID)];
    [db close];
}






@end
