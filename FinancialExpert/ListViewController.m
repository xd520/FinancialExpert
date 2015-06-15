//
//  ListViewController.m
//  FinancialExpert
//
//  Created by mac on 14-9-15.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ListViewController.h"
#import "AppDelegate.h"
#import "ClassViewController.h"
#import "ExampleViewController2.h"
#import "AsynImageView.h"
#import "DetailViewController.h"
#import "SelectMoreViewController.h"
#import "ScreeningViewController.h"


#define kDropDownListTag 1000

@interface ListViewController ()
{
    MBProgressHUD *HUD;
    UITableView *tableView;
    NSString *start;
    NSString *startBak;
    NSString *limit;
    NSMutableArray *dataList;
    BOOL hasMore;
    UITableViewCell *moreCell;
    SRRefreshView   *_slimeView;
    UIButton *classBtn;
}
@end

@implementation ListViewController

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
    start = @"1";
    limit = @"10";
    
    classBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    classBtn.frame = CGRectMake(0, 0, 30, 30);
    [classBtn setBackgroundImage:[UIImage imageNamed:@"find"] forState:UIControlStateNormal];
    [classBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithCustomView:classBtn];
    self.navigationItem.rightBarButtonItem = button;
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 50 - self.navigationController.navigationBar.height - 25)];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView setBackgroundColor:[UIColor clearColor]];
    tableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:tableView];
    //加入下拉刷新
    _slimeView = [[SRRefreshView alloc] init];
    _slimeView.delegate = self;
    _slimeView.upInset = 0;
    _slimeView.slimeMissWhenGoingBack = YES;
    _slimeView.slime.bodyColor = [UIColor blackColor];
    _slimeView.slime.skinColor = [UIColor whiteColor];
    _slimeView.slime.lineWith = 1;
    _slimeView.slime.shadowBlur = 4;
    _slimeView.slime.shadowColor = [UIColor blackColor];
    [tableView addSubview:_slimeView];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
#endif
    
    [self requestGoodsList:start limit:limit tag:kBusinessTagUserGetList];
    //添加指示器及遮罩
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.dimBackground = YES;
    HUD.delegate = self;
    HUD.labelText = @"登录中";
    [HUD show:YES];
    [self.view addSubview:HUD];
    
    
   }


#pragma mark - slimeRefresh delegate
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    startBak = [NSString stringWithString:start];
    start = @"1";
    [self requestGoodsList:start  limit:limit tag:kBusinessTagUserGetListAgain];
}
#pragma mark - UIScrollView Delegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_slimeView scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_slimeView scrollViewDidEndDraging];
}

- (void)tableView:(UITableView *)tbleView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == [dataList count]) {
        if (hasMore) {
            for (UILabel *label in [cell.contentView subviews]) {
                if ([label.text isEqualToString:@"*****正在加载*****"]) {
                    
                } else {
                    label.text = @"*****正在加载*****";
                    [self requestGoodsList:start limit:limit tag:kBusinessTagUserGetList];
                    [tbleView deselectRowAtIndexPath:indexPath animated:YES];
                }
            }
        }
    }
}


