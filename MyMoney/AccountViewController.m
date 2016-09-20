//
//  AccountViewController.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/1.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "AccountViewController.h"
#import "AccountTableDAO.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

static CGFloat kImageOriginHight = 312.f;

#pragma mark -
#pragma mark lifeCycle

- (void)dealloc {
    [_tableView release];
    [_sectionArray release];
    [_rowArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self createAddTypeNavigationBarWithLeftTitle:@"账户" leftAction:@selector(backBtnClick) rightAction:@selector(addBtnClick)];
    
    [self setupTableViewTop];
    
    // 账户数据
    self.sectionArray = [AccountTableDAO getOneLevelAccount];
    self.rowArray = [NSMutableArray array];
    for (Account *account in self.sectionArray)
    {
        NSMutableArray *array = [AccountTableDAO getTwoLevelAccountWithOneLevelID:account.aID];
        [self.rowArray addObject:array];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self reloadSummaryInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark delegate&datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [self.rowArray objectAtIndex:section];
    
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] autorelease];
    }
    
    // 选中颜色
    UIView *view = [[UIView alloc] initWithFrame:cell.frame];
    view.backgroundColor = TABLEVIEW_BACKGROUND_COLOR;
    cell.selectedBackgroundView = view;
    [view release];
    
    NSArray *array = [self.rowArray objectAtIndex:indexPath.section];
    Account *account = [array objectAtIndex:indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = [account.aName stringByReplacingOccurrencesOfString:@"(CNY)" withString:@""];
    cell.detailTextLabel.textColor = MONEY_OUT_COLOR;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"¥ %.2f",account.aSummary];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Account *account = [self.sectionArray objectAtIndex:section];
    return account.aName;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"清零";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Account *account = [[self.rowArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    // 重置数据库中的数据
    [AccountTableDAO resetMoneySummaryWithAccountID:account.aID];
    
    account.aSummary = 0;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [self reloadSummaryInfo];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// 处理图片下拉放大的
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < - kImageOriginHight + 130)
    {
        CGRect f = _topImageView.frame;
        f.origin.y = yOffset - 130;
        f.size.height = -yOffset + 130;
        _topImageView.frame = f;
    }
    
    self.navImageView.hidden = (yOffset > -64) ? NO : YES;
}

#pragma mark -
#pragma mark otherMethod

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addBtnClick
{
    NSLog(@"添加账户");
}

- (void)setupTableViewTop
{
    // 缩放图片
    _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, - kImageOriginHight, SCREENWIDTH, kImageOriginHight)];
    _topImageView.contentMode = UIViewContentModeScaleAspectFill;
    _topImageView.image = [UIImage imageNamed:@"NavigationWall"];
    
    _tableView.contentInset = UIEdgeInsetsMake(kImageOriginHight - 130, 0, 0, 0);
    [_tableView addSubview:_topImageView];
    [_topImageView release];
    
    // 总记账金额
    _resultMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, -110, 300, 30)];
    _resultMoneyLabel.textColor = [UIColor brownColor];
    _resultMoneyLabel.font = [UIFont boldSystemFontOfSize:25];
    _resultMoneyLabel.text = @"0.00";
    [_tableView addSubview:_resultMoneyLabel];
    [_resultMoneyLabel release];
    
    // 累计label
    UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, -80, 100, 20)];
    resultLabel.textColor = [UIColor brownColor];
    resultLabel.font = [UIFont systemFontOfSize:12];
    resultLabel.text = @"总记账金额";
    [_tableView addSubview:resultLabel];
    [resultLabel release];
}

- (void)reloadSummaryInfo
{
    float total = 0;
    
    for (NSArray *array in self.rowArray)
    {
        for (Account *account in array)
        {
            total += account.aSummary;
        }
    }
    [_resultMoneyLabel animateWithNumber:total];
}

@end
