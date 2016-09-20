//
//  MyPickerView.m
//  Demo
//
//  Created by Dengxiaobo on 16/6/22.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "MyPickerView.h"
#import <CoreText/CoreText.h>

@implementation MyPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        UIButton *hiddenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [hiddenBtn setTitle:@"V" forState:UIControlStateNormal];
        hiddenBtn.backgroundColor = [UIColor lightGrayColor];
        hiddenBtn.frame = CGRectMake(frame.size.width-60.0f, frame.size.height - 230.0f, 60.0f, 30.0f);
        [hiddenBtn addTarget:self action:@selector(hiddenPickerView) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:hiddenBtn];

        UIView *grayLine = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-200.0f, frame.size.width, 1)];
        grayLine.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:grayLine];
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, frame.size.height-200.0f, frame.size.width, 200.0f)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        [self addSubview:_pickerView];
        
    }
    return self;
}
- (void)dealloc{
    
    [_pickerView release];
    _pickerView = nil;
    self.delegate = nil;
    [super dealloc];
}
- (void)hiddenPickerView{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.frame;
        rect.origin.y += (200.0f+30.0f);
        self.frame = rect;
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(pickerViewHidden:)]) {
            [self.delegate pickerViewHidden:self];
        }
    }];
}
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated{
    [_pickerView selectRow:row inComponent:component animated:animated];
    
}
- (void)reloadAllComponents{
    [_pickerView reloadAllComponents];
}
- (void)reloadWithComponent:(NSInteger)component
{

    [_pickerView reloadComponent:component];
}
#pragma mark - UIPickerViewDataSource,UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.delegate pickerView:self numberOfRowsInComponent:component];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{

    return 60.0f;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = (UILabel *)view;
    if (!label) {
        label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 60.0f)] autorelease];
    }
    if (self.type == PickerTypeNormal || component == 0) {
        label.text = [self.delegate pickerView:self titleForRow:row forComponent:component];
        label.textAlignment = NSTextAlignmentCenter;
    }else if (self.type == PickerTypeImage){
        NSTextAttachment *attch = [[[NSTextAttachment alloc] init] autorelease];
        attch.image = [self.delegate pickerView:self viewForRow:row];
        attch.bounds = CGRectMake(0, -10, 40, 40);
        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
        NSMutableAttributedString *attri =     [[NSMutableAttributedString alloc] initWithString:[self.delegate pickerView:self titleForRow:row forComponent:component]];

        [string appendAttributedString:attri];

        label.attributedText = string;
    }else if (self.type == PickerTypeOther){
        NSString *title = [self.delegate pickerView:self titleForRow:row forComponent:component];
        NSString *other = [self.delegate pickerView:self OtherForRow:row];
        
        NSString *string = [NSString stringWithFormat:@"%@\n%@",title,other];
        
        NSMutableAttributedString *attributed = [[[NSMutableAttributedString alloc] initWithString:string] autorelease];
        [attributed addAttribute:(NSString *)NSForegroundColorAttributeName
                           value:(id)[UIColor blackColor].CGColor
                           range:NSMakeRange(0, title.length)];
        [attributed addAttribute:(NSString *)NSForegroundColorAttributeName
                           value:(id)[UIColor lightGrayColor].CGColor
                           range:NSMakeRange(title.length+1, other.length)];
        
        [attributed addAttribute: NSFontAttributeName value: [UIFont fontWithName: @"Helvetica" size: 20]
                           range: NSMakeRange(0, title.length)];
        [attributed addAttribute: NSFontAttributeName value: [UIFont fontWithName: @"Helvetica" size: 12]
                           range: NSMakeRange(title.length+1, other.length)];
        
        label.textAlignment = NSTextAlignmentRight;
        label.attributedText = attributed;
        
        label.numberOfLines = 0;
    }

    return label;
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([self.delegate respondsToSelector:@selector(pickerView:didSelectRow:inComponent:)]) {
        [self.delegate pickerView:self didSelectRow:row inComponent:component];
    }
}
@end