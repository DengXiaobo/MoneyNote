//
//  RecordViewController.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/1.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "SuperViewController.h"

@interface RecordViewController : SuperViewController<UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *_tableView;
    UIImageView                 *_topImageView;
    UILabel                     *_resultMoneyLabel;
    UILabel                     *_incomeMoneyLabel;
    UILabel                     *_expendMoneyLabel;
}
@property (nonatomic, retain)NSMutableArray *transcationArray;

@end
