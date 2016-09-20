//
//  TranscationTableViewCell.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/22.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TranscationTableViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *dateLabel;
@property (retain, nonatomic) IBOutlet UILabel *weekLabel;
@property (retain, nonatomic) IBOutlet UIImageView *iconImageView;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UILabel *moneyLabel;


@end
