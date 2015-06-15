//
//  InvestViewController.m
//  FinancialExpert
//
//  Created by mac on 14-9-15.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "InvestViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "DetailViewController.h"
#define funCode1 @"306004"
//#define rtKeyDelegateStr @"755,527,2007,2008,750,511,2010,1894,1027,795,1140,2002,1731,1017,886,528,1013,1538,1536,861"
#define rtKeyDelegateStr @"680,683,1898,684,681,525,682,750,2010,795"


@interface InvestViewController ()
{
    UIView *view1;
    UIView *view2;
    UISegmentedControl *segmentedControl;
    MBProgressHUD *HUD;
    NSMutableArray *dataList;
    UITableView *table;
    NSMutableArray *dataListNot;
    UITableView *tableNot;
}
@end

@implementation InvestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      [[self.navigationController.childViewControllers lastObject]popNavigationItemAnimated:YES];  
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
    //[self reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"金融资产客户端";
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"当日投资",@"历史投资",nil];
    segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    
    segmentedControl.frame = CGRectMake(20,10, ScreenWidth - 40, 40);
    if (segmentedControl.selectedSegmentIndex != 0 && segmentedControl.selectedSegmentIndex != 1) {
        segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
    }
    
    
    segmentedControl.tintColor = [UIColor brownColor];
    
    segmentedControl.multipleTouchEnabled=NO;
    segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
    
    
    [segmentedControl addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];
    
    view1 = [[UIView alloc] initWithFrame:CGRectMake(0,segmentedControl.origin.y + segmentedControl.size.height + 10, ScreenWidth, ScreenHeight - segmentedControl.origin.y - segmentedControl.size.height - 49)];
    //view1.backgroundColor = [UIColor redColor];
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [view1 addGestureRecognizer:recognizer];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, view1.height)];
    table.dataSource = self;
    table.delegate = self;
    
    
    [view1 addSubview:table];
    
    [self.view addSubview:view1];
    
    view2 = [[UIView alloc] initWithFrame:CGRectMake(0, segmentedControl.origin.y + segmentedControl.size.height, ScreenWidth, ScreenHeight - segmentedControl.origin.y - segmentedControl.size.height - 49 - 20 - self.navigationController.navigationBar.height)];
    view2.backgroundColor = [UIColor clearColor];
    view2.hidden = YES;
    
    UISwipeGestureRecognizer *recognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizerLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [view2 addGestureRecognizer:recognizerLeft];
    
    tableNot = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,view2.height)];
    tableNot.dataSource = self;
    tableNot.delegate = self;
    
    
    [view2 addSubview:tableNot];
    
    
    [self.view addSubview:view2];
    
    [self.view addSubview:segmentedControl];
    
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
#endif
    
    //添加指示器及遮罩
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.dimBackground = YES;
    HUD.delegate = self;
    HUD.labelText = @"加载中";
    [HUD show:YES];
    [self.view addSubview:HUD];
    
//    [self reloadData];
    
}

-(void) reloadData {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    if (delegate.loginArray.count > 0) {
        Customer *customer = [delegate.loginArray objectAtIndex:0];
        if (customer.loginSueccss == 1) {

            //获取类别信息
            NSArray *object =@[customer.customerNum,@"",@"",@"",@"O",@"",@"",@"",@"",@"",@"",@""];
            NSArray *object1 =@[customer.customerNum,@"",@"",@"",@"W",@"",@"",@"",@"",@"",@"",@""];
            
            
             NSArray *keys =@[@"605",@"2007",@"2012",@"864",@"755",@"705",@"1017",@"680",@"683",@"1894",@"9109",@"9083"];
            NSDictionary *requestStr = [[NSDictionary alloc] initWithObjects:object forKeys:keys];
            
             NSDictionary *requestStr1 = [[NSDictionary alloc] initWithObjects:object1 forKeys:keys];
            
            [self requestCategoryList:funCode1 start:requestStr limit:rtKeyDelegateStr tag:kBusinessTagGetFun2List];
            
            [self requestCategoryList:funCode1 start:requestStr1 limit:rtKeyDelegateStr tag:kBusinessTagGetFun2ListAgain];
            
        } else {
        LoginViewController *controller = [[LoginViewController alloc] init];
            controller.investViewController = self;
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
        }
        
    }else {
        [dataList removeAllObjects];
        [table reloadData];
        
        LoginViewController *controller = [[LoginViewController alloc] init];
            controller.investViewController = self;
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        
    }

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row;
    if (tableView == table) {
        row =  dataList.count;
    } else if (tableView == tableNot) {
    row =  dataListNot.count;
    
    }
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tableView setScrollEnabled:NO]; tableView 不能滑动
    static NSString *RepairCellIdentifier = @"RepairCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RepairCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RepairCellIdentifier];
    }
    if (tableView == table) {
    cell.textLabel.text = [[dataList objectAtIndex:indexPath.row] objectForKey:@"2010"];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.detailTextLabel.text = [[dataList objectAtIndex:indexPath.row] objectForKey:@"795"];
    UIImageView *timeImage = [[UIImageView alloc] initWithFrame:CGRectMake(200, 8, 14, 14)];
    timeImage.image = [UIImage imageNamed:@"time"];
    [cell.contentView addSubview:timeImage];
    
    UILabel *postTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 10, 100, 10)];
    postTimeLabel.font = [UIFont systemFontOfSize:10];
    postTimeLabel.text = [NSString stringWithFormat:@"成交时间:%@",[[dataList objectAtIndex:indexPath.row] objectForKey:@"1898"]];
    postTimeLabel.tag = indexPath.row;
    [cell.contentView addSubview:postTimeLabel];
        
        UILabel *endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 30, 150, 10)];
        endTimeLabel.font = [UIFont systemFontOfSize:10];
        endTimeLabel.textAlignment = NSTextAlignmentRight;
        endTimeLabel.text = [NSString stringWithFormat:@"成交金额:%@",[[dataList objectAtIndex:indexPath.row] objectForKey:@"795"]];
       // endTimeLabel.tag = indexPath.row;
        [cell.contentView addSubview:endTimeLabel];
        
        
        
        
    } else if(tableView == tableNot) {
        cell.textLabel.text = [[dataList objectAtIndex:indexPath.row] objectForKey:@"2010"];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
        cell.detailTextLabel.text = [[dataList objectAtIndex:indexPath.row] objectForKey:@"795"];
        UIImageView *timeImage = [[UIImageView alloc] initWithFrame:CGRectMake(200, 8, 14, 14)];
        timeImage.image = [UIImage imageNamed:@"time"];
        [cell.contentView addSubview:timeImage];
        
        UILabel *postTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 10, 100, 10)];
        postTimeLabel.font = [UIFont systemFontOfSize:10];
        postTimeLabel.text = [NSString stringWithFormat:@"成交时间:%@",[[dataList objectAtIndex:indexPath.row] objectForKey:@"1898"]];
        postTimeLabel.tag = indexPath.row;
        [cell.contentView addSubview:postTimeLabel];
        cell.contentView.backgroundColor = [UIColor grayColor];
    
    }
    return cell;
}




