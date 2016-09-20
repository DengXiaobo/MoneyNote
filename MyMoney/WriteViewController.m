//
//  WriteViewController.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/16.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//
#define BUTTONWIDTH  60

#import "WriteViewController.h"
#import "WriteContentView.h"
#import "CategoryTableDAO.h"
#import "AccountTableDAO.h"
#import "MemberTableDAO.h"
#import "BusinessTableDAO.h"
#import "ProjectTableDAO.h"
#import "TranscationTableDAO.h"

@interface WriteViewController ()

@end

@implementation WriteViewController

#pragma mark -
#pragma mark lifeCycle

- (void)dealloc
{
    [_typeNameArray release];
    [_categoryLeftArray release];
    [_categoryRightArray release];
    [_accountLeftArray release];
    [_accountRightArray release];
    [_titleLeftArray release];
    [_memberRightArray release];
    [_businessRightArray release];
    [_projectRightArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 背景头
    UIImageView *wallimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 313)];
    wallimageView.image = [UIImage imageNamed:@"NavigationWall"];
    [self.view addSubview:wallimageView];
    [wallimageView release];
    
    [self createNavigationBarWithType:(NavBarTypeImage | NavBarTypeRoot) leftItemTitleOrImageName:@"LeftBarButtonItemBack" leftAction:@selector(backBtnClick) centerTitle:@"记一笔" rightItemTitleOrImageName:@"RightBarButtonItemSave" rightAction:@selector(saveBtnClick)];
    
    _typeNameArray = [[NSMutableArray alloc] initWithObjects:@"支出",@"收入",@"转账",@"退款",@"代付",@"报销",@"借贷", nil];
    
    // 分类数据
    self.categoryLeftArray = [CategoryTableDAO getOneLevelCategoryWithType:1];
    self.categoryRightArray = [NSMutableArray array];
    for (CategoryM *category in self.categoryLeftArray)
    {
        NSMutableArray *array = [CategoryTableDAO getTwoLevelCategoryWithOneLevelID:category.cID];
        [self.categoryRightArray addObject:array];
    }
    
    // 账户数据
    self.accountLeftArray = [AccountTableDAO getOneLevelAccount];
    self.accountRightArray = [NSMutableArray array];
    for (Account *account in self.accountLeftArray)
    {
        NSMutableArray *array = [AccountTableDAO getTwoLevelAccountWithOneLevelID:account.aID];
        [self.accountRightArray addObject:array];
    }
    
    self.titleLeftArray = @[@"最近使用",@"所有"];
    
    // 成员数据
    self.memberRightArray = [NSMutableArray arrayWithObjects:[MemberTableDAO getRecentMember],[MemberTableDAO getAllMember], nil];
    
    // 商家数据
    self.businessRightArray = [NSMutableArray arrayWithObjects:[BusinessTableDAO getRecentBusiness],[BusinessTableDAO getAllBusiness], nil];
    
    // 项目数据
    self.projectRightArray = [NSMutableArray arrayWithObjects:[ProjectTableDAO getRecentProject],[ProjectTableDAO getAllProject], nil];
    
    // 临时的事务对象,每次确定一项之后都保存在这个对象中
    _tempTranscation = [[Transcation alloc] init];
    
    // 布局scrollView
    [self setupTopScrollView];
    [self setupBottomScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark delegate&datasource

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _bottomLine.frame = CGRectMake(scrollView.contentOffset.x / SCREENWIDTH * BUTTONWIDTH + 10, 38, 40, 2);
    
    // 左右切换scrollView的时候
    [self removePreviousShowView];
    self.tempTranscation = [[Transcation alloc] init];
}

- (void)keyBoardTypeChanged:(KeyBoardType)key
{
    
}

- (void)keyBoardValueChanged:(NSString *)value
{
    _currentControl.contentLabel.text = value;
    // 记录金额
    _tempTranscation.tMoney = [value floatValue];
}

- (void)keyBoardHidden:(NumberKeyBoard *)keyBoard
{
    [keyBoard removeFromSuperview];
    _currentShowView = nil;
}

//////

