//
//  CategoryTableDAO.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/22.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryM.h"

typedef NS_ENUM(NSInteger, CategoryType)
{
    CategoryTypeExpend = 0,
    CategoryTypeIncome
};

@interface CategoryTableDAO : NSObject

+ (NSMutableArray *)getOneLevelCategoryWithType:(CategoryType)type;
+ (NSMutableArray *)getTwoLevelCategoryWithOneLevelID:(NSInteger)oneLevelID;

@end
