//
//  MoreViewController.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/1.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

#pragma mark -
#pragma mark lifeCycle

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavigationBarWithType:(NavBarTypeNotRoot | NavBarTypeString) leftItemTitleOrImageName:@"更多" leftAction:@selector(backBtnClick) centerTitle:nil rightItemTitleOrImageName:nil rightAction:nil];
    
    //创建数据源
    self.iconArray = @[@[@"share_center_icon_setting_entry",@"AccountBookConfigIcon"],@[@"SettingFundCenterIcon",@"SettingLoanCenterIcon"],@[@"SettingAddTransaction"],@[@"SettingCategoryIcon",@"SettingBudgetIcon",@"SettingProjectServiceIcon",@"SettingMemberIcon",@"SettingCorporationIcon"],@[@"SettingPasscodeIcon",@"SettingFeedbackIcon",@"SettingGuideIcon",@"SettingIntroduceUsIcon",@"SettingAboutProfesionalIcon",@"SettingAboutIcon"]];
    self.titleArray = @[@[@"共享中心",@"账本自定义"],@[@"投资中心",@"借贷中心"],@[@"新旧记一笔切换"],@[@"分类管理",@"预算管理",@"项目管理",@"成员管理",@"商家管理"],@[@"密码保护",@"意见反馈",@"入门帮助",@"推荐给好友",@"关于专业版",@"关于随手记"]];
    self.detailTitleArray = @[@[@"多人一起记账,分享账本给更多人看",@"设置你的账本属性,导航和本位币"],@[@"快速管理我的投资账户",@"以借贷人视角管理往来借贷账单"],@[@""],@[@"编辑,排序您的收支分类",@"设定一个预算,控制你的开销",@"项目记账,项目自定义",@"成员记账,成员自定义",@"商家记账,商家自定义"],@[@"",@"",@"",@"",@"",@""]];
    
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark delegate&datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.iconArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *subArray = [self.iconArray objectAtIndex:section];
    return subArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] autorelease];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UIView *view = [[UIView alloc] initWithFrame:cell.frame];
    view.backgroundColor = TABLEVIEW_BACKGROUND_COLOR;
    cell.selectedBackgroundView = view;
    [view release];
    
    NSArray *subIconArray = [self.iconArray objectAtIndex:indexPath.section];
    NSArray *subTitleArray = [self.titleArray objectAtIndex:indexPath.section];
    NSArray *subDetailTitleArray = [self.detailTitleArray objectAtIndex:indexPath.section];
    
    cell.imageView.image = [UIImage imageNamed:[subIconArray objectAtIndex:indexPath.row]];
    
    cell.textLabel.text = [subTitleArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    cell.detailTextLabel.text = [subDetailTitleArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
