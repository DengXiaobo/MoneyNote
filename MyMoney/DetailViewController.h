//
//  DetailViewController.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/16.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "SuperViewController.h"

@interface DetailViewController : SuperViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView        *_tableView;
    UIImageView                 *_topImageView;
    UILabel                     *_resultMoneyLabel;
    UILabel                     *_incomeMoneyLabel;
    UILabel                     *_expendMoneyLabel;
}
@property (nonatomic, retain)NSMutableArray *transcationArray;
@property (nonatomic, assign)DateType type;

@end
