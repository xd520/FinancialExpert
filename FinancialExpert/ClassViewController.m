//
//  ClassViewController.m
//  FinancialExpert
//
//  Created by mac on 14-9-16.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ClassViewController.h"
#import "AppDelegate.h"
#define funCode @"106002"
#import "DetailViewController.h"


@interface ClassViewController ()
{
    UITableView *tableView;
    MBProgressHUD *HUD;
    NSString *start;
    NSString *startBak;
    NSString *limit;
    NSMutableArray *dataList;
    BOOL hasMore;
    UITableViewCell *moreCell;

}
@end

@implementation ClassViewController

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
    navibarItem.title =@"选择类别信息";
    navibarItem.leftBarButtonItem= leftItem;
   // self.navigationItem.rightBarButtonItem = leftItem;
    [navibar pushNavigationItem:navibarItem animated:YES];
    [self.view addSubview:navibar];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, ScreenHeight - navibar.height)];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView setBackgroundColor:[UIColor clearColor]];    tableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:tableView];
    
    //添加指示器及遮罩
    HUD = [[MBProgressHUD alloc] initWithView:tableView];
    HUD.dimBackground = YES;
    HUD.delegate = self;
    HUD.labelText = @"加载中";
    [HUD show:YES];
    [self.view addSubview:HUD];
    //获取类别信息
    [self requestCategoryList:funCode start:@"" limit:rtKeyListStr tag:kBusinessTagGetFun2List];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
#endif

    
}


#pragma mark - UITableView DataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([dataList count] == 0) {
        return 1;
    } else if (hasMore) {
        return [dataList count] + 1;
    } else {
        return [dataList count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *RepairCellIdentifier = @"RepairCellIdentifier";
    UITableViewCell *cell;
    cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    if ([indexPath row] == [dataList count]) {
        moreCell = [tableView dequeueReusableCellWithIdentifier:@"loadMoreCell"];
        moreCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"loadMoreCell"];
        [moreCell setBackgroundColor:[UIColor clearColor]];
        moreCell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *toastLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 160, 59)];
        [toastLabel setFont:[UIFont systemFontOfSize:12]];
        toastLabel.backgroundColor = [UIColor clearColor];
        [toastLabel setTextColor:[ColorUtil colorWithHexString:@"999999"]];
        toastLabel.numberOfLines = 0;
        toastLabel.text = @"更多...";
        toastLabel.textAlignment = UITextAlignmentCenter;
        [moreCell.contentView addSubview:toastLabel];
        return moreCell;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:RepairCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setBackgroundColor:[UIColor clearColor]];
            //添加背景View
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
            [backView setBackgroundColor:[ColorUtil colorWithHexString:@"fafafa"]];
            //品牌
            if (indexPath.row == 0) {
                UILabel *brandLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 170, 39)];
                brandLabel.font = [UIFont boldSystemFontOfSize:15];
                [brandLabel setTextColor:[ColorUtil colorWithHexString:@"646464"]];
                [brandLabel setBackgroundColor:[UIColor clearColor]];
                brandLabel.text = @"全部";
                [backView addSubview:brandLabel];
                UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(320 - 16 - 15, 12, 15, 15)];
                [iconImageView setImage:[UIImage imageNamed:@"btn_mine_right"]];
                [backView addSubview:iconImageView];
                UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 320, 1)];
                [subView setBackgroundColor:[ColorUtil colorWithHexString:@"dcdcdc"]];
                if ([indexPath row] != [dataList count] - 1) {
                    [backView addSubview:subView];
                }
                
                [cell.contentView addSubview:backView];
            } else {
                UILabel *brandLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 170, 39)];
                brandLabel.font = [UIFont boldSystemFontOfSize:15];
                [brandLabel setTextColor:[ColorUtil colorWithHexString:@"646464"]];
                [brandLabel setBackgroundColor:[UIColor clearColor]];
                brandLabel.text = [[dataList objectAtIndex:[indexPath row]] objectForKey:@"2009"];
                [backView addSubview:brandLabel];
                UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(320 - 16 - 15, 12, 15, 15)];
                [iconImageView setImage:[UIImage imageNamed:@"btn_mine_right"]];
                [backView addSubview:iconImageView];
                UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 320, 1)];
                [subView setBackgroundColor:[ColorUtil colorWithHexString:@"dcdcdc"]];
                if ([indexPath row] != [dataList count] - 1) {
                    [backView addSubview:subView];
                }
                
                [cell.contentView addSubview:backView];
            
            
            }
            
            
            
        }
    }
    return cell;
}
#pragma mark - Table Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == [dataList count]) {
        return 40;
    } else {
        return 40;
    }
    return 95;
}
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [dataList count] + 1) {
        for (UILabel *label in [moreCell.contentView subviews]) {
            if ([label.text isEqualToString:@"正在加载中..."]) {
                
            } else {
                label.text = @"正在加载中...";
                [self requestCategoryList:funCode start:@"" limit:rtKeyListStr tag:kBusinessTagGetFun2List];
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
            }
        }
    } else {
        
        
        
        
        [self.delegate reloadTableView:[dataList objectAtIndex:[indexPath row]]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - Request Methods
//获取品牌列表
- (void)requestCategoryList:(NSString *)_userId start:(NSString *)_start limit:(NSString *)_limit tag:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求品牌列表");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    [paraDic setObject:_userId forKey:@"head"];
    [paraDic setObject:_start forKey:@"jsonParamStr"];
    [paraDic setObject:_limit forKey:@"rtKeyListStr"];
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:_tag owner:self];
    
}

#pragma mark - Recived Methods
//处理品牌列表
- (void)recivedCategoryList:(NSMutableArray *)dataArray
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"处理品牌列表数据");
    if ([dataList count] > 0) {
        for (NSDictionary *object in dataArray) {
            [dataList addObject:object];
        }
    } else {
        dataList = dataArray;
    }
       [tableView reloadData];
    }
#pragma mark - NetworkModuleDelegate Methods
-(void)beginPost:(kBusinessTag)tag{
    
}
-(void)endPost:(NSString *)result business:(kBusinessTag)tag{
    NSLog(@"%s %d 收到数据:%@", __FUNCTION__, __LINE__, result);
    NSMutableDictionary *jsonDic = [result JSONValue];
    NSMutableArray *dataArray = [jsonDic objectForKey:@"object"];
	if (tag==kBusinessTagGetFun2List ) {
        [HUD hide:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue] == 0) {
            //数据异常处理
            [self.view makeToast:@"获取品牌失败"];
        } else {
            NSDictionary *firstDic = [[NSDictionary alloc] initWithObjectsAndKeys:@"",@"507",@"",@"508",@"",@"2008",@"全部",@"2009", nil];
            NSMutableArray *dataTotalArray = [[NSMutableArray alloc] initWithObjects:firstDic, nil];
            [dataTotalArray addObjectsFromArray:dataArray];
            [self recivedCategoryList:dataTotalArray];
        }
    }
}
-(void)errorPost:(NSError *)err business:(kBusinessTag)tag{
    NSLog(@"%s Error:%@", __FUNCTION__, @"连接数据服务器超时");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法连接" message:@"您所在地的网络信号微弱，无法连接到服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    if (tag == kBusinessTagGetFun2List) {
        [HUD hide:YES];
    }
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
