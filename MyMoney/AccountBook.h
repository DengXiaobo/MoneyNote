//
//  AccountBook.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/22.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountBook : NSObject

@property (nonatomic, assign)NSInteger abID;
@property (nonatomic, copy)NSString *abName;
@property (nonatomic, copy)NSString *abImageName;
@property (nonatomic, copy)NSString *abHomeImageName;
@property (nonatomic, assign)NSInteger abType;

@end
