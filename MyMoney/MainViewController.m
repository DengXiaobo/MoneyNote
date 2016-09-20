//
//  MainViewController.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/16.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableViewCell.h"
#import "WriteViewController.h"
#import "TranscationTableDAO.h"
#import "DetailViewController.h"
#import "RecordViewController.h"
#import "AccountViewController.h"
#import "GraphViewController.h"
#import "MoneyViewController.h"
#import "MoreViewController.h"

static CGFloat kImageOriginHight = 260.f;

@interface MainViewController ()

@end

@implementation MainViewController

#pragma mark -
#pragma mark lifeCycle

- (void)dealloc {
    [_tableView release];
    [_summaryArray release];
    [_iconNameArray release];
    [_timeArray release];
    [_introArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 表上方的控件
    [self setupTableViewTop];
    // 组装其他数据
    [self prepareData];
    
    // 底部tabBar
    _tabBar = [[ZYTabBar alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - 49, SCREENWIDTH, 49)];
    _tabBar.delegate = self;
    [self.view addSubview:_tabBar];
    [_tabBar release];
    
    [[MoneySingleton sharedMoneySingleton].menuController.rootViewController.view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadSummaryInfo) name:AccountBookChangedNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 刷新汇总信息
    [self reloadSummaryInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark delegate&datasource

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < -kImageOriginHight)
    {
        CGRect f = _topImageView.frame;
        f.origin.y = yOffset;
        f.size.height = -yOffset;
        _topImageView.frame = f;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier0 = @"Cell0";
    static NSString *cellIdentifier1 = @"Cell1";
    
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(indexPath.row == 0) ? cellIdentifier0 : cellIdentifier1];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MainTableViewCell" owner:nil options:nil] objectAtIndex:(indexPath.row == 0) ? 0 : 1];
    }
    
    if (indexPath.row == 0)
    {
        [cell.writeBtn addTarget:self action:@selector(writebtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        // 点击颜色
        UIView *view = [[UIView alloc] initWithFrame:cell.frame];
        view.backgroundColor = TABLEVIEW_BACKGROUND_COLOR;
        cell.selectedBackgroundView = view;
        [view release];
        
        Summary *summary = [self.summaryArray objectAtIndex:indexPath.row - 1];
        
        if (indexPath.row == 1)
        {
            cell.iconImageView.image = [UIImage combineImage:[UIImage imageNamed:summary.sIconName] withString:[NSString stringWithFormat:@"%ld",[NSDate getCurrentDateWithType:DateTypeToday]]];
        }
        else
        {
            cell.iconImageView.image = [UIImage imageNamed:summary.sIconName];
        }
        
        cell.timeLabel.text = summary.sTime;
        cell.introLabel.text = summary.sIntro;
        cell.incomeLabel.text = [NSString stringWithFormat:@"%.2f",summary.sIncome];
        cell.expendLabel.text = [NSString stringWithFormat:@"%.2f",summary.sExpend];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    detailViewController.type = indexPath.row - 1;
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

- (void)tabBarItemClicked:(NSInteger)itemTag
{
    switch (itemTag)
    {
        case 0:
        {
            // 左侧
            [[MoneySingleton sharedMoneySingleton].menuController showLeftController:YES];
        }
            break;
        case 1:
        {
            NSLog(@"流水");
            RecordViewController *recordVC = [[RecordViewController alloc] init];
            [self.navigationController pushViewController:recordVC animated:YES];
            [recordVC release];
        }
            break;
        case 2:
        {
            NSLog(@"账户");
            AccountViewController *accountVC = [[AccountViewController alloc] init];
            [self.navigationController pushViewController:accountVC animated:YES];
            [accountVC release];
        }
            break;
        case 3:
        {
            NSLog(@"图表");
            GraphViewController *graphVC = [[GraphViewController alloc] init];
            [self.navigationController pushViewController:graphVC animated:YES];
            [graphVC release];
        }
            break;
        case 4:
        {
            NSLog(@"理财");
            MoneyViewController *moneyVC = [[MoneyViewController alloc] init];
            [self.navigationController pushViewController:moneyVC animated:YES];
            [moneyVC release];
        }
            break;
        case 5:
        {
            NSLog(@"更多");
            MoreViewController *moreVC = [[MoreViewController alloc] init];
            [self.navigationController pushViewController:moreVC animated:YES];
            [moreVC release];
        }
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark otherMethod

- (void)setupTableViewTop
{
    // 缩放图片
    _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -kImageOriginHight, SCREENWIDTH, kImageOriginHight)];
    _topImageView.contentMode = UIViewContentModeScaleAspectFill;
    _topImageView.image = [UIImage imageNamed:[MoneySingleton sharedMoneySingleton].defaultAccountBookImageName];
    
    _tableView.contentInset = UIEdgeInsetsMake(kImageOriginHight, 0, 0, 0);
    [_tableView addSubview:_topImageView];
    [_topImageView release];
    
    // 日期
    UILabel *monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, -230, 30, 40)];
    monthLabel.textColor = MONEY_IN_COLOR;
    monthLabel.font = [UIFont systemFontOfSize:35];
    monthLabel.text = [NSString stringWithFormat:@"%ld",[NSDate getCurrentDateWithType:DateTypeMonth]];
    [_tableView addSubview:monthLabel];
    [monthLabel release];
    
    UILabel *yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, -225, 200, 40)];
    yearLabel.textColor = [UIColor brownColor];
    yearLabel.text = [NSString stringWithFormat:@"/ %ld",[NSDate getCurrentDateWithType:DateTypeYear]];
    [_tableView addSubview:yearLabel];
    [yearLabel release];
    
    // 收入
    UILabel *incomeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, -80, 70, 30)];
    incomeTitleLabel.textColor = [UIColor brownColor];
    incomeTitleLabel.text = @"本月收入";
    [_tableView addSubview:incomeTitleLabel];
    [incomeTitleLabel release];
    
    _incomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, -80, 100, 30)];
    _incomeLabel.textColor = [UIColor brownColor];
    _incomeLabel.textAlignment = NSTextAlignmentRight;
    _incomeLabel.text = @"¥  0.00";
    [_tableView addSubview:_incomeLabel];
    [_incomeLabel release];
    
    // 支出
    UILabel *expendTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, -40, 70, 30)];
    expendTitleLabel.textColor = [UIColor brownColor];
    expendTitleLabel.text = @"本月支出";
    [_tableView addSubview:expendTitleLabel];
    [expendTitleLabel release];
    
    _expendLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, -40, 100, 30)];
    _expendLabel.textColor = [UIColor brownColor];
    _expendLabel.textAlignment = NSTextAlignmentRight;
    _expendLabel.text = @"¥  0.00";
    [_tableView addSubview:_expendLabel];
    [_expendLabel release];
}

