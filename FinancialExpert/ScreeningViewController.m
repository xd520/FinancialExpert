//
//  ScreeningViewController.m
//  FinancialExpert
//
//  Created by mac on 14-9-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ScreeningViewController.h"
#import "AppDelegate.h"
#import "ClassViewController.h"
#import "KxMenu.h"

@interface ScreeningViewController ()
{
    UILabel *classSelectLable;
    UILabel *dateSelectLable;
    NSString *classStr;
    NSString *rateStr1;
    NSString *rateStr2;
    NSString *dateStr1;
    NSString *dateStr2;
    QCheckBox *_check1;
    QCheckBox *_check2;
    NSMutableArray *array2;
    NSArray *array3;
    NSMutableDictionary *firstDictionary;
    NSInteger butTag;
    NSInteger index;
    NSString *classLableStr;
    NSString *dateSelectLableStr;
}
@end

@implementation ScreeningViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView {
    [super loadView];
    UIView *baseView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    baseView.backgroundColor = [ColorUtil colorWithHexString:@"f5f4f2"];
    self.view = baseView;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *date1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"3个月以下",@"dname",@"0",@"qxVal1",@"3",@"qxVal2", nil];
    NSDictionary *date2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"3-6个月",@"dname",@"3",@"qxVal1",@"6",@"qxVal2", nil];
    NSDictionary *date3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"6-12个月",@"dname",@"6",@"qxVal1",@"12",@"qxVal2", nil];
    NSDictionary *date4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"12-36个月",@"dname",@"12",@"qxVal1",@"36",@"qxVal2", nil];
    NSDictionary *date5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"不限",@"dname",@"",@"qxVal1",@"",@"qxVal2", nil];
    
    array3 = @[date5,date1,date2,date3,date4];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    firstDictionary = [userDefault objectForKey:@"firstDic"];
    
    if (firstDictionary == nil) {
        classStr = @"";
        rateStr1 = @"";
        rateStr2 = @"";
        dateStr1 = @"";
        dateStr2 = @"";
        index = 0;
        butTag = 0;
        classLableStr = @"全部";
        dateSelectLableStr = @"不限";
    } else {
        classStr = [firstDictionary objectForKey:@"2008"];
        classLableStr = [firstDictionary objectForKey:@"2009"];
        index = [[firstDictionary objectForKey:@"munNum"] integerValue];
        butTag = [[firstDictionary objectForKey:@"btnTag"] integerValue];
        dateSelectLableStr = [[array3 objectAtIndex:index] objectForKey:@"dname"];
    }
    
    
    UINavigationBar *navibar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    navibar.userInteractionEnabled = YES;
    //navibar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar.png"]];
    [navibar setBackgroundImage:[UIImage imageNamed:@"background.jpg"]  forBarMetrics:UIBarMetricsDefault];
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 40, 30);
    [leftBtn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    UINavigationItem *navibarItem = [[UINavigationItem alloc]init];
    navibarItem.title =@"产品筛选";
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
  //类别设置
    UIImageView *classImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 54, ScreenWidth - 20, 40)];
    [classImageView setImage:[[UIImage imageNamed:@"list_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]];
    [classImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(classSelect)];
    [classImageView addGestureRecognizer:singleTap];
    
    UILabel *classLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 13, 100, 14)];
    classLable.font = [UIFont boldSystemFontOfSize:14];
    classLable.textAlignment = NSTextAlignmentRight;
    classLable.textColor = [ColorUtil colorWithHexString:@"1b1b1b"];
    classLable.text = @"产品类型";
    [classImageView addSubview:classLable];
    
    classSelectLable = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - 20 - 110 - 15, 14, 100, 12)];
    classSelectLable.font = [UIFont systemFontOfSize:12];
    classSelectLable.textAlignment = NSTextAlignmentRight;
    classSelectLable.textColor = [ColorUtil colorWithHexString:@"7f7f7f"];
    classSelectLable.text = classLableStr;
    [classImageView addSubview:classSelectLable];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 20 - 10 - 15, 12, 15, 15)];
    [iconImageView setImage:[UIImage imageNamed:@"btn_mine_right"]];
    [classImageView addSubview:iconImageView];
    
    [self.view addSubview:classImageView];
    
    
    UILabel *rateLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 104, 100, 14)];
    rateLable.font = [UIFont boldSystemFontOfSize:14];
    rateLable.textAlignment = NSTextAlignmentRight;
    rateLable.textColor = [ColorUtil colorWithHexString:@"1b1b1b"];
    rateLable.text = @"预期年化收益率";
    [self.view addSubview:rateLable];
    
  //年利率
    
    
    _check1 = [[QCheckBox alloc] initWithDelegate:self];
    _check1.frame = CGRectMake(120, 100,72,22);
    [_check1 setTitle:@"小于7%" forState:UIControlStateNormal];
    [_check1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _check1.tag = 1;
    [_check1.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    //[_check1 setChecked:YES];
    [self.view addSubview:_check1];
    
    _check2 = [[QCheckBox alloc] initWithDelegate:self];
    _check2.frame = CGRectMake(195,100,102,22);
    [_check2 setTitle:@"大于等于7%" forState:UIControlStateNormal];
    _check2.tag = 2;
    [_check2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_check2.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    if (butTag ==1) {
        [_check1 setChecked:YES];
    } else if (butTag ==2) {
    [_check2 setChecked:YES];
    }
    
    
    [self.view addSubview:_check2];
    
  //期限处理
    
    UIImageView *dateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 132, ScreenWidth - 20, 40)];
    [dateImageView setImage:[[UIImage imageNamed:@"list_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]];
    [dateImageView setUserInteractionEnabled:YES];
    
    UILabel *dateLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 13, 100, 14)];
    dateLable.font = [UIFont boldSystemFontOfSize:14];
    dateLable.textAlignment = NSTextAlignmentRight;
    dateLable.textColor = [ColorUtil colorWithHexString:@"1b1b1b"];
    dateLable.text = @"期限";
    [dateImageView addSubview:dateLable];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    UIButton *dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dateBtn.frame = CGRectMake(115, 0, ScreenWidth - 20 - 105, 40);
    
    [dateBtn addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    dateSelectLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 55 - 110, 40)];
    dateSelectLable.font = [UIFont systemFontOfSize:12];
    dateSelectLable.textAlignment = NSTextAlignmentRight;
    dateSelectLable.textColor = [ColorUtil colorWithHexString:@"7f7f7f"];
    dateSelectLable.text = dateSelectLableStr;
    [dateBtn addSubview:dateSelectLable];
    
    UIImageView *dateSelectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 55 - 105, 12, 15, 15)];
    [dateSelectImageView setImage:[UIImage imageNamed:@"down_dark"]];
    [dateBtn addSubview:dateSelectImageView];
    
    [dateImageView addSubview:dateBtn];
    
    [self.view addSubview:dateImageView];
    
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(20, 300, ScreenWidth - 40, 40);
    [sureBtn setImage:[UIImage imageNamed:@"btn_ok"] forState:UIControlStateNormal];
   [sureBtn addTarget:self action:@selector(rightBtnPush:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    
    
}



- (void)showMenu:(UIButton *)sender
{
    array2 = [[NSMutableArray alloc] init];
    for (int i = 0; i < array3.count; i++) {
      KxMenuItem *kx =
        [KxMenuItem menuItem:[[array3 objectAtIndex:i] objectForKey:@"dname"]
                       image:[UIImage imageNamed:@"action_icon"]
                      target:self
                      action:@selector(pushMenuItem:)];
       // kx.target = @"i";
        
        [array2 addObject:kx];
    }
    
    
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(230, 102, 50, 60)
                 menuItems:array2];
}

