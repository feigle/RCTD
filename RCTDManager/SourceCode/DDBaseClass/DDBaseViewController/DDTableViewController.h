//
//  DDTableViewController.h
//  DoorDu
//
//  Created by matt on 2018/3/21.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import "DDNeedRefreshViewController.h"

@interface DDTableViewController : DDNeedRefreshViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) UITableViewStyle tableViewStyle;

@end
