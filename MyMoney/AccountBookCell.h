//
//  AccountBookCell.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/22.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountBookCell : UICollectionViewCell

@property (retain, nonatomic) IBOutlet UIImageView *abCoverImageView;
@property (retain, nonatomic) IBOutlet UILabel *abNameLabel;
@property (retain, nonatomic) IBOutlet UIImageView *abSelectImageView;
@property (retain, nonatomic) IBOutlet UIView *editView;
@property (retain, nonatomic) IBOutlet UIButton *deleteBtn;
@property (retain, nonatomic) IBOutlet UIButton *editBtn;



@end