- (void)tableView:(UITableView *)tbleView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [dataList count]) {
        for (UILabel *label in [moreCell.contentView subviews]) {
            if ([label.text isEqualToString:@"正在加载中..."]) {
                
            } else {
                label.text = @"正在加载中...";
                [self requestGoodsList:start limit:limit tag:kBusinessTagUserGetList];
                [tbleView deselectRowAtIndexPath:indexPath animated:YES];
            }
        }
    } else {
        DetailViewController *goodsDetailViewController = [[DetailViewController alloc] init];
        ;
        goodsDetailViewController.titleName = [[dataList objectAtIndex:[indexPath row]] objectForKey:@"CPMC"] ;
        goodsDetailViewController.name = [NSString stringWithFormat:@"产品名称：%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"CPMC"]] ;
        goodsDetailViewController.gqName = [NSString stringWithFormat:@"股权名称：%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"GQMC"]];
goodsDetailViewController.date = [NSString stringWithFormat:@"发行日期：%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"FXRQ"]];
        goodsDetailViewController.mark = [NSString stringWithFormat:@"发行价：%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"FXJ"]];
        goodsDetailViewController.describ =  [NSString stringWithFormat:@"股权代码：%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"GQDM"]];
        goodsDetailViewController.hidesBottomBarWhenPushed = YES;
        [tbleView deselectRowAtIndexPath:indexPath animated:YES];
        [self.navigationController pushViewController:goodsDetailViewController animated:YES];
    }
}


#pragma mark - Detegate
- (void)reloadTableView:(NSDictionary *)categoryData
{
    self.navigationController.navigationBarHidden = YES;
     // ;
    //[categoryLabel setText:[categoryData objectForKey:@"name"]];
    //添加指示器及遮罩
    HUD = [[MBProgressHUD alloc] initWithView:tableView];
    HUD.dimBackground = YES;
    HUD.delegate = self;
    HUD.labelText = @"加载中";
    [HUD show:YES];
    [self.view addSubview:HUD];
    startBak = [NSString stringWithString:start];
    start = @"1";
    [self requestGoodsListAgin:start limit:limit gzllVal1:[categoryData objectForKey:@"gzllVal1"] gzllVal2:[categoryData objectForKey:@"gzllVal2"] qxVal1:[categoryData objectForKey:@"qxVal1"] qxVal2:[categoryData objectForKey:@"qxVal2"] mark:[categoryData objectForKey:@"2008"] tag:kBusinessTagUserGetListAgain];
    [classBtn setImage:[UIImage imageNamed:@"find-3"] forState:UIControlStateNormal];
    
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
    //[tableView setScrollEnabled:NO]; tableView 不能滑动
    static NSString *RepairCellIdentifier = @"RepairCellIdentifier";
    UITableViewCell *cell;
    cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    if ([dataList count] == 0) {
        if (YES) {
            cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 50)];
            [backView setBackgroundColor:[ColorUtil colorWithHexString:@"ececec"]];
            //图标
            UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(131.5, 100, 57, 57)];
            [iconImageView setImage:[UIImage imageNamed:@"icon_none"]];
            [backView addSubview:iconImageView];
            //提示
            UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, iconImageView.frame.origin.y + iconImageView.frame.size.height + 27, 320, 15)];
            [tipLabel setFont:[UIFont systemFontOfSize:15]];
            [tipLabel setTextAlignment:NSTextAlignmentCenter];
            [tipLabel setTextColor:[ColorUtil colorWithHexString:@"404040"]];
            [tipLabel setText:@"没有任何商品哦~"];
            [backView addSubview:tipLabel];
            [cell.contentView addSubview:backView];
            
        }
    } else {
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
            toastLabel.textAlignment = NSTextAlignmentCenter;
            [moreCell.contentView addSubview:toastLabel];
            return moreCell;
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:RepairCellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 70)];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell setBackgroundColor:[UIColor clearColor]];
                //添加背景View
                UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, ScreenWidth, 69)];
                [backView setBackgroundColor:[ColorUtil colorWithHexString:@"fdfdfd"]];
                
                AsynImageView *imageView1 = [[AsynImageView alloc] initWithFrame:CGRectMake(5, 5 , 60, 60)];
                imageView1.placeholderImage = [UIImage imageNamed:@"xd1"];
                //imageView1.imageURL = [NSString stringWithFormat:@"%@",[[dataList objectAtIndex:indexPath.row] objectForKey:@"url"]];
                if (imageView1.image == nil) {
                    imageView1.image = [UIImage imageNamed:@"pic_listshibai"];
                }
                
                
                [backView addSubview:imageView1];
                
                //品牌
                UILabel *brandLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 13)];
                brandLabel.font = [UIFont boldSystemFontOfSize:13];
                [brandLabel setTextColor:[ColorUtil colorWithHexString:@"1b1b1b"]];
                [brandLabel setBackgroundColor:[UIColor clearColor]];
                brandLabel.text = [[dataList objectAtIndex:[indexPath row]] objectForKey:@"CPMC"];
        //    [brandLabel sizeToFit];
        //     CGRect frame = [brandLabel frame];
        //     [brandLabel setFrame:CGRectMake(14, 11, frame.size.width, 15)];
                [backView addSubview:brandLabel];
