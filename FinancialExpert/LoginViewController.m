//
//  LoginViewController.m
//  FinancialExpert
//
//  Created by mac on 14-9-22.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "Base64.h"
#import "OpenUDID.h"
#import "LeveyTabBarController.h"
#import "ListViewController.h"
#import "MyMineViewController.h"
#import "InvestViewController.h"
#import "ManageViewController.h"
#import "MainViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize customerName;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.customerName = @"欢迎来到投资管理系统!!!!";
    }
    return self;
}

-(void)loadView {
    [super loadView];
    UIView *baseView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    baseView.backgroundColor = [ColorUtil colorWithHexString:@"f5f4f2"];
    //baseView.backgroundColor = [UIColor grayColor];
    self.view = baseView;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    UINavigationBar *navibar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    navibar.userInteractionEnabled = YES;
    //navibar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar.png"]];
    [navibar setBackgroundImage:[UIImage imageNamed:@"background.jpg"]  forBarMetrics:UIBarMetricsDefault];
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 21, 21);
    [leftBtn setImage:[UIImage imageNamed:@"head_icon_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    UINavigationItem *navibarItem = [[UINavigationItem alloc]init];
    navibarItem.title = @"登录";
    navibarItem.leftBarButtonItem= leftItem;
    // self.navigationItem.rightBarButtonItem = leftItem;
    [navibar pushNavigationItem:navibarItem animated:YES];
    [self.view addSubview:navibar];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
#endif
    
    UIView *numLable = [[UIView alloc] initWithFrame:CGRectMake(0, 44 , ScreenWidth, 100)];
    numLable.userInteractionEnabled = YES;
    numLable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"head_bg"]];
    UIImageView *fenxian = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50, ScreenWidth, 1)];
    fenxian.image = [UIImage imageNamed:@"line_fenge"];
    [numLable addSubview:fenxian];
    numLable.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:numLable];
    
    phoneNum = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 20, 20)];
    phoneNum.image = [UIImage imageNamed:@"icon_zcdh_nor"];
    [numLable addSubview:phoneNum];
    
    phoneNumText = [[UITextField alloc] initWithFrame:CGRectMake(49, 0, ScreenWidth - 50, 50)];
    phoneNumText.clearButtonMode = UITextFieldViewModeAlways;
    phoneNumText.placeholder = @"手机号码";
    phoneNumText.font = [UIFont systemFontOfSize:14];
    phoneNumText.textColor = [ColorUtil colorWithHexString:@"5e5f63"];
    phoneNumText.keyboardType = UIKeyboardTypeNamePhonePad;
    phoneNumText.delegate = self;
    [numLable addSubview:phoneNumText];
    
    passWordText = [[UITextField alloc] initWithFrame:CGRectMake(49, 50, ScreenWidth - 50, 49)];
    passWordText.delegate = self;
    passWordText.clearButtonMode = UITextFieldViewModeAlways;
    passWordText.font = [UIFont systemFontOfSize:14];
    passWordText.textColor = [ColorUtil colorWithHexString:@"5e5f63"];
    passWordText.keyboardType = UIKeyboardTypeNamePhonePad;
    passWordText.secureTextEntry = YES;
    passWordText.placeholder = @"密码";
    [numLable addSubview:passWordText];
    
    _button1 =[UIButton buttonWithType:UIButtonTypeCustom];
    _button1.frame = CGRectMake(30, 195, 27, 27);
    [_button1 addTarget:self action:@selector(defaultCheck:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button1];
    
    UILabel *remenberPassWordLable = [[UILabel alloc] initWithFrame:CGRectMake(30, 229, 60, 13)];
    remenberPassWordLable.font = [UIFont systemFontOfSize:13];
    remenberPassWordLable.text = @"记住密码";
    [self.view addSubview:remenberPassWordLable];
    
    
    passWord = [[UIImageView alloc] initWithFrame:CGRectMake(20, 65, 20, 20)];
    passWord.image = [UIImage imageNamed:@"icon_zcmm_nor"];
    [numLable addSubview:passWord];
    
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(121, 195 , ScreenWidth - 184, 47);
    //initWithFrame:CGRectMake(0, 0, 21, 21)];
    [loginBtn setImage:[UIImage imageNamed:@"btn_dl"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    [self readUserInfo];

}


-(void)saveData {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:phoneNumText.text forKey:@"name"];
    [userDefault setObject:passWordText.text forKey:@"password"];
    [userDefault setBool:self.button1.selected forKey:@"isRemember"];
    [userDefault synchronize];
    
}

-(void)readUserInfo {
    //读取用户信息，是否保存信息状态和登陆状态
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    phoneNumText.text = [userDefault objectForKey:@"name"];
    passWordText.text = [userDefault objectForKey:@"password"];
    BOOL isOpen = [userDefault boolForKey:@"isRemember"];
    
    [self.button1 setSelected:isOpen];              //设置与退出时相同的状态
    [self.button1 setImage:[UIImage imageNamed:@"select_0.png"] forState:UIControlStateNormal];
    [self.button1 setImage:[UIImage imageNamed:@"select_1.png"] forState:UIControlStateSelected];
}

-(void)removeUserInfo {
    //当不保存用户信息时，清除记录
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:@"name"];
    [userDefault removeObjectForKey:@"password"];
    [userDefault removeObjectForKey:@"isRemember"];
}

