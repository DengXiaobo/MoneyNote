//
//  DetailViewController.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/16.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "DetailViewController.h"
#import "WriteViewController.h"
#import "TranscationTableDAO.h"
#import "TranscationTableViewCell.h"

static CGFloat kImageOriginHight = 312.f;

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark -
#pragma mark lifeCycle

- (void)dealloc {
    [_tableView release];
    [_transcationArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    NSLog(@"self.type  %ld",self.type);
    
    [self createAddTypeNavigationBarWithLeftTitle:[NSString stringWithFormat:@"今天%ld月%ld日",[NSDate getCurrentDateWithType:DateTypeMonth],[NSDate getCurrentDateWithType:DateTypeToday]] leftAction:@selector(backBtnClick) rightAction:@selector(writeBtnClick)];
    
    [self setupTableViewTop];
    
    [_tableView registerNib:[UINib nibWithNibName:@"TranscationTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.transcationArray = [TranscationTableDAO getTranscationsWithTimestamp:[NSDate getTimestampWithType:self.type] accountBookID:[MoneySingleton sharedMoneySingleton].defaultAccountBookID];
    
    [_tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self reloadSummaryInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark delegate&datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.transcationArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TranscationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    UIView *view = [[UIView alloc] initWithFrame:cell.frame];
    view.backgroundColor = TABLEVIEW_BACKGROUND_COLOR;
    cell.selectedBackgroundView = view;
    [view release];
    
    Transcation *transcation = [self.transcationArray objectAtIndex:indexPath.row];
    cell.dateLabel.text = [NSString stringWithFormat:@"%@.%@",[NSDate getDateWithTimestamp:transcation.tTimestamp type:DateTypeMonth],[NSDate getDateWithTimestamp:transcation.tTimestamp type:DateTypeToday]];
    cell.weekLabel.text = [NSDate getDateWithTimestamp:transcation.tTimestamp type:DateTypeWeekend];
    cell.iconImageView.image = [UIImage imageNamed:transcation.tIconName];
    cell.nameLabel.text = transcation.tCategoryName;
    cell.moneyLabel.text = [NSString stringWithFormat:@"%.2f",transcation.tMoney];
    cell.moneyLabel.textColor = (transcation.tType == 1) ? MONEY_IN_COLOR : MONEY_OUT_COLOR;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 删除 数据库中的数据
    Transcation *transcation = [self.transcationArray objectAtIndex:indexPath.row];
    [TranscationTableDAO deleteTranscation:transcation];
    // 删除 数据源对象
    [self.transcationArray removeObjectAtIndex:indexPath.row];
    // 删除 单元格
    [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    
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

- (void)writeBtnClick
{
    WriteViewController *writeViewController = [[WriteViewController alloc] init];
    [self.navigationController pushViewController:writeViewController animated:YES];
    [writeViewController release];
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
    
    // 结余金额
    _resultMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, -110, 300, 30)];
    _resultMoneyLabel.textColor = [UIColor brownColor];
    _resultMoneyLabel.font = [UIFont boldSystemFontOfSize:25];
    _resultMoneyLabel.text = @"0.00";
    [_tableView addSubview:_resultMoneyLabel];
    [_resultMoneyLabel release];
    
    // 结余label
    UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, -80, 50, 20)];
    resultLabel.textColor = [UIColor brownColor];
    resultLabel.font = [UIFont systemFontOfSize:12];
    resultLabel.text = @"结余";
    [_tableView addSubview:resultLabel];
    [resultLabel release];
    
    // 收入金额
    _incomeMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, -50, 100, 30)];
    _incomeMoneyLabel.textColor = [UIColor brownColor];
    _incomeMoneyLabel.text = @"0.00";
    [_tableView addSubview:_incomeMoneyLabel];
    [_incomeMoneyLabel release];
    
    // 收入label
    UILabel *incomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, -25, 50, 20)];
    incomeLabel.textColor = [UIColor brownColor];
    incomeLabel.font = [UIFont systemFontOfSize:12];
    incomeLabel.text = @"收入";
    [_tableView addSubview:incomeLabel];
    [incomeLabel release];
    
    // 支出金额
    _expendMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, -50, 100, 30)];
    _expendMoneyLabel.textColor = [UIColor brownColor];
    _expendMoneyLabel.text = @"0.00";
    [_tableView addSubview:_expendMoneyLabel];
    [_expendMoneyLabel release];
    
    // 支出label
    UILabel *expendLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, -25, 50, 20)];
    expendLabel.textColor = [UIColor brownColor];
    expendLabel.font = [UIFont systemFontOfSize:12];
    expendLabel.text = @"支出";
    [_tableView addSubview:expendLabel];
    [expendLabel release];

    // 去掉group表上方的空白
    _tableView.tableHeaderView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0,CGFLOAT_MIN)];
}

- (void)reloadSummaryInfo
{
    Summary *summary = [TranscationTableDAO getSummaryWithTimestamp:[NSDate getTimestampWithType:self.type] accountBookID:[MoneySingleton sharedMoneySingleton].defaultAccountBookID];
    _incomeMoneyLabel.text = [NSString stringWithFormat:@"%.2f",summary.sIncome];
    _expendMoneyLabel.text = [NSString stringWithFormat:@"%.2f",summary.sExpend];
    [_resultMoneyLabel animateWithNumber:summary.sIncome - summary.sExpend];
}

@end
