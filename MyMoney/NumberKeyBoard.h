//
//  NumberKeyBoard.h
//  Demo
//
//  Created by Dengxiaobo on 16/6/19.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    KeyBoardTypeExpend = 0, //支出
    KeyBoardTypeIncome,//收入
    KeyBoardTypeOther//其他
}KeyBoardType;

@protocol NumberKeyBoardDelegate;

@interface NumberKeyBoard : UIView
{
    NSMutableString *inputString;
}
@property (nonatomic,assign) KeyBoardType type;
@property (nonatomic,assign) id <NumberKeyBoardDelegate>delegate;
@end


@protocol NumberKeyBoardDelegate <NSObject>

- (void)keyBoardTypeChanged:(KeyBoardType)key;
- (void)keyBoardValueChanged:(NSString *)value;
- (void)keyBoardHidden:(NumberKeyBoard *)keyBoard;

@end
