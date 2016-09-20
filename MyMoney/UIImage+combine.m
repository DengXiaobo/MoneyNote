//
//  UIImage+combine.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/29.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "UIImage+combine.h"

@implementation UIImage (combine)

+ (UIImage *)combineImage:(UIImage *)image withString:(NSString *)str
{
    // 定义画布的大小 这里是原图片的大小
    CGSize size = CGSizeMake(image.size.width*[UIScreen mainScreen].scale, image.size.height*[UIScreen mainScreen].scale);
    // 初始化画布
    UIGraphicsBeginImageContext(size);
    
    // 图片要画多大 需要先定义一个rect
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    // 把图片按照指定的大小画到画布上
    [image drawInRect:rect];
    
    // 创建一个label
    UILabel *label = [[UILabel alloc] init];
    label.text = str;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:16*[UIScreen mainScreen].scale];
    
    // 把label画到画布上
    // label想画多大都可以改的，重新创建下面这个rect就行了
    [label drawTextInRect:CGRectMake(0, 3+3*[UIScreen mainScreen].scale, 32*[UIScreen mainScreen].scale, 30*[UIScreen mainScreen].scale)];
    [label release];
    
    // 获得画布上所画得内容
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 画图结束
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

@end
