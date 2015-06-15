//
//  ClassViewController.h
//  FinancialExpert
//
//  Created by mac on 14-9-16.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@protocol ClassListViewControllerDelegate
- (void)reloadTableView:(NSDictionary *)categoryData;
@end

@interface ClassViewController : UIViewController <NetworkModuleDelegate,MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>

@property( assign, nonatomic ) id <ClassListViewControllerDelegate> delegate;

@end
