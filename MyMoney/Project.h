//
//  Project.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/25.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Project : NSObject

@property (nonatomic, assign)NSInteger pID;
@property (nonatomic, copy)NSString *pName;
@property (nonatomic, assign)NSInteger pUsedCount;

@end