-(void)defaultCheck:(UIButton *)button {
    
    if (self.button1.selected == YES) {              //设置按钮点击事件，是否保存用户信息，点击一次改变它的状态---selected,normal,同时在不同状态显示不同图片
        [self.button1 setSelected:NO];
        [self.button1 setImage:[UIImage imageNamed:@"select_0.png"] forState:UIControlStateNormal];
    }else {
        [self.button1 setSelected:YES];
        [self.button1 setImage:[UIImage imageNamed:@"select_1.png"] forState:UIControlStateSelected];
    }
}



#pragma mark - UITextField Delegate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (phoneNumText == textField) {
        phoneNum.image = [UIImage imageNamed:@"icon_zcdh_pre"];
    } else if (passWordText == textField) {
        passWord.image = [UIImage imageNamed:@"icon_zcmm_pre"];
        //[passWordText becomeFirstResponder];
        //[passWordText becomeFirstResponder];
    }
}



- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (phoneNumText == textField) {
        phoneNum.image = [UIImage imageNamed:@"icon_zcdh_nor"];
    } else if(passWordText == textField){
        passWord.image = [UIImage imageNamed:@"icon_zcmm_nor"];
    }
}

#pragma mark - UITextField Delegate Methods
- (void)resignKeyboard:(id)sender
{
    [phoneNumText resignFirstResponder];
    [passWordText resignFirstResponder];
    
}


#pragma mark - Request Methods
//请求登陆
- (void)requestLogin:(NSString *)_userName withPass:(NSString *)_password tag:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求登陆");
    NSString* openUDID = [OpenUDID value];
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    [paraDic setObject:_userName forKey:@"username"];
    [paraDic setObject:_password forKey:@"password"];
    [paraDic setObject:openUDID forKey:@"mac"];
    
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:_tag owner:self];
    //添加指示器及遮罩
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.dimBackground = YES;
    HUD.delegate = self;
    HUD.labelText = @"登录中";
    [HUD show:YES];
    [self.view addSubview:HUD];
    
    if (self.button1.selected == YES) {
        [self saveData];
        //[self.button2 setSelected:NO];
    }else {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [self removeUserInfo];
        [userDefault setBool:self.button1.selected forKey:@"isRemember"];
        [userDefault synchronize];
    }
    
}

#pragma mark - Recived Methods
//处理登陆信息
- (void)recivedLogin:(NSMutableDictionary *)data
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"处理登陆信息");
    
    
    
    //if ([[data objectForKey:@"khh"]  isEqualToString:@""] == 0) {
    //登陆失败处理
    //[HUD hide:YES];
    //[self.view makeToast:[data objectForKey:@"returnMsg"]];
    
    // } else {
    // NSLog(@"%@",data);
    [HUD hide:YES];
    InvestViewController *controller = [[InvestViewController alloc] init];
    controller.leveyTabBarController.selectedIndex = 1;
    //AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    // ProductList *product = [ProductList productUserId:[data objectForKey:@"userId"]];
    //[delegate.arrayList addObject:product];
    //FirstViewController *controller = [[FirstViewController alloc] init];
    //[self.navigationController pushViewController:controller animated:YES];
    // }
    
}

