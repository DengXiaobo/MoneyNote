//
//  AccountBookTemplateCell.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/22.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "AccountBookTemplateCell.h"

@implementation AccountBookTemplateCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)dealloc {
    [_templateImageView release];
    [_ridaoImageView release];
    [_templateName release];
    [super dealloc];
}
@end
