//
//  AccountBookCell.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/22.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "AccountBookCell.h"

@implementation AccountBookCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)dealloc {
    [_abCoverImageView release];
    [_abNameLabel release];
    [_abSelectImageView release];
    [_editView release];
    [_deleteBtn release];
    [_editBtn release];
    [super dealloc];
}
@end
