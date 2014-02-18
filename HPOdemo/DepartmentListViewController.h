//
//  DepartmentListViewController.h
//  HPOdemo
//
//  Created by Gueie on 14-2-10.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "HPONavigationViewController.h"

@interface DepartmentListViewController : HPONavigationViewController<UITableViewDataSource, UITableViewDelegate>

@property (copy, nonatomic) NSString *hospitalId;

@end
