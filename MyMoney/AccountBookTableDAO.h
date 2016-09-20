//
//  AccountBookTableDAO.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/22.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountBook.h"

@interface AccountBookTableDAO : NSObject

+ (NSMutableArray *)getAllAccountBook;
+ (void)addAccountBook:(AccountBook *)accountBook;
+ (void)deleteAccountBook:(AccountBook *)accountBook;
+ (void)updateAccountBook:(AccountBook *)accountBook;

@end
