//
//  DetailViewController.m
//  FinancialExpert
//
//  Created by mac on 14-9-17.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    navibarItem.title = self.titleName;
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
    
    [self reloadDataView];

}

-(void) reloadDataView {
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 54, 310, 180)];
    icon.image = [UIImage imageNamed:@"xd1"];
    [self.view addSubview:icon];
    
    UILabel *brandLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 244, 250, 13)];
    brandLabel.font = [UIFont boldSystemFontOfSize:13];
    [brandLabel setTextColor:[ColorUtil colorWithHexString:@"1b1b1b"]];
    [brandLabel setBackgroundColor:[UIColor clearColor]];
    brandLabel.text = self.name;
    [self.view addSubview:brandLabel];
    
    UILabel *gqNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 267, 200, 12)];
    gqNameLabel.font = [UIFont systemFontOfSize:12];
    [gqNameLabel setTextColor:[ColorUtil colorWithHexString:@"1b1b1b"]];
    [gqNameLabel setBackgroundColor:[UIColor clearColor]];
    gqNameLabel.text = self.gqName;
    [self.view addSubview:gqNameLabel];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 289, 200, 12)];
    dateLabel.font = [UIFont systemFontOfSize:12];
    [dateLabel setTextColor:[ColorUtil colorWithHexString:@"1b1b1b"]];
    [dateLabel setBackgroundColor:[UIColor clearColor]];
    dateLabel.text = self.date;
    [self.view addSubview:dateLabel];
    
    UILabel *markLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 311, 200, 12)];
    markLabel.font = [UIFont systemFontOfSize:12];
    [markLabel setTextColor:[ColorUtil colorWithHexString:@"1b1b1b"]];
    [markLabel setBackgroundColor:[UIColor clearColor]];
    markLabel.text = self.mark;
    [self.view addSubview:markLabel];
    
    UILabel *devLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 333, 200, 12)];
    devLabel.font = [UIFont systemFontOfSize:12];
    [devLabel setTextColor:[ColorUtil colorWithHexString:@"1b1b1b"]];
    [devLabel setBackgroundColor:[UIColor clearColor]];
    devLabel.text = self.describ;
    [self.view addSubview:devLabel];
    
}



-(void) push:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
