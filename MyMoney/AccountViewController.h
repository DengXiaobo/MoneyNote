//
//  AccountViewController.h
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/1.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "SuperViewController.h"

@interface AccountViewController : SuperViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView        *_tableView;
    UIImageView                 *_topImageView;
    UILabel                     *_resultMoneyLabel;
    UILabel                     *_incomeMoneyLabel;
    UILabel                     *_expendMoneyLabel;
}
@property (nonatomic, retain)NSMutableArray *sectionArray;
@property (nonatomic, retain)NSMutableArray *rowArray;

@end
