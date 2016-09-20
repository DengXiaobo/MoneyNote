//
//  AddAccountBookViewController.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/1.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "AddAccountBookViewController.h"
#import "EditAccountBookViewController.h"

@interface AddAccountBookViewController ()

@end

@implementation AddAccountBookViewController

#pragma mark -
#pragma mark lifeCycle

- (void)dealloc
{
    [_tableView release];
    [_titleArray release];
    [_detailArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavigationBarWithType:(NavBarTypeString | NavBarTypeRoot) leftItemTitleOrImageName:@"关闭" leftAction:@selector(closeBtnClick) centerTitle:nil rightItemTitleOrImageName:@"示例账本" rightAction:nil];
    
    _titleArray = [[NSArray alloc] initWithObjects:@"标准理财",@"生意账本",@"旅游账本",@"装修账本",@"结婚账本",@"汽车账本",@"宝宝账本", nil];
    _detailArray = [[NSArray alloc] initWithObjects:@"标准账本,分类较全",@"帮你轻松打理生意流水账",@"适合出游,精心定义旅行分类",@"装修必备,贴心为装修场景打造",@"进入神圣殿堂前,记一记更幸福",@"轻松记录爱车消费",@"亲爱的宝贝", nil];
    
    CGRect frame=CGRectMake(0, 0, 0,CGFLOAT_MIN);
    _tableView.tableHeaderView=[[UIView alloc]initWithFrame:frame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark delegate&datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] autorelease];
    }
    
    UIView *view = [[UIView alloc] initWithFrame:cell.frame];
    view.backgroundColor = TABLEVIEW_BACKGROUND_COLOR;
    cell.selectedBackgroundView = view;
    [view release];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"AccountBookTemplate%ld",indexPath.row + 1]];
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.detailTextLabel.text = _detailArray[indexPath.row];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EditAccountBookViewController *editAbViewController = [[EditAccountBookViewController alloc] init];
    editAbViewController.useType = UseTypeNew;
    editAbViewController.abType = indexPath.row;
    [self.navigationController pushViewController:editAbViewController animated:YES];
    [editAbViewController release];
}

#pragma mark -
#pragma mark otherMethod

- (void)closeBtnClick
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
