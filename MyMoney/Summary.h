//
//  Summary.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/29.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Summary : NSObject

@property (nonatomic, assign)DateType sType;
@property (nonatomic, copy)NSString *sIconName;
@property (nonatomic, copy)NSString *sTime;
@property (nonatomic, copy)NSString *sIntro;
@property (nonatomic, assign)float sIncome;
@property (nonatomic, assign)float sExpend;

@end
