//
//  MainViewController.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/16.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYTabBar.h"

@interface MainViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,ZYTabBarDelegate>
{
    IBOutlet UITableView        *_tableView;
    UIImageView                 *_topImageView;
    UILabel                     *_incomeLabel;
    UILabel                     *_expendLabel;
    NSArray                     *_iconNameArray;
    NSArray                     *_timeArray;
    NSArray                     *_introArray;
    ZYTabBar                    *_tabBar;
}
@property (nonatomic, retain)NSMutableArray *summaryArray;

@end
