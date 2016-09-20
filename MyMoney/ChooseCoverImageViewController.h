//
//  ChooseCoverImageViewController.h
//  MyMoney
//
//  Created by xuemeng on 16/6/23.
//  Copyright © 2016年 xuemeng. All rights reserved.
//

#import "SuperViewController.h"
#import "AccountBook.h"

@interface ChooseCoverImageViewController : SuperViewController<UICollectionViewDataSource, UICollectionViewDelegate>
{
    IBOutlet UICollectionView   *_collectionView;
    NSInteger                   _currentIndex;
}
@property (nonatomic, retain)AccountBook *lastAccountBook;

@end
