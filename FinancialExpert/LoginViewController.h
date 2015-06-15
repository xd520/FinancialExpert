//
//  LoginViewController.h
//  FinancialExpert
//
//  Created by mac on 14-9-22.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@class MyMineViewController;
@class InvestViewController;
@class ManageViewController;



@interface LoginViewController : UIViewController <UITextFieldDelegate,NetworkModuleDelegate,MBProgressHUDDelegate,UINavigationControllerDelegate>
{
    UITextField *phoneNumText;
    UITextField *passWordText;
    UIImageView *passWord;
    UIImageView *phoneNum;
    MBProgressHUD *HUD;
    
}

@property(nonatomic,strong) UIButton *button1;
@property(nonatomic,strong)MyMineViewController *myViewController;
@property(nonatomic,strong)InvestViewController *investViewController;
@property(nonatomic,strong)ManageViewController *manageViewController;
@property(nonatomic,strong)NSString *customerName;
@end
