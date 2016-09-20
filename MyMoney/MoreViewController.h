//
//  MoreViewController.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/1.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "SuperViewController.h"

@interface MoreViewController : SuperViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *_tableView;
}
@property(nonatomic,retain)NSArray *iconArray;
@property(nonatomic,retain)NSArray *titleArray;
@property(nonatomic,retain)NSArray *detailTitleArray;

@end
