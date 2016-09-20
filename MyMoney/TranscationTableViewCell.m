//
//  TranscationTableViewCell.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/22.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "TranscationTableViewCell.h"

@implementation TranscationTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_dateLabel release];
    [_weekLabel release];
    [_iconImageView release];
    [_nameLabel release];
    [_moneyLabel release];
    [super dealloc];
}
@end