//发行价
                
                UILabel *issuePriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 33, 70, 10)];
                issuePriceLabel.font = [UIFont systemFontOfSize:10];
                [issuePriceLabel setTextColor:[ColorUtil colorWithHexString:@"1b1b1b"]];
                [issuePriceLabel setBackgroundColor:[UIColor clearColor]];
                issuePriceLabel.text = [NSString stringWithFormat:@"发行价：%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"FXJ"]];
                [backView addSubview:issuePriceLabel];
   //发行日期
               
                UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 33, 100, 10)];
                dateLabel.font = [UIFont systemFontOfSize:10];
                [dateLabel setTextColor:[ColorUtil colorWithHexString:@"1b1b1b"]];
                [dateLabel setBackgroundColor:[UIColor clearColor]];
                dateLabel.text = [NSString stringWithFormat:@"发行日期：%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"FXRQ"]];
                [backView addSubview:dateLabel];
                
  //股权代码
              
                UILabel *codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 50, 110, 10)];
                codeLabel.font = [UIFont systemFontOfSize:10];
                [codeLabel setTextColor:[ColorUtil colorWithHexString:@"1b1b1b"]];
                [codeLabel setBackgroundColor:[UIColor clearColor]];
                codeLabel.text = [NSString stringWithFormat:@"股权代码：%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"GQDM"]];
                [backView addSubview:codeLabel];
     //股权名称
               
                UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 50, 90, 10)];
                nameLabel.font = [UIFont systemFontOfSize:10];
                [nameLabel setTextColor:[ColorUtil colorWithHexString:@"1b1b1b"]];
                [nameLabel setBackgroundColor:[UIColor clearColor]];
                nameLabel.text = [NSString stringWithFormat:@"股权名称：%@",[[dataList objectAtIndex:[indexPath row]] objectForKey:@"GQMC"]];
                [backView addSubview:nameLabel];
                
                
                
                
                UILabel *CPJJLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 35, 200, 13)];
                CPJJLabel.numberOfLines = 0;
                CPJJLabel.font = [UIFont systemFontOfSize:13];
                [CPJJLabel setTextColor:[ColorUtil colorWithHexString:@"1b1b1b"]];
                [CPJJLabel setBackgroundColor:[UIColor clearColor]];
                //CPJJLabel.text = [NSString stringWithFormat:@"你是%d猴子派来的救兵吗？",[indexPath row]];
                // CPJJLabel.text = [[[[dataList objectAtIndex:[indexPath row]] objectForKey:@"xmlObj"] objectForKey:@"CPJJ"] objectForKey:@"value"];
                [backView addSubview:CPJJLabel];
                
                
                //型号
                
                
                [cell.contentView addSubview:backView];
            }
        }
        return cell;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}



- (void)requestGoodsList:(NSString *)_start limit:(NSString *)_limit tag:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求登陆");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    [paraDic setObject:_start forKey:@"pageNo"];
    [paraDic setObject:_limit forKey:@"pageSize"];
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:_tag owner:self];
    
}