- (void) pushMenuItem:(KxMenuItem *)sender
{
    
    [dateSelectLable setText:sender.title];
    for (int i = 0; i < array3.count; i++) {
        if ([sender.title isEqualToString:[[array3 objectAtIndex:i] objectForKey:@"dname"]] == YES) {
            dateStr1 = [[array3 objectAtIndex:i] objectForKey:@"qxVal1"];
            dateStr2 = [[array3 objectAtIndex:i] objectForKey:@"qxVal2"];
            index = i;
        }

    }
    
   // dateSelectLable = [NSString stringWithFormat:@"%@",sender];
    
    NSLog(@"999999%@", sender.title);
}




#pragma mark - QCheckBoxDelegate

- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked {
    
    //只能单选或不选
    if (_check2.checked == YES && _check1.checked == YES) {
        if (_check1 ==checkbox) {
        [_check2 setChecked:NO];
        } else {
         [_check1 setChecked:NO];
        
        }
    }
    
    
    if (checked == 1) {
        if (checkbox.tag == 1) {
            rateStr1 = @"0";
            rateStr2 = @"7";
            butTag = checkbox.tag;
        } else if (checkbox.tag == 2) {
            rateStr1 = @"7";
            rateStr2 = @"100";
            butTag = checkbox.tag;
        }
    } else {
        rateStr1 = @"";
        rateStr2 = @"";
        butTag = 0;
    }
    
    
       // NSLog(@"did tap on CheckBox:%d checked:%d", checkbox.tag, checked);
   // NSLog(@"%@--676767--%@",rateStr1,rateStr2);
}




#pragma mark - Detegate
- (void)reloadTableView:(NSDictionary *)categoryData
{
    [classSelectLable setText:[categoryData objectForKey:@"2009"]];
    classStr = [categoryData objectForKey:@"2008"];
}


-(void)classSelect {
    ClassViewController *controller = [[ClassViewController alloc] init];
     controller.delegate = self;
    
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];

}

-(void) push:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void) rightBtnPush:(UIButton *)btn{
    
    //[dateSelectLable setText:dateStr1];
    
    NSString *butStr = [NSString stringWithFormat:@"%li",(long)butTag];
    NSString *indexStr = [NSString stringWithFormat:@"%li",(long)index];
    firstDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:classSelectLable.text,@"2009",classStr,@"2008",butStr,@"btnTag",indexStr,@"munNum", nil];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:firstDictionary forKey:@"firstDic"];
    [userDefault synchronize];
    
    
    
    NSString *strClass = [firstDictionary objectForKey:@"2008"];
    dateStr1 = [[array3 objectAtIndex:index] objectForKey:@"qxVal1"];
    dateStr2 = [[array3 objectAtIndex:index] objectForKey:@"qxVal2"];
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:strClass,@"2008",rateStr1,@"gzllVal1",rateStr2,@"gzllVal2",dateStr1,@"qxVal1",dateStr2,@"qxVal2", nil];
    [self.delegate reloadTableView:dic];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)removefirstDictionary {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:@"firstDic"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    firstDictionary = nil;
    
}

@end
