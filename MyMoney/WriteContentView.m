//
//  WriteContentView.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/16.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//


#import "WriteContentView.h"
#import "WriteUnitControl.h"

@implementation WriteContentView

- (void)dealloc
{
    [_controlArray release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame vc:(UIViewController *)vc action:(SEL)action
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = LINECOLOR;
        
        // 保存白块的数组
        _controlArray = [[NSMutableArray alloc] init];
        
        // 样式数组
        NSArray *styleArray = @[@(UIControlStyleNotEditableAndShort),@(UIControlStyleNotEditable),@(UIControlStyleNotEditable),@(UIControlStyleEditable),@(UIControlStyleEditableAndCombine),@(UIControlStyleEditableAndCombine),@(UIControlStyleNotEditable)];
        
        // 白块
        int columnNumber = 0;
        BOOL isHaveCombine = NO;
        for (int i = 0; i < styleArray.count; i++)
        {
            int currentStyle = [styleArray[i] intValue];
            WriteUnitControl *control = [[WriteUnitControl alloc] initWithType:i style:currentStyle];
            
            if (currentStyle != UIControlStyleEditableAndCombine)
            {
                control.frame = CGRectMake(0, CONTROLHEIGHT * columnNumber, SCREENWIDTH, 60);
                columnNumber++;
            }
            else
            {
                if (!isHaveCombine)
                {
                    control.frame = CGRectMake(0, CONTROLHEIGHT * columnNumber, SCREENWIDTH / 2, 60);
                    isHaveCombine = YES;
                }
                else
                {
                    control.frame = CGRectMake(SCREENWIDTH / 2, CONTROLHEIGHT * columnNumber, SCREENWIDTH / 2, 60);
                    isHaveCombine = NO;
                    columnNumber++;
                }
            }
            
            [control addTarget:vc action:action forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:control];
            [_controlArray addObject:control];
            [control release];
        }
    }
    return self;
}


@end
