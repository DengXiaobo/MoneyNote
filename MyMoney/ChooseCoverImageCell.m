//
//  ChooseCoverImageCell.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/23.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "ChooseCoverImageCell.h"

@implementation ChooseCoverImageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)dealloc {
    [_coverImageView release];
    [_checkImageView release];
    [super dealloc];
}
@end
