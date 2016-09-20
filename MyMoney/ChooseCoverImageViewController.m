//
//  ChooseCoverImageViewController.m
//  MyMoney
//
//  Created by xuemeng on 16/6/23.
//  Copyright © 2016年 xuemeng. All rights reserved.
//

#import "ChooseCoverImageViewController.h"
#import "ChooseCoverImageCell.h"

@interface ChooseCoverImageViewController ()

@end

@implementation ChooseCoverImageViewController

#pragma mark -
#pragma mark lifeCycle

- (void)dealloc
{
    [_collectionView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavigationBarWithType:(NavBarTypeNotRoot | NavBarTypeString) leftItemTitleOrImageName:@"账本封面" leftAction:@selector(backBtnClick) centerTitle:nil rightItemTitleOrImageName:nil rightAction:nil];
    
    _currentIndex = [[self.lastAccountBook.abImageName substringWithRange:NSMakeRange(self.lastAccountBook.abImageName.length - 1, 1)] intValue] - 1;
    
    [_collectionView registerNib:[UINib nibWithNibName:@"ChooseCoverImageCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark delegate&datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (ChooseCoverImageCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseCoverImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.coverImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"AccountBookCover%ld",indexPath.row + 1]];
    
    cell.backgroundColor = (indexPath.row == _currentIndex) ? TABLEVIEW_BACKGROUND_COLOR : [UIColor whiteColor];
    cell.checkImageView.hidden = (indexPath.row == _currentIndex) ? NO : YES;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _currentIndex = indexPath.row;
    [_collectionView reloadData];
}



#pragma mark -
#pragma mark otherMethod

- (void)backBtnClick
{
    // 修改上一个界面的封面图片
    self.lastAccountBook.abImageName = [NSString stringWithFormat:@"AccountBookCover%ld",_currentIndex + 1];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
