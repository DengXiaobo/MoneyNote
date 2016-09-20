//
//  Account.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/24.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject

@property (nonatomic, assign)NSInteger aID;
@property (nonatomic, copy)NSString *aName;
@property (nonatomic, copy)NSString *aPath;
@property (nonatomic, assign)double aSummary;

@end
