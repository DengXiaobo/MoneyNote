//
//  TranscationTableDAO.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/24.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "TranscationTableDAO.h"
#import "DatabaseTool.h"

@implementation TranscationTableDAO

//CREATE TABLE "t_transcation" (transcationID integer PRIMARY KEY,money float,type integer,categoryName text,categoryPath text,accountPath text,memberID integer,businessID integer,projectID integer,remark text,accountBookID integer,t_timestamp integer, iconName text, imgName text)

+ (void)addTranscation:(Transcation *)transcation
{
    FMDatabase *db = [DatabaseTool sharedDataBase];
    if (![db open])
    {
        [db close];
        return;
    }
    
    [db executeUpdate:@"INSERT INTO t_transcation (money,type,categoryName,categoryPath,accountPath,memberID,businessID,projectID,remark,accountBookID,t_timestamp,imgName,iconName) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)",@(transcation.tMoney),@(transcation.tType),transcation.tCategoryName,transcation.tCategoryPath,transcation.tAccountPath,@(transcation.tMemberID),@(transcation.tBusinessID),@(transcation.tProjectID),transcation.tRemark,@(transcation.tAccountBookID),@(transcation.tTimestamp),transcation.tImgName,transcation.tIconName];
    [db close];
}

+ (Summary *)getSummaryWithTimestamp:(NSTimeInterval)timestamp accountBookID:(NSInteger)abID
{
    FMDatabase *db = [DatabaseTool sharedDataBase];
    if (![db open])
    {
        [db close];
        return nil;
    }
    
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_transcation WHERE t_timestamp > ? AND accountBookID = ?",@(timestamp),@(abID)];
    
    Summary *summary = [[Summary alloc] init];
    
    while ([rs next])
    {
        if ([rs intForColumn:@"type"] == 1)
        {
            // 收入
            summary.sIncome += [rs intForColumn:@"money"];
        }
        else
        {
            // 支出
            summary.sExpend += [rs intForColumn:@"money"];
        }
    }
    [rs close];
    [db close];
    
    return [summary autorelease];
}

+ (NSMutableArray *)getTranscationsWithTimestamp:(NSTimeInterval)timestamp accountBookID:(NSInteger)abID
{
    FMDatabase *db = [DatabaseTool sharedDataBase];
    if (![db open])
    {
        [db close];
        return nil;
    }
    
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_transcation WHERE t_timestamp > ? AND accountBookID = ? ORDER BY transcationID DESC",@(timestamp),@(abID)];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while ([rs next])
    {
        Transcation *transcation = [[Transcation alloc] init];
        transcation.tID = [rs intForColumn:@"transcationID"];
        transcation.tMoney = [rs doubleForColumn:@"money"];
        transcation.tType = [rs intForColumn:@"type"];
        transcation.tCategoryName = [rs stringForColumn:@"categoryName"];
        transcation.tCategoryPath = [rs stringForColumn:@"categoryPath"];
        transcation.tAccountPath = [rs stringForColumn:@"accountPath"];
        transcation.tMemberID = [rs intForColumn:@"memberID"];
        transcation.tBusinessID = [rs intForColumn:@"businessID"];
        transcation.tProjectID = [rs intForColumn:@"projectID"];
        transcation.tRemark = [rs stringForColumn:@"remark"];
        transcation.tAccountBookID = [rs intForColumn:@"accountBookID"];
        transcation.tTimestamp = [rs intForColumn:@"t_timestamp"];
        transcation.tImgName = [rs stringForColumn:@"imgName"];
        transcation.tIconName = [rs stringForColumn:@"iconName"];
        [array addObject:transcation];
        [transcation release];
    }
    [rs close];
    [db close];
    
    return [array autorelease];
}

+ (void)deleteTranscation:(Transcation *)transcation
{
    FMDatabase *db = [DatabaseTool sharedDataBase];
    if (![db open])
    {
        [db close];
        return;
    }
    
    [db executeUpdate:@"DELETE FROM t_transcation WHERE transcationID = ?",@(transcation.tID)];
    [db close];
}

@end