- (NSInteger)pickerView:(MyPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == UIControlTypeCategory)
    {
        if (component == 0)
        {
            return self.categoryLeftArray.count;
        }
        else
        {
            NSInteger leftRow = [pickerView.pickerView selectedRowInComponent:0];
            NSMutableArray *array = [self.categoryRightArray objectAtIndex:leftRow];
            return array.count;
        }
    }
    else if (pickerView.tag == UIControlTypeAccount)
    {
        if (component == 0)
        {
            return self.accountLeftArray.count;
        }
        else
        {
            NSInteger leftRow = [pickerView.pickerView selectedRowInComponent:0];
            NSMutableArray *array = [self.accountRightArray objectAtIndex:leftRow];
            return array.count;
        }
    }
    else if (pickerView.tag == UIControlTypeMember)
    {
        if (component == 0)
        {
            return self.titleLeftArray.count;
        }
        else
        {
            NSInteger leftRow = [pickerView.pickerView selectedRowInComponent:0];
            NSMutableArray *array = [self.memberRightArray objectAtIndex:leftRow];
            return array.count;
        }
    }
    else if (pickerView.tag == UIControlTypeBusiness)
    {
        if (component == 0)
        {
            return self.titleLeftArray.count;
        }
        else
        {
            NSInteger leftRow = [pickerView.pickerView selectedRowInComponent:0];
            NSMutableArray *array = [self.businessRightArray objectAtIndex:leftRow];
            return array.count;
        }
    }
    else
    {// project
        if (component == 0)
        {
            return self.titleLeftArray.count;
        }
        else
        {
            NSInteger leftRow = [pickerView.pickerView selectedRowInComponent:0];
            NSMutableArray *array = [self.projectRightArray objectAtIndex:leftRow];
            return array.count;
        }
    }
}

- (NSString *)pickerView:(MyPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (pickerView.tag == UIControlTypeCategory)
    {
        if (component == 0)
        {
            CategoryM *category = [self.categoryLeftArray objectAtIndex:row];
            return category.cName;
        }
        else
        {
            NSInteger leftRow = [pickerView.pickerView selectedRowInComponent:0];
            NSMutableArray *array = [self.categoryRightArray objectAtIndex:leftRow];
            CategoryM *category = [array objectAtIndex:row];
            return category.cName;
        }
    }
    else if (pickerView.tag == UIControlTypeAccount)
    {
        if (component == 0)
        {
            Account *account = [self.accountLeftArray objectAtIndex:row];
            return account.aName;
        }
        else
        {
            NSInteger leftRow = [pickerView.pickerView selectedRowInComponent:0];
            NSMutableArray *array = [self.accountRightArray objectAtIndex:leftRow];
            Account *account = [array objectAtIndex:row];
            return account.aName;
        }
    }
    else if (pickerView.tag == UIControlTypeMember)
    {
        if (component == 0)
        {
            return [self.titleLeftArray objectAtIndex:row];
        }
        else
        {
            NSInteger leftRow = [pickerView.pickerView selectedRowInComponent:0];
            NSMutableArray *array = [self.memberRightArray objectAtIndex:leftRow];
            Member *member = [array objectAtIndex:row];
            return member.mName;
        }
    }
    else if (pickerView.tag == UIControlTypeBusiness)
    {
        if (component == 0)
        {
            return [self.titleLeftArray objectAtIndex:row];
        }
        else
        {
            NSInteger leftRow = [pickerView.pickerView selectedRowInComponent:0];
            NSMutableArray *array = [self.businessRightArray objectAtIndex:leftRow];
            Business *business = [array objectAtIndex:row];
            return business.bName;
        }
    }
    else
    {// project
        if (component == 0)
        {
            return [self.titleLeftArray objectAtIndex:row];
        }
        else
        {
            NSInteger leftRow = [pickerView.pickerView selectedRowInComponent:0];
            NSMutableArray *array = [self.projectRightArray objectAtIndex:leftRow];
            Project *project = [array objectAtIndex:row];
            return project.pName;
        }
    }
}

- (UIImage *)pickerView:(MyPickerView *)pickerView viewForRow:(NSInteger)row
{
    if (pickerView.tag == UIControlTypeCategory)
    {
        NSInteger leftRow = [pickerView.pickerView selectedRowInComponent:0];
        NSMutableArray *array = [self.categoryRightArray objectAtIndex:leftRow];
        CategoryM *category = [array objectAtIndex:row];
        return [UIImage imageNamed:category.cIconName];
    }
    else
    {
        return nil;
    }
}

- (NSString *)pickerView:(MyPickerView *)pickerView OtherForRow:(NSInteger)row
{
    if (pickerView.tag == UIControlTypeAccount)
    {
        NSInteger leftRow = [pickerView.pickerView selectedRowInComponent:0];
        NSMutableArray *array = [self.accountRightArray objectAtIndex:leftRow];
        Account *account = [array objectAtIndex:row];
        return [NSString stringWithFormat:@"¥ %.2f",account.aSummary];
    }
    else
    {
        return @"";
    }
}

