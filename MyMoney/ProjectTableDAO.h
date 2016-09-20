//
//  ProjectTableDAO.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/24.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"

@interface ProjectTableDAO : NSObject

+ (NSMutableArray *)getAllProject;
+ (NSMutableArray *)getRecentProject;
+ (void)updateUsedCountWithProjectID:(NSInteger)pID;

@end
