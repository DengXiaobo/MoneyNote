//
//  WriteUnitControl.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/16.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIControlType)
{
    UIControlTypeMoney = 0,
    UIControlTypeCategory,
    UIControlTypeAccount,
    UIControlTypeMember,
    UIControlTypeBusiness,
    UIControlTypeProject,
    UIControlTypeRemark
};

typedef NS_ENUM(NSInteger, UIControlStyle)
{
    UIControlStyleNotEditableAndShort = 0,
    UIControlStyleNotEditable,
    UIControlStyleEditable,
    UIControlStyleEditableAndCombine
    
};

@interface WriteUnitControl : UIControl

@property (nonatomic, assign)UIControlType controlType;
@property (nonatomic, assign)UIControlStyle controlStyle;
@property (nonatomic, retain)UILabel *nameLabel;
@property (nonatomic, retain)UILabel *contentLabel;
@property (nonatomic, retain)UITextField *contentTextField;

- (id)initWithType:(UIControlType)type style:(UIControlStyle)style;

@end
