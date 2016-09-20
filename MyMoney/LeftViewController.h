//
//  LeftViewController.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/1.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
{
    IBOutlet UIImageView        *_abHeaderImageView;
    IBOutlet UILabel            *_abNameLabel;
    IBOutlet UIImageView        *_abSmallImageView;
    IBOutlet UICollectionView   *_abCollectionView;
    IBOutlet UIButton           *_editBtn;
    IBOutlet UIButton           *_finishBtn;
    NSInteger                   _currentItem;// 当前选中的账本
    BOOL                        _isEditing;
}

@property (nonatomic, retain)NSMutableArray *accountBookArray;

- (IBAction)addBtnClick:(id)sender;
- (IBAction)editBtnClick:(id)sender;

@end
