//
//  MainTableViewCell.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/16.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_iconImageView release];
    [_timeLabel release];
    [_introLabel release];
    [_incomeLabel release];
    [_expendLabel release];
    [_writeBtn release];
    [super dealloc];
}
@end
