//
//  AddAccountBookViewController.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/1.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "SuperViewController.h"

@interface AddAccountBookViewController : SuperViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView    *_tableView;
    NSArray                 *_titleArray;
    NSArray                 *_detailArray;
}

@end
