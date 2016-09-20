//
//  WriteViewController.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/16.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "SuperViewController.h"
#import "NumberKeyBoard.h"
#import "WriteUnitControl.h"
#import "MyPickerView.h"
#import "Transcation.h"

@interface WriteViewController : SuperViewController<UIScrollViewDelegate, NumberKeyBoardDelegate,MyPickerViewDelegate, UITextFieldDelegate>
{
    NSMutableArray          *_typeNameArray;
    UILabel                 *_bottomLine;
    UIScrollView            *_topScrollView;
    UIScrollView            *_bottomScrollView;
    WriteUnitControl        *_currentControl;
    UIView                  *_currentShowView;
}
@property (nonatomic, retain)NSMutableArray *categoryLeftArray;
@property (nonatomic, retain)NSMutableArray *categoryRightArray;
@property (nonatomic, retain)NSMutableArray *accountLeftArray;
@property (nonatomic, retain)NSMutableArray *accountRightArray;
@property (nonatomic, retain)NSArray *titleLeftArray;// 成员 商家 项目 左边公用
@property (nonatomic, retain)NSMutableArray *memberRightArray;
@property (nonatomic, retain)NSMutableArray *businessRightArray;
@property (nonatomic, retain)NSMutableArray *projectRightArray;
@property (nonatomic, retain)Transcation *tempTranscation;

@end
