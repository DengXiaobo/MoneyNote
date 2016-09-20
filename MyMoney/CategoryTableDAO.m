//
//  CategoryTableDAO.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/22.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "CategoryTableDAO.h"
#import "DatabaseTool.h"

@implementation CategoryTableDAO

//CREATE TABLE "t_category" (categoryID integer PRIMARY KEY,name text,path text,iconName text,type integer)

+ (NSMutableArray *)getOneLevelCategoryWithType:(CategoryType)type
{
    FMDatabase *db = [DatabaseTool sharedDataBase];
    if (![db open])
    {
        [db close];
        return nil;
    }
    
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_category WHERE type = ? AND path NOT LIKE '%/%' ",@(type)];

    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while ([rs next])
    {
        CategoryM *category = [[CategoryM alloc] init];
        category.cID = [rs intForColumn:@"categoryID"];
        category.cName = [rs stringForColumn:@"name"];
        category.cPath = [rs stringForColumn:@"path"];
        category.cIconName = [rs stringForColumn:@"iconName"];
        category.cType = [rs intForColumn:@"type"];
        [array addObject:category];
        [category release];
    }
    [rs close];
    [db close];
    
    return [array autorelease];
}

+ (NSMutableArray *)getTwoLevelCategoryWithOneLevelID:(NSInteger)oneLevelID
{
    FMDatabase *db = [DatabaseTool sharedDataBase];
    if (![db open])
    {
        [db close];
        return nil;
    }
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_category WHERE path LIKE '%ld/%%'",oneLevelID];
    
    FMResultSet *rs = [db executeQuery:sql];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while ([rs next])
    {
        CategoryM *category = [[CategoryM alloc] init];
        category.cID = [rs intForColumn:@"categoryID"];
        category.cName = [rs stringForColumn:@"name"];
        category.cPath = [rs stringForColumn:@"path"];
        category.cIconName = [rs stringForColumn:@"iconName"];
        category.cType = [rs intForColumn:@"type"];
        [array addObject:category];
        [category release];
    }
    [rs close];
    [db close];
    
    return [array autorelease];
}



@end