-(void) segmentAction:(UISegmentedControl *)Seg{

NSInteger Index = Seg.selectedSegmentIndex;
    NSLog(@"Index %i",Index);
    if (Seg.selectedSegmentIndex == 0) {
        view2.hidden = YES;
        view1.hidden = NO;
    } else if(Seg.selectedSegmentIndex == 1){
        view1.hidden = YES;
        view2.hidden = NO;
    
    }
    
    
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)sender{
    if (sender.direction==UISwipeGestureRecognizerDirectionRight )
    {
         segmentedControl.selectedSegmentIndex = 1;
        view1.hidden = YES;
        view2.hidden = NO;
    }else if (sender.direction==UISwipeGestureRecognizerDirectionLeft ){
         segmentedControl.selectedSegmentIndex = 0;
        view2.hidden = YES;
        view1.hidden = NO;
    }
}

#pragma mark - Request Methods
//获取品牌列表
- (void)requestCategoryList:(NSString *)_userId  start:(NSDictionary *)_start limit:(NSString *)_limit tag:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求品牌列表");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    [paraDic setObject:_userId forKey:@"head"];
    [paraDic setObject:_start forKey:@"jsonParamStr"];
    [paraDic setObject:_limit forKey:@"rtKeyListStr"];
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:_tag owner:self];
   
}


- (void)tableView:(UITableView *)tbleView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        DetailViewController *goodsDetailViewController = [[DetailViewController alloc] init];
        ;
    goodsDetailViewController.titleName = [[dataList objectAtIndex:[indexPath row]] objectForKey:@"2010"] ;
    goodsDetailViewController.name = [NSString stringWithFormat:@"委托日期：%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"1898"]] ;
    goodsDetailViewController.gqName = [NSString stringWithFormat:@"委托数量：%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"684"]];
    goodsDetailViewController.date = [NSString stringWithFormat:@"委托时间：%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"750"]];
    goodsDetailViewController.mark = [NSString stringWithFormat:@"委托价格：%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"682"]];
    goodsDetailViewController.describ =  [NSString stringWithFormat:@"成交金额:%@",[[dataList objectAtIndex:indexPath.row] objectForKey:@"795"]];
        goodsDetailViewController.hidesBottomBarWhenPushed = YES;
        [tbleView deselectRowAtIndexPath:indexPath animated:YES];
        [self.navigationController pushViewController:goodsDetailViewController animated:YES];
    
}





#pragma mark - Recived Methods
//处理品牌列表
- (void)recivedCategoryList:(NSMutableArray *)dataArray
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"处理品牌列表数据");
    if (dataList.count > 0) {
        [dataList removeAllObjects];
    }
    
        dataList = dataArray;
    
    [table reloadData];
}

- (void)recivedCategoryList1:(NSMutableArray *)dataArray
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"处理品牌列表数据");
    if ([dataListNot count] > 0) {
        for (NSDictionary *object in dataArray) {
            [dataListNot addObject:object];
        }
    } else {
        dataListNot = dataArray;
    }
    [tableNot reloadData];
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
        if ([[jsonDic objectForKey:@"success"] boolValue]== 0) {
            //数据异常处理
            //[self.view makeToast:@"获取品牌失败"];
            //[HUD hide:YES];
        } else {
            [self recivedCategoryList:dataArray];
        }
    }else if (tag==kBusinessTagGetFun2ListAgain) {
        [HUD hide:YES];
        if ([[jsonDic objectForKey:@"success"] boolValue]== 0) {
            //数据异常处理
            //[HUD hide:YES];
            //[self.view makeToast:@"获取品牌失败222"];
        } else {
            [self recivedCategoryList1:dataArray];
        }
    }
}
-(void)errorPost:(NSError *)err business:(kBusinessTag)tag{
    NSLog(@"%s Error:%@", __FUNCTION__, @"连接数据服务器超时");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法连接" message:@"您所在地的网络信号微弱，无法连接到服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    if (tag == kBusinessTagGetFun2List) {
        [HUD hide:YES];
    } else if (tag == kBusinessTagGetFun2ListAgain) {
        [HUD hide:YES];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
