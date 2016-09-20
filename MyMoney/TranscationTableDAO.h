//
//  TranscationTableDAO.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/24.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Transcation.h"
#import "Summary.h"

@interface TranscationTableDAO : NSObject

+ (void)addTranscation:(Transcation *)transcation;
+ (Summary *)getSummaryWithTimestamp:(NSTimeInterval)timestamp accountBookID:(NSInteger)abID;
+ (NSMutableArray *)getTranscationsWithTimestamp:(NSTimeInterval)timestamp accountBookID:(NSInteger)abID;
+ (void)deleteTranscation:(Transcation *)transcation;
@end
