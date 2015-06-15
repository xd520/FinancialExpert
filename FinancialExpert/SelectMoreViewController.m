//
//  SelectMoreViewController.m
//  FinancialExpert
//
//  Created by mac on 14-9-17.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "SelectMoreViewController.h"
#import "AppDelegate.h"

@interface SelectMoreViewController ()
{
    UITableView *table1;
    UITableView *table2;
    UITableView *table3;
    NSArray *array1;
    NSArray *array2;
    NSArray *array3;
    MBProgressHUD *HUD;
    NSMutableArray *dataList;
    BOOL hasMore;
    
    NSString *classStr;
    NSString *rateStr1;
    NSString *rateStr2;
    NSString *dateStr1;
    NSString *dateStr2;
    
}
@end

@implementation SelectMoreViewController

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
    classStr = @"";
    rateStr1 = @"";
    rateStr2 = @"";
    dateStr1 = @"";
    dateStr2 = @"";
    
    UINavigationBar *navibar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    navibar.userInteractionEnabled = YES;
    //navibar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar.png"]];
    [navibar setBackgroundImage:[UIImage imageNamed:@"background.jpg"]  forBarMetrics:UIBarMetricsDefault];
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 21, 21);
    [leftBtn setImage:[UIImage imageNamed:@"head_icon_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 31, 31);
    [rightBtn setImage:[UIImage imageNamed:@"button_ok"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnPush:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    
    UINavigationItem *navibarItem = [[UINavigationItem alloc]init];
    navibarItem.title =@"选择搜索信息";
    navibarItem.leftBarButtonItem= leftItem;
     navibarItem.rightBarButtonItem = rightItem;
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

    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, 40)];
     [titleView setBackgroundColor:[ColorUtil colorWithHexString:@"fafafa"]];
    
    
    UILabel *classLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth*2/7,40)];
    classLable.text = @"类别";
    classLable.textAlignment = NSTextAlignmentCenter;
    classLable.textColor = [UIColor blueColor];
    classLable.font = [UIFont boldSystemFontOfSize:17];
    [titleView addSubview:classLable];
    
    UILabel *rateLable = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*2/7, 0, ScreenWidth*2.5/7,40)];
    rateLable.text = @"利率";
    rateLable.textAlignment = NSTextAlignmentCenter;
    rateLable.textColor = [UIColor blueColor];
    rateLable.font = [UIFont boldSystemFontOfSize:17];
    [titleView addSubview:rateLable];
    
    UILabel *dateLable = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*4.5/7, 0, ScreenWidth*2.5/7,40)];
    dateLable.text = @"期限";
    dateLable.textAlignment = NSTextAlignmentCenter;
    dateLable.textColor = [UIColor blueColor];
    dateLable.font = [UIFont boldSystemFontOfSize:17];
    [titleView addSubview:dateLable];
    [self.view addSubview:titleView];
    
    
    table1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 84, ScreenWidth*2/7,ScreenHeight - 84)];
    table1.delegate = self;
    table1.dataSource = self;
    [self.view addSubview:table1];
    
    table2 = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth*2/7, 84, ScreenWidth*2.5/7,ScreenHeight - 84)];
    table2.delegate = self;
    table2.dataSource = self;
    [self.view addSubview:table2];
    
    table3 = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth*4.5/7, 84, ScreenWidth*2.5/7,ScreenHeight - 84)];
    table3.delegate = self;
    table3.dataSource = self;
    [self.view addSubview:table3];
    
    array1 = @[@"湖南省",@"嘉禾",@"福州",@"加急",@"合欢花"];
    
    NSDictionary *dic1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"小于7%",@"name",@"0",@"gzllVal1",@"7",@"gzllVal2", nil];
    NSDictionary *dic2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"大于等于7%",@"name",@"7",@"gzllVal1",@"100",@"gzllVal2", nil];
    NSDictionary *dic3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"不限",@"name",@"",@"gzllVal1",@"",@"gzllVal2", nil];
    
    array2 = @[dic1,dic2,dic3];
    
     NSDictionary *date1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"3个月以下",@"dname",@"0",@"qxVal1",@"3",@"qxVal2", nil];
    NSDictionary *date2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"3-6个月",@"dname",@"3",@"qxVal1",@"6",@"qxVal2", nil];
    NSDictionary *date3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"6-12个月",@"dname",@"6",@"qxVal1",@"12",@"qxVal2", nil];
    NSDictionary *date4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"12-36个月",@"dname",@"12",@"qxVal1",@"36",@"qxVal2", nil];
    NSDictionary *date5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"不限",@"dname",@"",@"qxVal1",@"",@"qxVal2", nil];
    
     array3 = @[date1,date2,date3,date4,date5];
    
    //添加指示器及遮罩
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.dimBackground = YES;
    HUD.delegate = self;
    HUD.labelText = @"加载中";
    [HUD show:YES];
    [self.view addSubview:HUD];
    //获取类别信息
    [self requestCategoryList:funCode start:@"" limit:rtKeyListStr tag:kBusinessTagGetFun2List];
    
    
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
    [table1 reloadData];
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
        if (dataArray == nil) {
            //数据异常处理
            [self.view makeToast:@"获取品牌失败"];
        } else {
            [self recivedCategoryList:dataArray];
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





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger abc;
    if (tableView == table1) {
        abc = dataList.count;
    } else if (tableView == table2) {
        
        abc = array2.count;
    } else if (tableView == table3) {
        
        abc = array3.count;
    }
    return abc;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (tableView == table1) {
        cell.textLabel.text = [[dataList objectAtIndex:indexPath.row] objectForKey:@"2009"];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
        cell.textLabel.textColor = [ColorUtil colorWithHexString:@"1b1b1b"];
    } else if (tableView == table2) {
        cell.textLabel.text = [[array2 objectAtIndex:indexPath.row] objectForKey:@"name"];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
        cell.textLabel.textColor = [ColorUtil colorWithHexString:@"1b1b1b"];
        //cell.textLabel.text = [array2 objectAtIndex:indexPath.row];
    } else if (tableView == table3) {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
        cell.textLabel.textColor = [ColorUtil colorWithHexString:@"1b1b1b"];
        cell.textLabel.text = [[array3 objectAtIndex:indexPath.row] objectForKey:@"dname"];
    }
    cell.selectedBackgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.jpg"]];
    return cell;
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
        if (tableView == table1) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            UILabel *classLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, ScreenWidth*2/7 - 20, 14)];
            classLabel.font = [UIFont systemFontOfSize:14];
            classLabel.text = [[dataList objectAtIndex:indexPath.row] objectForKey:@"2009"];
            [cell.contentView addSubview:classLabel];
            }
            cell.selectedBackgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.jpg"]];
            return cell;
        } else if (tableView == table2) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            [backView setBackgroundColor:[ColorUtil colorWithHexString:@"fafafa"]];
            UILabel *rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*2/7, 10, ScreenWidth*2/7 - 20, 14)];
            rateLabel.font = [UIFont systemFontOfSize:14];
            rateLabel.textColor = [UIColor blackColor];
                cell.detailTextLabel.text = [[array2 objectAtIndex:indexPath.row] objectForKey:@"name"];
            rateLabel.text = [[array2 objectAtIndex:indexPath.row] objectForKey:@"name"];
            [backView addSubview:rateLabel];
            //[cell.contentView addSubview:backView];
            }
            cell.selectedBackgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.jpg"]];
            return cell;
        }  else if (tableView == table3) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
            
            if (YES) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            [backView setBackgroundColor:[ColorUtil colorWithHexString:@"fafafa"]];
            UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*4/7, 10, ScreenWidth*3/7 - 20, 14)];
            dateLabel.font = [UIFont systemFontOfSize:14];
            dateLabel.textColor = [UIColor blackColor];
            dateLabel.text = [[array3 objectAtIndex:indexPath.row] objectForKey:@"dname"];
            [backView addSubview:dateLabel];
            [cell.contentView addSubview:backView];
        }
            cell.selectedBackgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.jpg"]];
            return cell;
    }
    return cell;
}
*/
 
