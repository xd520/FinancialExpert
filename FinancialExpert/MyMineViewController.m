//
//  MyMineViewController.m
//  FinancialExpert
//
//  Created by mac on 14-9-15.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MyMineViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "LeveyTabBarController.h"

@interface MyMineViewController ()
{
    UIImageView *pushView;
    UIButton *loginBtn;
    UIImageView *headImage;
    UILabel *loginEndLabel;
    UIButton *regestBtn;
    
}
@end

@implementation MyMineViewController
@synthesize loginLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我的账户";
    }
    return self;
}

-(void)loadView {
    [super loadView];
    UIView *baseView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
   // baseView.backgroundColor = [ColorUtil colorWithHexString:@"f5f4f2"];
    baseView.backgroundColor = [UIColor grayColor];
    self.view = baseView;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *loginView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.height, ScreenWidth, 140)];
    loginView.image = [UIImage imageNamed:@"not_login_bg.jpg"];
    loginView.userInteractionEnabled = YES;
    
    headImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, 60, 60)];
    headImage.image = [UIImage imageNamed:@"xd1"];
    headImage.hidden = YES;
    [loginView addSubview:headImage];
    
    loginEndLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 63, ScreenWidth - 130, 12)];
    loginEndLabel.font = [UIFont systemFontOfSize:12];
    loginEndLabel.textAlignment = NSTextAlignmentCenter;
    loginEndLabel.text = @"";
    [loginView addSubview:loginEndLabel];
    
    
    
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake((ScreenWidth - 110)/2, 62, 110, 35) ;
    [loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
    [loginBtn setImage:[UIImage imageNamed:@"click_login"] forState:UIControlStateNormal];
    UILabel *loginBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 110, 15)];
    loginBtnLabel.font = [UIFont boldSystemFontOfSize:15];
    loginBtnLabel.textColor = [UIColor brownColor];
    loginBtnLabel.textAlignment = NSTextAlignmentCenter;
    loginBtnLabel.text = @"登录/注册";
    [loginBtn addSubview:loginBtnLabel];
    [loginBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    
    
    [loginView addSubview:loginBtn];
    
    loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 40, ScreenWidth - 190, 13)];
    loginLabel.font = [UIFont boldSystemFontOfSize:13];
    loginLabel.textAlignment = NSTextAlignmentCenter;
    loginLabel.text = @"欢迎来到投资管理系统";
    [loginView addSubview:loginLabel];
    [self.view addSubview:loginView];
  //1
    UIImageView *oneView = [[UIImageView alloc] initWithFrame:CGRectMake(0, loginView.origin.y + loginView.height + 10, ScreenWidth, 44)];
    oneView.image = [UIImage imageNamed:@"head_bg"];
    oneView.userInteractionEnabled = YES;
    
    UIImageView *starView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 24, 24)];
    starView.image = [UIImage imageNamed:@"部件 (1)"];
    [oneView addSubview:starView];
    
    UILabel *starLabel = [[UILabel alloc] initWithFrame:CGRectMake(55,15, 100, 14)];
    starLabel.font = [UIFont systemFontOfSize:14];
    starLabel.text = @"我的信息";
    [oneView addSubview:starLabel];
    pushView = [[UIImageView alloc]initWithFrame:CGRectMake(320 - 50, 7, 30, 30)];
    pushView.image = [UIImage imageNamed:@"back"];
    
    [oneView addSubview:pushView];
    
    [self.view addSubview:oneView];
 //2
    UIImageView *oneView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, oneView.origin.y + oneView.height, ScreenWidth, 44)];
    oneView1.image = [UIImage imageNamed:@"head_bg"];
    oneView1.userInteractionEnabled = YES;
    
    UIImageView *starView1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 30, 30)];
    starView1.image = [UIImage imageNamed:@"部件 (2)"];
    [oneView1 addSubview:starView1];
    
    UILabel *starLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(55,15, 100, 14)];
    starLabel1.font = [UIFont systemFontOfSize:14];
    starLabel1.text = @"我的信息";
    [oneView1 addSubview:starLabel1];
    
    [oneView1 addSubview:pushView];
    [self.view addSubview:oneView1];
    
    UIImageView *oneView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, oneView1.origin.y + oneView1.height + 10, ScreenWidth, 44)];
    oneView2.image = [UIImage imageNamed:@"head_bg"];
    oneView2.userInteractionEnabled = YES;
    
    UIImageView *starView2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 30, 30)];
    starView2.image = [UIImage imageNamed:@"部件 (3)"];
    [oneView2 addSubview:starView2];
    
    UILabel *starLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(55,15, 100, 14)];
    starLabel2.font = [UIFont systemFontOfSize:14];
    starLabel2.text = @"我的信息";
    [oneView2 addSubview:starLabel2];
    [oneView2 addSubview:pushView];
    [self.view addSubview:oneView2];
    
    
    UIImageView *oneView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, oneView2.origin.y + oneView2.height, ScreenWidth, 44)];
    oneView3.image = [UIImage imageNamed:@"head_bg"];
    oneView3.userInteractionEnabled = YES;
    
    UIImageView *starView3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 30, 30)];
    starView3.image = [UIImage imageNamed:@"部件 (4)"];
    [oneView3 addSubview:starView3];
    
    UILabel *starLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(55,15, 100, 14)];
    starLabel3.font = [UIFont systemFontOfSize:14];
    starLabel3.text = @"我的信息";
    [oneView3 addSubview:starLabel3];
    [oneView3 addSubview:pushView];
    [self.view addSubview:oneView3];
    
    UIImageView *oneView4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, oneView3.origin.y + oneView3.height + 10, ScreenWidth, 44)];
    oneView4.image = [UIImage imageNamed:@"head_bg"];
    oneView4.userInteractionEnabled = YES;
    
    UIImageView *starView4 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 30, 30)];
    starView4.image = [UIImage imageNamed:@"部件 (5)"];
    [oneView4 addSubview:starView4];
    
    UILabel *starLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(55,15, 100, 14)];
    starLabel4.font = [UIFont systemFontOfSize:14];
    starLabel4.text = @"我的信息";
    [oneView4 addSubview:starLabel4];
    [oneView4 addSubview:pushView];
    [self.view addSubview:oneView4];
    
    
    regestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    regestBtn.frame = CGRectMake(20, oneView4.origin.y + oneView4.height + 20, ScreenWidth - 40, 40);
    [regestBtn setBackgroundImage:[UIImage imageNamed:@"head_bg"] forState:UIControlStateNormal];
    UILabel *lab6 = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, ScreenWidth - 200 - 40, 40)];
    lab6.font = [UIFont boldSystemFontOfSize:17];
    lab6.textColor = [UIColor redColor];
    lab6.text = @"退出登录";
    lab6.textAlignment = NSTextAlignmentCenter;
    [regestBtn addSubview:lab6];
    [regestBtn addTarget:self action:@selector(regestBtn) forControlEvents:UIControlEventTouchUpInside];
    regestBtn.hidden = YES;
    [self.view addSubview:regestBtn];
    
    
}


