//
//  WriteUnitControl.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/16.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "WriteUnitControl.h"

@implementation WriteUnitControl

- (void)dealloc
{
    [_nameLabel release];
    [_contentLabel release];
    [super dealloc];
}

- (id)initWithType:(UIControlType)type style:(UIControlStyle)style
{
    self = [super init];
    if (self)
    {
        self.controlType = type;
        self.controlStyle = style;
        self.backgroundColor = [UIColor whiteColor];
        
        NSArray *nameArray = @[@"分类",@"账户",@"成员",@"商家",@"项目"];
        NSArray *tempContentArray = @[@"衣服饰品 > 衣服裤子",@"现金(CNY)",@"(无成员)",@"(无商家)",@"(无项目)"];
        
        // 自身大小考虑是否是合并的
        if (self.controlStyle != UIControlStyleEditableAndCombine)
        {
            self.frame = CGRectMake(0, 0, SCREENWIDTH, CONTROLHEIGHT);
        }
        else
        {
            self.frame = CGRectMake(0, 0, SCREENWIDTH / 2, CONTROLHEIGHT);
        }
        
        // 内部的label
        if (self.controlType == UIControlTypeMoney)
        {
            //如果是金额金额类型
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 40)];
            label.text = @"0.00";
            label.textColor = MONEY_OUT_COLOR;
            label.font = [UIFont systemFontOfSize:25];
            [self addSubview:label];
            self.contentLabel = label;
            [label release];
        }
        else if (self.controlType != UIControlTypeRemark)
        {
            // 常规的 两个label的
            UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 15)];
            topLabel.text = nameArray[self.controlType - 1];
            topLabel.textColor = [UIColor lightGrayColor];
            topLabel.font = [UIFont systemFontOfSize:12];
            [self addSubview:topLabel];
            self.nameLabel = topLabel;
            [topLabel release];
            
            UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 25, 200, 25)];
            bottomLabel.text = tempContentArray[self.controlType - 1];
            bottomLabel.textColor = [UIColor blackColor];
            [self addSubview:bottomLabel];
            self.contentLabel = bottomLabel;
            [bottomLabel release];
        }
        else
        {
            // 如果是备注类型
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 200, 40)];
            textField.userInteractionEnabled = NO;
            textField.placeholder = @"备注...";
            textField.returnKeyType = UIReturnKeyDone;
            [self addSubview:textField];
            self.contentTextField = textField;
            [textField release];
        }
        
        // 底部线条
        UILabel *line = [[UILabel alloc] init];
        
        if (self.controlStyle == UIControlStyleNotEditableAndShort)
        {
            line.frame = CGRectMake(20, CONTROLHEIGHT - 1, SCREENWIDTH - 100, 1);
        }
        else if (self.controlStyle == UIControlStyleEditableAndCombine)
        {
            line.frame = CGRectMake(20, CONTROLHEIGHT - 1, SCREENWIDTH / 2 - 40, 1);
        }
        else
        {
             line.frame = CGRectMake(20, CONTROLHEIGHT - 1, SCREENWIDTH - 40, 1);
        }
        line.backgroundColor = LINECOLOR;
        [self addSubview:line];
        [line release];
        
        // 是否要关闭按钮
        if (self.controlStyle == UIControlStyleEditable || self.controlStyle == UIControlStyleEditableAndCombine)
        {
//            UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            closeBtn.frame = CGRectMake(self.frame.size.width - 30, 25, 10, 10);
//            [closeBtn setBackgroundImage:[UIImage imageNamed:@"TransferCancelButton"] forState:UIControlStateNormal];
//            [self addSubview:closeBtn];
        }
    }

    return self;
}



@end