- (void)pickerView:(MyPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        [pickerView.pickerView reloadComponent:1];
    }
    
    NSInteger leftRow = [pickerView.pickerView selectedRowInComponent:0];
    NSInteger rightRow = [pickerView.pickerView selectedRowInComponent:1];
    
    if (pickerView.tag == UIControlTypeCategory)
    {
        CategoryM *leftCategory = [self.categoryLeftArray objectAtIndex:leftRow];
        NSMutableArray *array = [self.categoryRightArray objectAtIndex:leftRow];
        CategoryM *rightCategory = [array objectAtIndex:rightRow];
        _currentControl.contentLabel.text = [NSString stringWithFormat:@"%@ > %@",leftCategory.cName,rightCategory.cName];
        // 记录分类路径,图标,名字
        _tempTranscation.tCategoryPath = rightCategory.cPath;
        _tempTranscation.tIconName = rightCategory.cIconName;
        _tempTranscation.tCategoryName = rightCategory.cName;
    }
    else if (pickerView.tag == UIControlTypeAccount)
    {
        Account *leftAccount = [self.accountLeftArray objectAtIndex:leftRow];
        NSMutableArray *array = [self.accountRightArray objectAtIndex:leftRow];
        Account *rightAccount = [array objectAtIndex:rightRow];
        _currentControl.contentLabel.text = [NSString stringWithFormat:@"%@ > %@",leftAccount.aName,rightAccount.aName];
        // 记录账户路径
        _tempTranscation.tAccountPath = rightAccount.aPath;
    }
    else if (pickerView.tag == UIControlTypeMember)
    {
        NSMutableArray *array = [self.memberRightArray objectAtIndex:leftRow];
        Member *member = [array objectAtIndex:rightRow];
        _currentControl.contentLabel.text = member.mName;
        // 记录成员id
        _tempTranscation.tMemberID = member.mID;
    }
    else if (pickerView.tag == UIControlTypeBusiness)
    {
        NSMutableArray *array = [self.businessRightArray objectAtIndex:leftRow];
        Business *business = [array objectAtIndex:rightRow];
        _currentControl.contentLabel.text = business.bName;
        // 记录商家id
        _tempTranscation.tBusinessID = business.bID;
    }
    else
    {// project
        NSMutableArray *array = [self.projectRightArray objectAtIndex:leftRow];
        Project *project = [array objectAtIndex:rightRow];
        _currentControl.contentLabel.text = project.pName;
        // 记录项目id
        _tempTranscation.tProjectID = project.pID;
    }
}

- (void)pickerViewHidden:(MyPickerView *)pickerView
{
    [pickerView removeFromSuperview];
    _currentShowView = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@" ---- %ld",_currentControl.controlType);
    
    textField.userInteractionEnabled = NO;
    
    // 记录备注
    _tempTranscation.tRemark = textField.text;
}

#pragma mark -
#pragma mark otherMethod

- (void)setupTopScrollView
{
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 40)];
    //    scrollView.backgroundColor = [UIColor grayColor];
    _topScrollView.contentSize = CGSizeMake(BUTTONWIDTH * _typeNameArray.count, 40);
    _topScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_topScrollView];
    [_topScrollView release];
    
    for (int i = 0; i < _typeNameArray.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(BUTTONWIDTH * i, 0, BUTTONWIDTH, 40);
        [btn setTitle:_typeNameArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.tag = i;
        [btn addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_topScrollView addSubview:btn];
    }
    
    // 按钮底部的线
    _bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 38, 40, 2)];
    _bottomLine.backgroundColor = [UIColor brownColor];
    [_topScrollView addSubview:_bottomLine];
    [_bottomLine release];
}

- (void)typeBtnClick:(UIButton *)btn
{
    _bottomLine.frame = CGRectMake(btn.tag * BUTTONWIDTH + 10, 38, 40, 2);
    _bottomScrollView.contentOffset = CGPointMake(SCREENWIDTH * btn.tag, 0);
}

- (void)setupBottomScrollView
{
    _bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 104, SCREENWIDTH, SCREENHEIGHT - 104)];
    _bottomScrollView.backgroundColor = [UIColor whiteColor];
    _bottomScrollView.contentSize = CGSizeMake(SCREENWIDTH * _typeNameArray.count, SCREENHEIGHT - 104);
    _bottomScrollView.showsHorizontalScrollIndicator = NO;
    _bottomScrollView.pagingEnabled = YES;
    [self.view addSubview:_bottomScrollView];
    _bottomScrollView.delegate = self;
    [_bottomScrollView release];
    
    for (int i = 0; i < _typeNameArray.count; i++)
    {
        WriteContentView *contentView = [[WriteContentView alloc] initWithFrame:CGRectMake(SCREENWIDTH * i, 0, SCREENWIDTH, SCREENHEIGHT - 104) vc:self action:@selector(controlClick:)];
        [_bottomScrollView addSubview:contentView];
        [contentView release];
    }
}