- (void)tableView:(UITableView *)tbleView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSInteger row = [indexPath row];
    if (tbleView == table1) {
        classStr = [[dataList objectAtIndex:indexPath.row] objectForKey:@"2008"];
        
        NSDictionary *dic1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"小于7%",@"name",@"0",@"gzllVal1",@"7",@"gzllVal2", nil];
        NSDictionary *dic2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"大于等于7%",@"name",@"7",@"gzllVal1",@"100",@"gzllVal2", nil];
        NSDictionary *dic3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"不限",@"name",@"",@"gzllVal1",@"",@"gzllVal2", nil];
        
        array2 = @[dic1,dic2,dic3];
        
          [table2 reloadData];
    } else if (tbleView == table2) {
        rateStr1 = [[array2 objectAtIndex:indexPath.row] objectForKey:@"gzllVal1"];
        rateStr2 = [[array2 objectAtIndex:indexPath.row] objectForKey:@"gzllVal2"];
        
        NSDictionary *date1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"3个月以下",@"dname",@"0",@"qxVal1",@"3",@"qxVal2", nil];
        NSDictionary *date2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"3-6个月",@"dname",@"3",@"qxVal1",@"6",@"qxVal2", nil];
        NSDictionary *date3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"6-12个月",@"dname",@"6",@"qxVal1",@"12",@"qxVal2", nil];
        NSDictionary *date4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"12-36个月",@"dname",@"12",@"qxVal1",@"36",@"qxVal2", nil];
        NSDictionary *date5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"不限",@"dname",@"",@"qxVal1",@"",@"qxVal2", nil];
        
        
        array3 = @[date1,date2,date3,date4,date5];
        
        [table3 reloadData];
        
    } else if(tbleView == table3) {
        dateStr1 = [[array3 objectAtIndex:indexPath.row] objectForKey:@"qxVal1"];
        dateStr2 = [[array3 objectAtIndex:indexPath.row] objectForKey:@"qxVal2"];
    
    }

}



-(void) push:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void) rightBtnPush:(UIButton *)btn{
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:classStr,@"2008",rateStr1,@"gzllVal1",rateStr2,@"gzllVal2",dateStr1,@"qxVal1",dateStr2,@"qxVal2", nil];
    [self.delegate reloadTableView:dic];
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
