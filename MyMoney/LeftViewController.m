//
//  LeftViewController.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/1.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "LeftViewController.h"
#import "AccountBookCell.h"
#import "AccountBookTableDAO.h"
#import "AddAccountBookViewController.h"
#import "EditAccountBookViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

#pragma mark -
#pragma mark lifeCycle

- (void)dealloc
{
    [_abNameLabel release];
    [_abSmallImageView release];
    [_abCollectionView release];
    [_editBtn release];
    [_finishBtn release];
    [_abHeaderImageView release];
    [_accountBookArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _abHeaderImageView.layer.cornerRadius = 20;
    _abHeaderImageView.clipsToBounds = YES;
    
    [_abCollectionView registerNib:[UINib nibWithNibName:@"AccountBookCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.accountBookArray = [AccountBookTableDAO getAllAccountBook];
    
    // 找到默认选中的账本 是第几个
    for (AccountBook *ab in self.accountBookArray)
    {
        if (ab.abID == [MoneySingleton sharedMoneySingleton].defaultAccountBookID)
        {
            
            _currentItem = [self.accountBookArray indexOfObject:ab];
        }
    }
    
    [_abCollectionView reloadData];
    
    [self updateCurrentAccountBookInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark delegate&datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.accountBookArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AccountBookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    AccountBook *accountBook = [self.accountBookArray objectAtIndex:indexPath.row];
    
    cell.abCoverImageView.image = [UIImage imageNamed:accountBook.abImageName];
    cell.abNameLabel.text = accountBook.abName;
    
    // 编辑状态
    if (_isEditing == YES)
    {
        cell.abSelectImageView.hidden = YES;
        cell.editView.hidden = NO;
        [cell.editBtn addTarget:self action:@selector(accountBookEditBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.deleteBtn addTarget:self action:@selector(accountBookDeleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        cell.abSelectImageView.hidden = (indexPath.row == _currentItem) ? NO : YES;
        cell.editView.hidden = YES;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isEditing == NO)
    {
        _currentItem = (int)indexPath.row;
        [_abCollectionView reloadData];
        
        // 更新账本相关信息
        [self updateCurrentAccountBookInfo];
        
        // 0.2秒后显示主界面
        [self performSelector:@selector(showMainController) withObject:nil afterDelay:.2];
    }
}

#pragma mark -
#pragma mark otherMethod

- (void)showMainController
{
    MoneySingleton *singleton = [MoneySingleton sharedMoneySingleton];
    [singleton.menuController showRootController:YES];
}

- (IBAction)addBtnClick:(id)sender
{
    AddAccountBookViewController *addABViewController = [[AddAccountBookViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:addABViewController];
    nav.navigationBar.hidden = YES;
    [addABViewController release];
    
    MoneySingleton *singleton = [MoneySingleton sharedMoneySingleton];
    [singleton.menuController presentViewController:nav animated:YES completion:nil];
    [nav release];
}

- (IBAction)editBtnClick:(id)sender
{
    _editBtn.hidden = !_editBtn.hidden;
    _finishBtn.hidden = !_finishBtn.hidden;
    _isEditing = !_isEditing;
    [_abCollectionView reloadData];
}

- (void)updateCurrentAccountBookInfo
{
    // 当前账本
    AccountBook *currentAccountBook = [self.accountBookArray objectAtIndex:_currentItem];
    _abNameLabel.text = currentAccountBook.abName;
    _abSmallImageView.image = [UIImage imageNamed:currentAccountBook.abImageName];
    
    // 把当前账本的主页图片 和 账本id 保存到单例类中
    [MoneySingleton sharedMoneySingleton].defaultAccountBookImageName = currentAccountBook.abHomeImageName;
    [MoneySingleton sharedMoneySingleton].defaultAccountBookID = currentAccountBook.abID;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:AccountBookChangedNotification object:nil];
}

- (void)accountBookDeleteBtnClick:(UIButton *)btn
{
    if (self.accountBookArray.count == 1)
    {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"最后一个账本不能删除哦" preferredStyle:UIAlertControllerStyleAlert];
        [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [[MoneySingleton sharedMoneySingleton].menuController presentViewController:controller animated:YES completion:nil];
    }
    else
    {
        // 提示框
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"删除本地账本" message:@"你确定删除此本地账本?" preferredStyle:UIAlertControllerStyleAlert];
        [controller addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnullaction)
                               {
                                   UICollectionViewCell *cell = (UICollectionViewCell *)[[[btn superview] superview] superview];
                                   NSIndexPath *indexpath = [_abCollectionView indexPathForCell:cell];
                                   // 要删除的对象
                                   AccountBook *ab = [self.accountBookArray objectAtIndex:indexpath.item];
                                  
                                   // 删除数据库中的数据
                                   [AccountBookTableDAO deleteAccountBook:ab];
                                   // 删除数据源中的数据
                                   [self.accountBookArray removeObject:ab];
                                   // 删除单元格
                                   [_abCollectionView deleteItemsAtIndexPaths:@[indexpath]];
                                   
                                   if (indexpath.row == _currentItem)
                                   {
                                       _currentItem = 0;
                                       [self updateCurrentAccountBookInfo];
                                   }
                                   
                               }]];
        [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        
        [[MoneySingleton sharedMoneySingleton].menuController presentViewController:controller animated:YES completion:nil];
    }
}

- (void)accountBookEditBtnClick:(UIButton *)btn
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[[[btn superview] superview] superview];
    NSIndexPath *indexpath = [_abCollectionView indexPathForCell:cell];
    AccountBook *ab = [self.accountBookArray objectAtIndex:indexpath.item];
    
    EditAccountBookViewController *editAbViewController = [[EditAccountBookViewController alloc] init];
    editAbViewController.useType = UseTypeEdit;//编辑
    editAbViewController.accountBook = ab;
    editAbViewController.abType = ab.abType;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:editAbViewController];
    nav.navigationBar.hidden = YES;
    [editAbViewController release];
    
    [[MoneySingleton sharedMoneySingleton].menuController presentViewController:nav animated:YES completion:nil];
    [nav release];
}

@end
