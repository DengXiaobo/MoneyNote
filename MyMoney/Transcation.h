//
//  Transcation.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/26.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transcation : NSObject

//CREATE TABLE "t_transcation" (transcationID integer PRIMARY KEY,money float,type integer,categoryName text,categoryPath text,accountPath text,memberID integer,businessID integer,projectID integer,remark text,accountBookID integer,t_timestamp integer, iconName text, imgName text)

@property (nonatomic, assign)NSInteger tID;
@property (nonatomic, assign)CGFloat tMoney;
@property (nonatomic, assign)NSInteger tType;
@property (nonatomic, copy)NSString *tCategoryName;
@property (nonatomic, copy)NSString *tCategoryPath;
@property (nonatomic, copy)NSString *tAccountPath;
@property (nonatomic, assign)NSInteger tMemberID;
@property (nonatomic, assign)NSInteger tBusinessID;
@property (nonatomic, assign)NSInteger tProjectID;
@property (nonatomic, copy)NSString *tRemark;
@property (nonatomic, assign)NSInteger tAccountBookID;
@property (nonatomic, assign)NSInteger tTimestamp;
@property (nonatomic, copy)NSString *tIconName;
@property (nonatomic, copy)NSString *tImgName;

@end
