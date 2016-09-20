//
//  AccountTableDAO.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/24.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "AccountTableDAO.h"
#import "DatabaseTool.h"

@implementation AccountTableDAO

//CREATE TABLE "t_account" (accountID integer PRIMARY KEY,name text,path text,summary float)

+ (NSMutableArray *)getOneLevelAccount
{
    FMDatabase *db = [DatabaseTool sharedDataBase];
    if (![db open])
    {
        [db close];
        return nil;
    }
    
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_account WHERE path NOT LIKE '%/%'"];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while ([rs next])
    {
        Account *account = [[Account alloc] init];
        account.aID = [rs intForColumn:@"accountID"];
        account.aName = [rs stringForColumn:@"name"];
        account.aPath = [rs stringForColumn:@"path"];
        account.aSummary = [rs doubleForColumn:@"summary"];
        [array addObject:account];
        [account release];
    }
    [rs close];
    [db close];
    
    return [array autorelease];
}

+ (NSMutableArray *)getTwoLevelAccountWithOneLevelID:(NSInteger)oneLevelID
{
    FMDatabase *db = [DatabaseTool sharedDataBase];
    if (![db open])
    {
        [db close];
        return nil;
    }
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_account WHERE path LIKE '%ld/%%'",oneLevelID];
    
    FMResultSet *rs = [db executeQuery:sql];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while ([rs next])
    {
        Account *account = [[Account alloc] init];
        account.aID = [rs intForColumn:@"accountID"];
        account.aName = [rs stringForColumn:@"name"];
        account.aPath = [rs stringForColumn:@"path"];
        account.aSummary = [rs doubleForColumn:@"summary"];
        [array addObject:account];
        [account release];
    }
    [rs close];
    [db close];
    
    return [array autorelease];
}

+ (void)updateMoney4SummaryWithAccountID:(NSInteger)aID money:(CGFloat)money
{
    FMDatabase *db = [DatabaseTool sharedDataBase];
    if (![db open])
    {
        [db close];
        return;
    }
    
    [db executeUpdate:@"UPDATE t_account SET summary = summary + ? WHERE accountID = ?",@(money),@(aID)];
    [db close];
}

+ (void)resetMoneySummaryWithAccountID:(NSInteger)aID
{
    FMDatabase *db = [DatabaseTool sharedDataBase];
    if (![db open])
    {
        [db close];
        return;
    }
    
    [db executeUpdate:@"UPDATE t_account SET summary = 0 WHERE accountID = ?",@(aID)];
    [db close];
}


@end
