//
//  EditAccountBookViewController.h
//  MyMoney
//
//  Created by xuemeng on 16/6/22.
//  Copyright © 2016年 xuemeng. All rights reserved.
//

#import "SuperViewController.h"
#import "AccountBook.h"

typedef NS_ENUM(NSUInteger, UseType)
{
    UseTypeNew = 0,
    UseTypeEdit
};

@interface EditAccountBookViewController : SuperViewController<UICollectionViewDataSource, UICollectionViewDelegate>
{
    
    IBOutlet UITextField            *_nameTextField;
    IBOutlet UIImageView            *_coverImageView;
    IBOutlet UICollectionView       *_collectionView;
    NSArray                         *_titleArray;
    NSArray                         *_templateNameArray;
    NSInteger                       _currentTemplateIndex;// 1~6 六种面板
}

@property (nonatomic, assign)UseType useType;
@property (nonatomic, assign)NSInteger abType;// 0~6   共七种账本
@property (nonatomic, retain)AccountBook *accountBook;

- (IBAction)chooseCoverImageBtnClick:(id)sender;

@end