- (void)controlClick:(WriteUnitControl *)control
{
    
    NSLog(@"%ld",control.controlType);

    [self removePreviousShowView];
    
    // 记录当前编辑的control  为了给他们内部的label赋值
    _currentControl = control;

    switch (control.controlType)
    {
        case UIControlTypeMoney:
        {
            NumberKeyBoard *keyBoard = [[NumberKeyBoard alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - 248, SCREENWIDTH, 248)];
            keyBoard.type = KeyBoardTypeExpend;
            keyBoard.delegate = self;
            [self.view addSubview:keyBoard];
            [keyBoard release];
            
            _currentShowView = keyBoard;// 记录当前弹出的view
        }
            break;
        case UIControlTypeCategory:
        {
            MyPickerView *pickerView = [[MyPickerView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - 230, SCREENWIDTH, 230)];
            pickerView.tag = control.controlType;
            pickerView.type = PickerTypeImage;
            pickerView.delegate = self;
            [self.view addSubview:pickerView];
            [pickerView release];
            
            _currentShowView = pickerView;
        }
            break;
        case UIControlTypeAccount:
        {
            MyPickerView *pickerView = [[MyPickerView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - 230, SCREENWIDTH, 230)];
            pickerView.tag = control.controlType;
            pickerView.type = PickerTypeOther;
            pickerView.delegate = self;
            [self.view addSubview:pickerView];
            [pickerView release];
            
            _currentShowView = pickerView;
        }
            break;
        case UIControlTypeMember:
        case UIControlTypeBusiness:
        case UIControlTypeProject:
        {
            MyPickerView *pickerView = [[MyPickerView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - 230, SCREENWIDTH, 230)];
            pickerView.tag = control.controlType;
            pickerView.type = PickerTypeNormal;
            pickerView.delegate = self;
            [self.view addSubview:pickerView];
            [pickerView release];
            
            _currentShowView = pickerView;
        }
            break;
        case UIControlTypeRemark:
        {
            control.contentTextField.userInteractionEnabled = YES;
            control.contentTextField.delegate = self;
            [control.contentTextField becomeFirstResponder];
        }
            break;
        default:
            break;
    }
    
}

// 移除上一项弹出的showView
- (void)removePreviousShowView
{
    // 把之前的移除
    if (_currentShowView != nil)
    {
        [_currentShowView removeFromSuperview];
        _currentShowView = nil;
    }
    if (_currentControl.controlType == UIControlTypeRemark)
    {
        [self.view endEditing:YES];
    }
}

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveBtnClick
{
    NSLog(@"保存");
    
    _tempTranscation.tType = _bottomScrollView.contentOffset.x / SCREENWIDTH;
    if (_tempTranscation.tCategoryPath == nil)
    {
        _tempTranscation.tCategoryPath = @"1/12";
        _tempTranscation.tIconName = @"icon_yfsp_yfkz";
        _tempTranscation.tCategoryName = @"衣服裤子";
    }
    if (_tempTranscation.tAccountPath == nil)
    {
        _tempTranscation.tAccountPath = @"1/8";
    }
    if (_tempTranscation.tMemberID == 0)
    {
        _tempTranscation.tMemberID = 1;
    }
    if (_tempTranscation.tBusinessID == 0)
    {
        _tempTranscation.tBusinessID = 1;
    }
    if (_tempTranscation.tProjectID == 0)
    {
        _tempTranscation.tProjectID = 1;
    }
    _tempTranscation.tAccountBookID = [MoneySingleton sharedMoneySingleton].defaultAccountBookID;
    _tempTranscation.tTimestamp = [[NSDate date] timeIntervalSince1970];
    
    // 保存 记一笔的记录
    [TranscationTableDAO addTranscation:_tempTranscation];
    
    // 保存金额 到账户表中
    NSInteger accountID = [[[_tempTranscation.tAccountPath componentsSeparatedByString:@"/"] objectAtIndex:1] integerValue];
    [AccountTableDAO updateMoney4SummaryWithAccountID:accountID money:_tempTranscation.tMoney];
    
    // 保存成员 商家 项目 的使用次数
    [MemberTableDAO updateUsedCountWithMemberID:_tempTranscation.tMemberID];
    [BusinessTableDAO updateUsedCountWithBusinessID:_tempTranscation.tBusinessID];
    [ProjectTableDAO updateUsedCountWithProjectID:_tempTranscation.tProjectID];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
