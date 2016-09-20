//
//  MainTableViewCell.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/16.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewCell : UITableViewCell

// cell0
@property (retain, nonatomic) IBOutlet UIButton *writeBtn;

// cell1
@property (retain, nonatomic) IBOutlet UIImageView *iconImageView;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet UILabel *introLabel;
@property (retain, nonatomic) IBOutlet UILabel *incomeLabel;
@property (retain, nonatomic) IBOutlet UILabel *expendLabel;


@end
