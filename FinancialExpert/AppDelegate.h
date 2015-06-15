//
//  AppDelegate.h
//  FinancialExpert
//
//  Created by mac on 14-9-15.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorUtil.h"
#import "Toast+UIView.h"
#import "MBProgressHUD.h"
#import "NetworkModule.h"
#import "NSObject+SBJson.h"
#import "SRRefreshView.h"
#import "PSStackedViewController.h"
#import "Customer.h"
#import "MainViewController.h"

#define SERVERURL @"http://114.215.124.116:8081/appservice"
#define rtKeyListStr @"2008,2009,507,508"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *loginArray;
@property (strong, nonatomic) MainViewController * mainTabViewController;

@end