-(void)regestBtn{
    UIAlertView *outAlert = [[UIAlertView alloc] initWithTitle:@"注销" message:@"是否要退出该帐号" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [outAlert show];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0) {
        headImage.hidden = YES;
        loginEndLabel.hidden = YES;
        loginBtn.hidden = NO;
        regestBtn.hidden = YES;
        loginLabel.text = @"欢迎来到投资管理系统";
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate.loginArray removeAllObjects];
        
        UINavigationController * hangqingNaviVC = [((AppDelegate *)[UIApplication sharedApplication].delegate)->mainTabViewController.leveyTabBarController.viewControllers objectAtIndex:1];
        [hangqingNaviVC popToRootViewControllerAnimated:YES];
    }
}




-(void) reloadData {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    if (delegate.loginArray.count > 0) {
        Customer *customer = [delegate.loginArray objectAtIndex:0];
        [loginLabel setText:customer.customerName];
        [loginEndLabel setText:[NSString stringWithFormat:@"成功登录！客户号:%@",customer.customerNum]];
        headImage.hidden = NO;
        loginEndLabel.hidden = NO;
        loginBtn.hidden = YES;
        regestBtn.hidden = NO;
    }
}
#pragma mark - user methods
-(void)push {
    LoginViewController *controller = [[LoginViewController alloc] init];
    controller.myViewController = self;
    controller.hidesBottomBarWhenPushed = YES;
    controller.customerName = loginLabel.text;
    [self.navigationController pushViewController:controller animated:YES];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