- (void)prepareData
{
    _iconNameArray = [[NSArray alloc] initWithObjects:@"TodayIcon",@"WeekIcon",@"MonthIcon",@"YearIcon", nil];
    
    NSInteger day = [NSDate getCurrentDateWithType:DateTypeToday];
    NSInteger month = [NSDate getCurrentDateWithType:DateTypeMonth];
    NSInteger year = [NSDate getCurrentDateWithType:DateTypeYear];
    _timeArray = [[NSArray alloc] initWithObjects:@"今天",@"本周",[NSString stringWithFormat:@"%ld月",month],@"本年", nil];
    _introArray = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%ld月%ld日",month,day],[NSString stringWithFormat:@"%@ - %@",[NSDate getDateOfCurrentWeek:1],[NSDate getDateOfCurrentWeek:7]],[NSString stringWithFormat:@"%ld月1日 - %ld月%ld日",month,month,[NSDate getLastDayOfCurrentMonth]],[NSString stringWithFormat:@"%ld年",year],nil];
}

- (void)reloadSummaryInfo
{
    // 刷新汇总信息
    self.summaryArray = [NSMutableArray array];
    
    for (int i = 0; i < 4; i++)
    {
        NSTimeInterval timestamp = [NSDate getTimestampWithType:i];
        
        Summary *summary = [TranscationTableDAO getSummaryWithTimestamp:timestamp accountBookID:[MoneySingleton sharedMoneySingleton].defaultAccountBookID];
        summary.sType = i;
        summary.sIconName = [_iconNameArray objectAtIndex:i];
        summary.sTime = [_timeArray objectAtIndex:i];
        summary.sIntro = [_introArray objectAtIndex:i];
        [self.summaryArray addObject:summary];
    }
    [_tableView reloadData];
    
    // 刷新上方图片
    _topImageView.image = [UIImage imageNamed:[MoneySingleton sharedMoneySingleton].defaultAccountBookImageName];
    
    // 刷新表上方数据
    Summary *monthSummary = [self.summaryArray objectAtIndex:1];
    _incomeLabel.text = [NSString stringWithFormat:@"¥  %.2f",monthSummary.sIncome];
    _expendLabel.text = [NSString stringWithFormat:@"¥  %.2f",monthSummary.sExpend];
}

- (void)writebtnClick
{
    WriteViewController *writeViewController = [[WriteViewController alloc] init];
    [self.navigationController pushViewController:writeViewController animated:YES];
    [writeViewController release];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSValue *value = [change objectForKey:@"new"];
    float x = [value CGRectValue].origin.x;
    
    [_tabBar changedOrientation:- x * M_PI / 320];
}

@end
