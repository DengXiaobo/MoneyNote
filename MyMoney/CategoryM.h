//
//  CategoryM.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/24.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryM : NSObject

@property (nonatomic, assign)NSInteger cID;
@property (nonatomic, copy)NSString *cName;
@property (nonatomic, copy)NSString *cPath;
@property (nonatomic, copy)NSString *cIconName;
@property (nonatomic, assign)NSInteger cType;

@end
