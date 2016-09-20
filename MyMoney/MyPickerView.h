//
//  MyPickerView.h
//  Demo
//
//  Created by Dengxiaobo on 16/6/22.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    PickerTypeNormal = 0, //普通
    PickerTypeImage,//图片
    PickerTypeOther//其他
}PickerType;

@class MyPickerView;
@protocol MyPickerViewDelegate <NSObject>

 @required
- (NSString *)pickerView:(MyPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (NSInteger)pickerView:(MyPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
- (void)pickerViewHidden:(MyPickerView *)pickerView;
@optional
- (UIImage *)pickerView:(MyPickerView *)pickerView viewForRow:(NSInteger)row;
- (NSString *)pickerView:(MyPickerView *)pickerView OtherForRow:(NSInteger)row;
- (void)pickerView:(MyPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end


@interface MyPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    
}
@property (nonatomic,copy) UIPickerView *pickerView;
@property (nonatomic,assign) id <MyPickerViewDelegate>delegate;
@property (nonatomic,assign) PickerType type;
- (void)reloadWithComponent:(NSInteger)component;
- (void)reloadAllComponents;
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;
@end