- (void)requestGoodsListAgin:(NSString *)_start limit:(NSString *)_limit gzllVal1:(NSString *)_val1  gzllVal2:(NSString *)_val2  qxVal1:(NSString *)_qxVal1  qxVal2:(NSString *)_qxVal2  mark:(NSString *)_mark tag:(kBusinessTag)_tag
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"请求登陆");
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    [paraDic setObject:_start forKey:@"pageNo"];
    [paraDic setObject:_limit forKey:@"pageSize"];
    //[paraDic setObject:@"0,1,-2" forKey:@"jyztArr"];
    [paraDic setObject:_val1 forKey:@"gzllVal1"];
    [paraDic setObject:_val2 forKey:@"gzllVal2"];
    [paraDic setObject:_qxVal1 forKey:@"qxVal1"];
    [paraDic setObject:_qxVal2 forKey:@"qxVal2"];
    [paraDic setObject:_mark forKey:@"gqlb"];
    [[NetworkModule sharedNetworkModule] postBusinessReqWithParamters:paraDic tag:_tag owner:self];
    
}



#pragma mark - NetworkModuleDelegate Methods
-(void)beginPost:(kBusinessTag)tag{
    
}
-(void)endPost:(NSString *)result business:(kBusinessTag)tag{
    NSLog(@"%s %d 收到数据:%@", __FUNCTION__, __LINE__, result);
    
    NSMutableDictionary *jsonDic = [result JSONValue];
    NSMutableArray *dataArray = [jsonDic objectForKey:@"object"];
	if (tag==kBusinessTagUserGetList ) {
        [HUD hide:YES];
        if ([dataArray isKindOfClass:[NSNull class]]) {
            //数据异常处理
            // [self.view makeToast:@"处理商品失败"];
        } else {
            [classBtn setImage:[UIImage imageNamed:@"find"] forState:UIControlStateNormal];
            [self recivedGoodsList:dataArray];
        }
    } else if (tag == kBusinessTagUserGetListAgain){
        [HUD hide:YES];
        [_slimeView endRefresh];
        if (dataArray == nil) {
            //数据异常处理
            [self.view makeToast:@"刷新商品失败"];
        } else {
            [dataList removeAllObjects];
            [self recivedGoodsList:dataArray];
        }
    }
}
-(void)errorPost:(NSError *)err business:(kBusinessTag)tag{
    NSLog(@"%s Error:%@", __FUNCTION__, @"连接数据服务器超时");
    [HUD hide:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法连接" message:@"您所在地的网络信号微弱，无法连接到服务器" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
    if (tag == kBusinessTagUserGetList) {
        [HUD hide:YES];
    } else if (tag == kBusinessTagUserGetListAgain) {
        start = [NSString stringWithString:startBak];
        [_slimeView endRefresh];
    }
}


#pragma mark - Recived Methods
//处理商品列表
- (void)recivedGoodsList:(NSMutableArray *)dataArray
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"处理商品列表数据");
    if (![dataArray isKindOfClass:[NSNull class]]) {
        
    if ([dataList count] > 0) {
        for (NSDictionary *object in dataArray) {
            [dataList addObject:object];
        }
    } else {
        dataList = [[NSMutableArray alloc] initWithArray:dataArray];
    }
    if ([dataArray count] < 10) {
        hasMore = NO;
    } else {
        hasMore = YES;
        start = [NSString stringWithFormat:@"%d", [start intValue] + 1];
    }
    [HUD hide:YES];
    [tableView reloadData];
    [_slimeView endRefresh];
}
}

#pragma mark - 跳转类别界面
-(void)push {
    
    //ExampleViewController2 *controller = [[ExampleViewController2 alloc] init];
    //ClassViewController *controller = [[ClassViewController alloc] init];
   // controller.delegate = self;
    ScreeningViewController *controller = [[ScreeningViewController alloc] init];
    controller.delegate = self;
   controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
/*
- (void)dealloc{
    NSLog(@"tableviewcell 回收");
    [HUD removeFromSuperview];
    [tableView removeFromSuperview];
    [moreCell removeFromSuperview];
    [tableView removeFromSuperview];
    [_slimeView removeFromSuperview];
}
*/


@end
