//
//  SelectMoreViewController.h
//  FinancialExpert
//
//  Created by mac on 14-9-17.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#define funCode @"106002"
#define rtKeyListStr @"2008,2009,507,508"

@protocol SelectListViewControllerDelegate
- (void)reloadTableView:(NSDictionary *)categoryData;
@end

@interface SelectMoreViewController : UIViewController <NetworkModuleDelegate,MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>

@property( assign, nonatomic ) id <SelectListViewControllerDelegate> delegate;

@end
