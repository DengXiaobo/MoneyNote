//
//  ProjectTableDAO.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/24.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "ProjectTableDAO.h"
#import "DatabaseTool.h"

@implementation ProjectTableDAO

//CREATE TABLE "t_project" (projectID integer PRIMARY KEY,name text,usedCount integer)

+ (NSMutableArray *)getAllProject
{
    FMDatabase *db = [DatabaseTool sharedDataBase];
    if (![db open])
    {
        [db close];
        return nil;
    }
    
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_project"];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while ([rs next])
    {
        Project *project = [[Project alloc] init];
        project.pID = [rs intForColumn:@"projectID"];
        project.pName = [rs stringForColumn:@"name"];
        project.pUsedCount = [rs intForColumn:@"usedCount"];
        [array addObject:project];
        [project release];
    }
    [rs close];
    [db close];
    
    return [array autorelease];
}

+ (NSMutableArray *)getRecentProject
{
    FMDatabase *db = [DatabaseTool sharedDataBase];
    if (![db open])
    {
        [db close];
        return nil;
    }
    
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_project WHERE usedCount > 0"];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while ([rs next])
    {
        Project *project = [[Project alloc] init];
        project.pID = [rs intForColumn:@"projectID"];
        project.pName = [rs stringForColumn:@"name"];
        project.pUsedCount = [rs intForColumn:@"usedCount"];
        [array addObject:project];
        [project release];
    }
    [rs close];
    [db close];
    
    return [array autorelease];
}

+ (void)updateUsedCountWithProjectID:(NSInteger)pID
{
    FMDatabase *db = [DatabaseTool sharedDataBase];
    if (![db open])
    {
        [db close];
        return;
    }
    
    [db executeUpdate:@"UPDATE t_project SET usedCount = usedCount + 1 WHERE projectID = ?",@(pID)];
    [db close];
}

@end
