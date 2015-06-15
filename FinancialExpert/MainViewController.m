//
//  MainViewController.m
//  CaltureEquitySystem
//
//  Created by mac on 14-9-4.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MainViewController.h"
#import "ListViewController.h"
#import "InvestViewController.h"
#import "ManageViewController.h"
#import "MyMineViewController.h"
#import "LeveyTabBarController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize leveyTabBarController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    ListViewController *firstVC = [[ListViewController alloc] init];
	InvestViewController *secondVC = [[InvestViewController alloc] init];
	ManageViewController *thirdVC = [[ManageViewController alloc] init];
	MyMineViewController *fourthVC = [[MyMineViewController alloc] init];
     //firstVC.title =@"重庆文化产权交易系统";
    
    UINavigationController *nc1 = [[UINavigationController alloc] initWithRootViewController:firstVC];
    [nc1.navigationBar setBackgroundImage:[UIImage imageNamed:@"background.jpg"]  forBarMetrics:UIBarMetricsDefault];
    UILabel *productName = [[UILabel alloc] initWithFrame:CGRectMake(50, 15, 220, 18)];
    productName.textAlignment = NSTextAlignmentCenter;
    productName.textColor = [UIColor whiteColor];
    productName.font = [UIFont boldSystemFontOfSize:18];
    productName.text = @"金融资产客户端";
    [nc1.navigationBar addSubview:productName];
    
   // nc1.navigationBar.backgroundColor = [ColorUtil colorWithHexString:@"ff0000"];
    UINavigationController *nc2 = [[UINavigationController alloc] initWithRootViewController:secondVC];
    UINavigationController *nc3 = [[UINavigationController alloc] initWithRootViewController:thirdVC];
    [nc3.navigationBar setBackgroundImage:[UIImage imageNamed:@"background.jpg"]  forBarMetrics:UIBarMetricsDefault];
    UILabel *buessName = [[UILabel alloc] initWithFrame:CGRectMake(50, 15, 220, 18)];
    buessName.textAlignment = NSTextAlignmentCenter;
    buessName.textColor = [UIColor whiteColor];
    buessName.font = [UIFont boldSystemFontOfSize:18];
    buessName.text = @"我的投资";
    [nc3.navigationBar addSubview:buessName];
    
    
    UINavigationController *nc4 = [[UINavigationController alloc] initWithRootViewController:fourthVC];
	nc1.delegate = self;
    nc2.delegate = self;
    nc3.delegate = self;
    nc4.delegate = self;
	NSArray *ctrlArr = [NSArray arrayWithObjects:nc1,nc2,nc3,nc4,nil];
    
	NSMutableDictionary *imgDic = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic setObject:[UIImage imageNamed:@"b1.jpg"] forKey:@"Default"];
	[imgDic setObject:[UIImage imageNamed:@"c1.jpg"] forKey:@"Highlighted"];
	[imgDic setObject:[UIImage imageNamed:@"c1.jpg"] forKey:@"Seleted"];
	NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic2 setObject:[UIImage imageNamed:@"b2.jpg"] forKey:@"Default"];
	[imgDic2 setObject:[UIImage imageNamed:@"c2.jpg"] forKey:@"Highlighted"];
	[imgDic2 setObject:[UIImage imageNamed:@"c2.jpg"] forKey:@"Seleted"];
	NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic3 setObject:[UIImage imageNamed:@"b3.jpg"] forKey:@"Default"];
	[imgDic3 setObject:[UIImage imageNamed:@"c3.jpg"] forKey:@"Highlighted"];
	[imgDic3 setObject:[UIImage imageNamed:@"c3.jpg"] forKey:@"Seleted"];
	NSMutableDictionary *imgDic4 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic4 setObject:[UIImage imageNamed:@"b4.jpg"] forKey:@"Default"];
	[imgDic4 setObject:[UIImage imageNamed:@"c4.jpg"] forKey:@"Highlighted"];
	[imgDic4 setObject:[UIImage imageNamed:@"c4.jpg"] forKey:@"Seleted"];
	
	NSArray *imgArr = [NSArray arrayWithObjects:imgDic,imgDic2,imgDic3,imgDic4,nil];
	
	leveyTabBarController = [[LeveyTabBarController alloc] initWithViewControllers:ctrlArr imageArray:imgArr];
	//[leveyTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"c-2-1.png"]];
	[leveyTabBarController setTabBarTransparent:YES];
    [self.view addSubview:leveyTabBarController.view];
    ((AppDelegate *)[UIApplication sharedApplication].delegate)->mainTabViewController = self;
}

#pragma mark - UINavigationController Delegate Methods
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController.hidesBottomBarWhenPushed)
    {
        [self.leveyTabBarController hidesTabBar:YES animated:YES];
        navigationController.navigationBarHidden = YES;
    }
    else
    {
        [self.leveyTabBarController hidesTabBar:NO animated:YES];
        navigationController.navigationBarHidden = NO;
        //[self.leveyTabBarController ]
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
