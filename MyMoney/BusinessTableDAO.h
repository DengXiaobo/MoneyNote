//
//  BusinessTableDAO.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/24.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Business.h"

@interface BusinessTableDAO : NSObject

+ (NSMutableArray *)getAllBusiness;
+ (NSMutableArray *)getRecentBusiness;
+ (void)updateUsedCountWithBusinessID:(NSInteger)bID;

@end
