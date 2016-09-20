//
//  AccountBookTableDAO.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/22.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "AccountBookTableDAO.h"
#import "DatabaseTool.h"

@implementation AccountBookTableDAO

//CREATE TABLE "t_accountBook" (accountBookID integer PRIMARY KEY,name text,imgName text,homeImgName text,type integer)

+ (NSMutableArray *)getAllAccountBook
{
    FMDatabase *db = [DatabaseTool sharedDataBase];
    if (![db open])
    {
        [db close];
        return nil;
    }
    
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_accountBook"];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while ([rs next])
    {
        AccountBook *accountBook = [[AccountBook alloc] init];
        accountBook.abID = [rs intForColumn:@"accountBookID"];
        accountBook.abName = [rs stringForColumn:@"name"];
        accountBook.abImageName = [rs stringForColumn:@"imgName"];
        accountBook.abHomeImageName = [rs stringForColumn:@"homeImgName"];
        accountBook.abType = [rs intForColumn:@"type"];
        [array addObject:accountBook];
        [accountBook release];
    }
    [rs close];
    [db close];
    
    return [array autorelease];
}

+ (void)addAccountBook:(AccountBook *)accountBook
{
    FMDatabase *db = [DatabaseTool sharedDataBase];
    if (![db open])
    {
        [db close];
        return;
    }
    
    [db executeUpdate:@"INSERT INTO t_accountBook (name,imgName,homeImgName,type) VALUES (?,?,?,?)",accountBook.abName,accountBook.abImageName,accountBook.abHomeImageName,@(accountBook.abType)];
    [db close];
}

+ (void)deleteAccountBook:(AccountBook *)accountBook
{
    FMDatabase *db = [DatabaseTool sharedDataBase];
    if (![db open])
    {
        [db close];
        return;
    }
    
    [db executeUpdate:@"DELETE FROM t_accountBook WHERE accountBookID = ?",@(accountBook.abID)];
    [db close];
}

+ (void)updateAccountBook:(AccountBook *)accountBook
{
    FMDatabase *db = [DatabaseTool sharedDataBase];
    if (![db open])
    {
        [db close];
        return;
    }
    
    [db executeUpdate:@"UPDATE t_accountBook SET name = ?, imgName = ?, homeImgName = ?, type = ? WHERE accountBookID = ?",accountBook.abName,accountBook.abImageName,accountBook.abHomeImageName,@(accountBook.abType),@(accountBook.abID)];
    [db close];
}

@end
