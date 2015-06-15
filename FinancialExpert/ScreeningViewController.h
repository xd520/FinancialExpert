//
//  ScreeningViewController.h
//  FinancialExpert
//
//  Created by mac on 14-9-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassViewController.h"
#import "QCheckBox.h"

@protocol SelectListViewControllerDelegate
- (void)reloadTableView:(NSDictionary *)categoryData;
@end

@interface ScreeningViewController : UIViewController <ClassListViewControllerDelegate,QCheckBoxDelegate>


@property( assign, nonatomic ) id <SelectListViewControllerDelegate> delegate;


@end
