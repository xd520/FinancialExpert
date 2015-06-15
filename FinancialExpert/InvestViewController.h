//
//  InvestViewController.h
//  FinancialExpert
//
//  Created by mac on 14-9-15.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface InvestViewController : UIViewController <NetworkModuleDelegate,MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>

- (void)reloadData;

@end
