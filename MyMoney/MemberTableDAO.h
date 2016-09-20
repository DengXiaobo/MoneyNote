//
//  MemberTableDAO.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/24.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Member.h"

@interface MemberTableDAO : NSObject

+ (NSMutableArray *)getAllMember;
+ (NSMutableArray *)getRecentMember;
+ (void)updateUsedCountWithMemberID:(NSInteger)mID;

@end
