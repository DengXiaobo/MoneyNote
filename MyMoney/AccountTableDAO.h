//
//  AccountTableDAO.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/24.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface AccountTableDAO : NSObject

+ (NSMutableArray *)getOneLevelAccount;
+ (NSMutableArray *)getTwoLevelAccountWithOneLevelID:(NSInteger)oneLevelID;
+ (void)updateMoney4SummaryWithAccountID:(NSInteger)aID money:(CGFloat)money;
+ (void)resetMoneySummaryWithAccountID:(NSInteger)aID;

@end