#pragma mark - NetworkModuleDelegate Methods
-(void)beginPost:(kBusinessTag)tag{
    
}
-(void)endPost:(NSString *)result business:(kBusinessTag)tag{
    NSLog(@"%s %d 收到数据:%@", __FUNCTION__, __LINE__, result);
    NSMutableDictionary *jsonDic = [result JSONValue];
    //NSMutableArray *dataArray = [jsonDic objectForKey:@"objec"];
	if (tag==kBusinessTagUserLogin ) {
        
        [HUD hide:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [self.view makeToast:[jsonDic objectForKey:@"msg"]];
            NSLog(@"%@",self.customerName);
            [self.myViewController.loginLabel setText:@"欢迎来到投资管理系统!!!!"];

        } else {
           
            
            BOOL logRueslt = [[jsonDic objectForKey:@"success"] boolValue];
            NSString *khh = [[jsonDic objectForKey:@"object"] objectForKey:@"khh"];
             NSString *khid = [[jsonDic objectForKey:@"object"] objectForKey:@"sessionId"];
             NSString *khxm = [[jsonDic objectForKey:@"object"] objectForKey:@"khxm"];
            Customer *customer = [Customer CustomerInformation:khxm withNum:khh withId:khid withSueccss:logRueslt];
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            [delegate.loginArray addObject:customer];
            
            [self.view makeToast:[jsonDic objectForKey:@"msg"]];
            
            [self.myViewController.loginLabel setText:[[jsonDic objectForKey:@"object"] objectForKey:@"khxm"]];
             [self.navigationController popViewControllerAnimated:YES];
//            InvestViewController *controller = [[InvestViewController alloc] init];
            UINavigationController * hangqingNaviVC = [((AppDelegate *)[UIApplication sharedApplication].delegate)->mainTabViewController.leveyTabBarController.viewControllers objectAtIndex:1];
//            [hangqingNaviVC pushViewController:controller animated:YES];
            InvestViewController * controller = [hangqingNaviVC.viewControllers firstObject];
            if([controller respondsToSelector:@selector(reloadData)]){
                [controller reloadData];
            }
        }
    }
    
}
-(void)errorPost:(NSError *)err business:(kBusinessTag)tag{
    NSLog(@"%s Error:%@", __FUNCTION__, @"连接数据服务器超时");
    [HUD hide:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法连接" message:@"您所在地的网络信号微弱，无法连接到服务器" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

-(void) loginButton{
    
    [phoneNumText resignFirstResponder];
    [passWordText resignFirstResponder];
    NSLog(@"%@",phoneNumText.text);
    NSLog(@"%@",passWordText.text);
    
    NSString *pwdRegex = @"^[a-zA-Z0-9_]{6,14}$";
    NSPredicate *pwdTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",pwdRegex];
    if ([phoneNumText.text isEqualToString:@""] || phoneNumText.text == nil) {
        [self.view makeToast:@"请输入帐号"];
        //[phoneNumText becomeFirstResponder];
        
    } else if ([passWordText.text isEqualToString:@""] || passWordText.text == nil) {
        [self.view makeToast:@"请输入密码"];
        //[passWordText becomeFirstResponder];
    } else if (![pwdTest evaluateWithObject:passWordText.text]) {
        [self.view makeToast:@"请输入正确的密码"];
        //[passWordText becomeFirstResponder];
    } else {
        [self resignKeyboard:nil];
        //调用单例的网络模块执行登陆
        Base64 * passwordBase64 = [Base64 encodeBase64String:passWordText.text];
        NSLog(@"%@",passwordBase64.strBase64);
        [self requestLogin:phoneNumText.text withPass:passwordBase64.strBase64 tag:kBusinessTagUserLogin];
    }
    
}

#pragma mark - 消除键盘

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [phoneNumText resignFirstResponder];
    [passWordText resignFirstResponder];
}



-(void) push:(UIButton *)btn{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    if (delegate.loginArray.count > 0) {
        Customer *cumer = [delegate.loginArray objectAtIndex:0];
        if (cumer.loginSueccss == 1) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
        MyMineViewController *controller = [[MyMineViewController alloc] init];
        controller.leveyTabBarController.selectedIndex = 3;
    }
    } else {
        if (self.myViewController.leveyTabBarController.selectedIndex == 3) {
             [self.navigationController popToRootViewControllerAnimated:YES];
            
        } else if(self.investViewController.leveyTabBarController.selectedIndex == 1) {
            MyMineViewController *controller = [[MyMineViewController alloc] init];
            //controller.leveyTabBarController.tabBarHidden = NO;
            controller.leveyTabBarController.selectedIndex = 3;
       
        } 
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
