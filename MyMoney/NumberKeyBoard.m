//
//  NumberKeyBoard.m
//  Demo
//
//  Created by Dengxiaobo on 16/6/19.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "NumberKeyBoard.h"
#define KEYBOARD_COLOR       [UIColor colorWithRed:(90 / 255.0) green:(92 / 255.0) blue:(95 / 255.0) alpha:1]

#define KEYBOARD_HEIGHT 218.0f

@implementation NumberKeyBoard
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        inputString = [[NSMutableString alloc] initWithFormat:@"0"];
        
        NSLog(@"%f",self.frame.size.width);
        //        0.618
        float hegiht = frame.size.height;
        
        UIButton *hiddenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [hiddenBtn setTitle:@"V" forState:UIControlStateNormal];
        hiddenBtn.frame = CGRectMake(frame.size.width-60.0f, hegiht - KEYBOARD_HEIGHT-30.0f, 60.0f, 30.0f);
        [hiddenBtn addTarget:self action:@selector(hiddenKeyBoard) forControlEvents:UIControlEventTouchUpInside];
        [self grayBtn:hiddenBtn];
        [self addSubview:hiddenBtn];
        
        
        UIButton *expendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        expendBtn.frame = CGRectMake(0.0f, hegiht - KEYBOARD_HEIGHT, 44.0f, KEYBOARD_HEIGHT/3);
        [self grayBtn:expendBtn];
        [expendBtn addTarget:self action:@selector(moneyTypeChanged:) forControlEvents:UIControlEventTouchUpInside];
        [expendBtn setTitle:@"支出" forState:UIControlStateNormal];
        expendBtn.tag = 100+KeyBoardTypeExpend;
        [expendBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self addSubview:expendBtn];
        
        UIButton *incomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        incomeBtn.frame = CGRectMake(0.0f, hegiht - KEYBOARD_HEIGHT/3*2, 44.0f, KEYBOARD_HEIGHT/3);
        [incomeBtn setTitle:@"收入" forState:UIControlStateNormal];
        [self grayBtn:incomeBtn];
        [incomeBtn addTarget:self action:@selector(moneyTypeChanged:) forControlEvents:UIControlEventTouchUpInside];
        incomeBtn.tag = 100+KeyBoardTypeIncome;
        [self addSubview:incomeBtn];
        
        UIButton *transferBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        transferBtn.frame = CGRectMake(0.0f, hegiht - KEYBOARD_HEIGHT/3, 44.0f, KEYBOARD_HEIGHT/3);
        [transferBtn setTitle:@"转账" forState:UIControlStateNormal];
        [self grayBtn:transferBtn];
        [transferBtn addTarget:self action:@selector(moneyTypeChanged:) forControlEvents:UIControlEventTouchUpInside];
        transferBtn.tag = 100+KeyBoardTypeOther;
        [self addSubview:transferBtn];
        
        NSArray *arr = @[@"7",@"8",@"9",@"-",@"4",@"5",@"6",@"+",@"1",@"2",@"3",[NSNull null],@".",@"0",@"X",@"ok"];
        float itemWidth = (frame.size.width - 44.0f)/4;
        float itemHeight = KEYBOARD_HEIGHT/ 4;
        for (int i = 0 ; i < arr.count; i++)
        {
            if ([arr[i] isKindOfClass:[NSNull class]]) {
                continue;
            }
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:arr[i] forState:UIControlStateNormal];
            button.frame = CGRectMake(44.0f + i % 4 * itemWidth, hegiht - KEYBOARD_HEIGHT+ i / 4 * itemHeight, itemWidth, itemHeight);
            button.tag = i+1000;
            [button addTarget:self action:@selector(onClickButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [self grayBtn:button];
            [self addSubview:button];
            
            if (i == arr.count - 1) {
                button.frame = CGRectMake(44.0f + 3 * itemWidth, hegiht - KEYBOARD_HEIGHT+ 2 * itemHeight, itemWidth, itemHeight *2);
            }
            
        }
        
    }
    return self;
}

- (void)grayBtn:(UIButton *)button{
    
    button.backgroundColor = KEYBOARD_COLOR;
    button.layer.borderColor = [UIColor blackColor].CGColor;
    button.layer.borderWidth = 1;
    button.titleLabel.font = [UIFont systemFontOfSize:12];
}
#pragma mark - click
- (void)hiddenKeyBoard{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.frame;
        rect.origin.y += (KEYBOARD_HEIGHT+30.0f);
        self.frame = rect;
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(keyBoardHidden:)]) {
            [self.delegate keyBoardHidden:self];
        }
    }];
}
- (void)moneyTypeChanged:(UIButton *)sender{
    if (self.type == (sender.tag - 100)) {
        return;
    }else{
        self.type = (int)(sender.tag - 100);
    }
    
}
- (void)setType:(KeyBoardType)type
{
    UIButton *button = [self viewWithTag:_type+100];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _type = type;
    button = [self viewWithTag:_type+100];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    if([self.delegate respondsToSelector:@selector(keyBoardTypeChanged:)]){
        [self.delegate keyBoardTypeChanged:_type];
    }
}
- (void)onClickButton:(UIButton *)sender{
    
    UIButton *button = (UIButton *)sender;
//    NSLog(@"this button is %@",button.titleLabel.text);
    NSString *operator = button.titleLabel.text;
 
    if ([operator isEqual:@"+"]||
        [operator isEqual:@"-"] )
    {
        NSLog(@"运算符 + -");
    }
    else if([operator isEqual:@"="])
    {
        NSLog(@"运算符 =");
    }
    else if([operator isEqual:@"X"])
    {
        [inputString deleteCharactersInRange:NSMakeRange(inputString.length-1, 1)];
        if (inputString.length <1) {
            [inputString appendString:@"0"];
        }
        
    }
    else if([operator isEqual:@"ok"])
    {
    }
    else if([operator isEqual:@"."])
    {
        NSRange range = [inputString rangeOfString:operator];
        if (range.location == NSNotFound) {
            [inputString appendString:operator];
        }else{
            return;
        }
    }else{
        NSRange range = [inputString rangeOfString:@"."];
        
        if ([inputString isEqualToString:@"0"]) {
            [inputString setString:operator];
        }else if (range.location != NSNotFound && inputString.length - range.location > 2) {
            return;
        }
        else
        {
            [inputString appendString:operator];
        }
    }
    if ([self.delegate respondsToSelector:@selector(keyBoardValueChanged:)]) {
        NSRange range = [inputString rangeOfString:@"."];

        if (range.location == NSNotFound) {
            
            [self.delegate keyBoardValueChanged:[inputString stringByAppendingString:@".00"]];
        }else if(inputString.length - range.location   == 1){
            [self.delegate keyBoardValueChanged:[inputString stringByAppendingString:@"00"]];
        }else if(inputString.length - range.location   == 2){
            [self.delegate keyBoardValueChanged:[inputString stringByAppendingString:@"0"]];
        }else{
            [self.delegate keyBoardValueChanged:inputString];
        }
        

        
    }
    



    
}
@end
