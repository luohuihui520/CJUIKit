//
//  EdgeLayoutTableViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/10/18.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJUIKitBaseViewController.h"

@interface EdgeLayoutTableViewController : CJUIKitBaseViewController <UITableViewDataSource, UITableViewDelegate> {
    
}
@property (nonatomic, strong) UITableView *tableView;

@end
