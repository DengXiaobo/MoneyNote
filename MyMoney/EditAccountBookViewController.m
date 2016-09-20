//
//  EditAccountBookViewController.m
//  MyMoney
//
//  Created by xuemeng on 16/6/22.
//  Copyright © 2016年 xuemeng. All rights reserved.
//

#import "EditAccountBookViewController.h"
#import "AccountBookTemplateCell.h"
#import "AccountBookTableDAO.h"
#import "ChooseCoverImageViewController.h"

@interface EditAccountBookViewController ()

@end

@implementation EditAccountBookViewController

#pragma mark -
#pragma mark lifeCycle

- (void)dealloc {
    [_nameTextField release];
    [_coverImageView release];
    [_collectionView release];
    [_titleArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 账本名字数组
    _titleArray = [[NSArray alloc] initWithObjects:@"标准理财",@"生意账本",@"旅游账本",@"装修账本",@"结婚账本",@"汽车账本",@"宝宝账本", nil];//7
    // 面板名字数组
    _templateNameArray = [[NSArray alloc] initWithObjects:@"经典面板",@"旅游面板",@"装修面板",@"结婚面板",@"汽车面板",@"宝宝面板", nil];//6
    
    // 当前界面选中第几个面板
    _currentTemplateIndex = (self.abType == 0) ? 0 : self.abType - 1;// 0~6 变为 0~5

    if (self.useType == UseTypeNew)
    {
        // 新建账本
        [self createNavigationBarWithType:(NavBarTypeNotRoot | NavBarTypeString) leftItemTitleOrImageName:[NSString stringWithFormat:@"添加%@",_titleArray[self.abType]] leftAction:@selector(backBtnClick1) centerTitle:nil rightItemTitleOrImageName:@"保存" rightAction:@selector(saveBtnClick1)];
        
        // 设置默认的账本名字
        _nameTextField.text = _titleArray[self.abType];
        
        // 即将保存的账本对象
        AccountBook *ab = [[AccountBook alloc] init];
        ab.abName = _nameTextField.text;
        ab.abImageName = [NSString stringWithFormat:@"AccountBookCover%ld",(long)_currentTemplateIndex + 1];
        ab.abHomeImageName = [NSString stringWithFormat:@"bookTemplateBg_%ld",(long)_currentTemplateIndex + 1];
        self.accountBook = ab;
        [ab release];
    }
    else
    {
        // 修改账本
        [self createNavigationBarWithType:(NavBarTypeNotRoot | NavBarTypeString) leftItemTitleOrImageName:@"账本设置" leftAction:@selector(backBtnClick2) centerTitle:nil rightItemTitleOrImageName:@"保存" rightAction:@selector(saveBtnClick2)];
        
        // 设置默认的账本名字
        _nameTextField.text = self.accountBook.abName;
        
    }
    
    [_collectionView registerNib:[UINib nibWithNibName:@"AccountBookTemplateCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 设置默认的封面图片
    _coverImageView.image = [UIImage imageNamed:self.accountBook.abImageName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark CollectionDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _templateNameArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AccountBookTemplateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.templateImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"bookTemplateBg_%ld",(long)indexPath.row + 1]];
    cell.templateName.text = _templateNameArray[indexPath.row];
    cell.ridaoImageView.image = [UIImage imageNamed:(_currentTemplateIndex == indexPath.row) ? @"RadioButtonSelected" : @"RadioButtonNormal"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    // 记录当前的模板索引
    _currentTemplateIndex = indexPath.row;
    [_collectionView reloadData];
}


#pragma mark -
#pragma mark otherMethod

- (void)backBtnClick1
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backBtnClick2
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveBtnClick1
{
    self.accountBook.abHomeImageName = [NSString stringWithFormat:@"bookTemplateBg_%ld",(long)_currentTemplateIndex+ 1];
    self.accountBook.abName = _nameTextField.text;
    self.accountBook.abType = (int)_currentTemplateIndex + 1;
    // 存入数据库
    [AccountBookTableDAO addAccountBook:self.accountBook];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveBtnClick2
{
    self.accountBook.abHomeImageName = [NSString stringWithFormat:@"bookTemplateBg_%ld",(long)_currentTemplateIndex+ 1];
    self.accountBook.abName = _nameTextField.text;
    self.accountBook.abType = (int)_currentTemplateIndex + 1;
    // 更改数据库
    [AccountBookTableDAO updateAccountBook:self.accountBook];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)chooseCoverImageBtnClick:(id)sender
{
    [self.view endEditing:YES];
    
    ChooseCoverImageViewController *chooseCoverImageVC = [[ChooseCoverImageViewController alloc] init];
    chooseCoverImageVC.lastAccountBook = self.accountBook;
    [self.navigationController pushViewController:chooseCoverImageVC animated:YES];
    [chooseCoverImageVC release];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
