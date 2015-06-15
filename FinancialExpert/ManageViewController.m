//
//  ManageViewController.m
//  FinancialExpert
//
//  Created by mac on 14-9-15.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ManageViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

#define funCode2 @"406001"
#define rtKeyDelegateStr1 @"2012,800,1027,751,1908,697,1894,763,793,1174"



@interface ManageViewController ()
{
    UIView *view1;
    UIView *view2;
    UIView *view3;
    UISegmentedControl *segmentedControl;
    MBProgressHUD *HUD;
    NSMutableArray *dataList;
}

@end

@implementation ManageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadData];
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
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"当日投资记录",@"历史投资记录",@"我的投资项目",nil];
    segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    
    segmentedControl.frame = CGRectMake(20, 10, ScreenWidth - 40, 40);
    
    segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
    
    segmentedControl.tintColor = [UIColor grayColor];
    
    segmentedControl.multipleTouchEnabled = NO;
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBezeled;
    
    [segmentedControl addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];
    
    view1 = [[UIView alloc] initWithFrame:CGRectMake(0, segmentedControl.origin.y + segmentedControl.size.height + 10, ScreenWidth, ScreenHeight - segmentedControl.origin.y - segmentedControl.size.height - 49 - 30 - self.navigationController.navigationBar.size.height)];
    //view1.backgroundColor = [UIColor redColor];
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromView:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [view1 addGestureRecognizer:recognizer];
    [self.view addSubview:view1];
    
    view2 = [[UIView alloc] initWithFrame:CGRectMake(0, segmentedControl.origin.y + segmentedControl.size.height + 10, ScreenWidth, ScreenHeight - segmentedControl.origin.y - segmentedControl.size.height - 49 - 30 - self.navigationController.navigationBar.size.height)];
    view2.backgroundColor = [UIColor blackColor];
    view2.hidden = YES;
    
    UISwipeGestureRecognizer *recognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromView1:)];
     UISwipeGestureRecognizer *recognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromView1:)];
    [recognizerRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [recognizerLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    
    [view2 addGestureRecognizer:recognizerLeft];
    [view2 addGestureRecognizer:recognizerRight];
    [self.view addSubview:view2];
    
    
    view3 = [[UIView alloc] initWithFrame:CGRectMake(0, segmentedControl.origin.y + segmentedControl.size.height + 10, ScreenWidth, ScreenHeight - segmentedControl.origin.y - segmentedControl.size.height - 49 - 30 - self.navigationController.navigationBar.size.height)];
    view3.backgroundColor = [UIColor brownColor];
    view3.hidden = YES;
    
    UISwipeGestureRecognizer *recognizer3 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromView2:)];
    [recognizer3 setDirection:(UISwipeGestureRecognizerDirectionLeft)];
     [view3 addGestureRecognizer:recognizer3];
    
    [self.view addSubview:view3];
    [self.view addSubview:segmentedControl];
    
    [self reloadData];
  //添加指示器及遮罩
     HUD = [[MBProgressHUD alloc] initWithView:self.view];
     HUD.dimBackground = YES;
     HUD.delegate = self;
     HUD.labelText = @"加载中";
     [HUD show:YES];
     //[self.view addSubview:HUD];
}

-(void) reloadData {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    if (delegate.loginArray.count > 0) {
        Customer *customer = [delegate.loginArray objectAtIndex:0];
        
            //获取类别信息
            NSArray *object =@[customer.customerNum,@"0",@"2014-03-01",@"2014-10-01",@"",@"10"];
            //NSArray *object1 =@[customer.customerNum,@"",@"",@"",@"W",@"",@"",@"",@"",@"",@"",@""];
            
            
            NSArray *keys =@[@"605",@"9109",@"618",@"590",@"763",@"9110"];
            NSDictionary *requestStr = [[NSDictionary alloc] initWithObjects:object forKeys:keys];
            
            //NSDictionary *requestStr1 = [[NSDictionary alloc] initWithObjects:object1 forKeys:keys];
            
            [self requestCategoryList:funCode2 start:requestStr limit:rtKeyDelegateStr1 tag:kBusinessTagGetFun2List];
            
           // [self requestCategoryList:funCode1 start:requestStr1 limit:rtKeyDelegateStr tag:kBusinessTagGetFun2ListAgain];
    }
    
}



-(void) segmentAction:(UISegmentedControl *)Seg{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    NSLog(@"Index %i",Index);
    if (Seg.selectedSegmentIndex == 0) {
        view2.hidden = YES;
        view1.hidden = NO;
        view3.hidden = YES;
    } else if (Seg.selectedSegmentIndex == 1){
        view1.hidden = YES;
        view2.hidden = NO;
        view3.hidden = YES;
    }else if (Seg.selectedSegmentIndex == 2){
        view3.hidden = NO;
        view1.hidden = YES;
        view2.hidden = YES;
    
    }
}

-(void)handleSwipeFromView:(UISwipeGestureRecognizer *)sender{
    if (sender.direction==UISwipeGestureRecognizerDirectionRight)
    {
        segmentedControl.selectedSegmentIndex = 1;
        view1.hidden = YES;
        view2.hidden = NO;
        view3.hidden = YES;
    }
}


-(void)handleSwipeFromView1:(UISwipeGestureRecognizer *)sender{
    if (sender.direction==UISwipeGestureRecognizerDirectionRight )
    {
        //segmentedControl.multipleTouchEnabled=NO;
        segmentedControl.selectedSegmentIndex = 2;
        view2.hidden = YES;
        view3.hidden = NO;
        view1.hidden = YES;
    }else if(sender.direction==UISwipeGestureRecognizerDirectionLeft) {
        segmentedControl.selectedSegmentIndex = 0;
        view2.hidden = YES;
        view1.hidden = NO;
        view3.hidden = YES;
    }
}


-(void)handleSwipeFromView2:(UISwipeGestureRecognizer *)sender{
    if (sender.direction==UISwipeGestureRecognizerDirectionLeft )
    {
        segmentedControl.selectedSegmentIndex = 1;
        view3.hidden = YES;
        view2.hidden = NO;
        view1.hidden = YES;
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


#pragma mark - Recived Methods
//处理品牌列表
- (void)recivedCategoryList:(NSMutableArray *)dataArray
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"处理品牌列表数据");
    if (dataList.count > 0) {
        [dataList removeAllObjects];
    }
    
    dataList = dataArray;
    NSLog(@"%d",dataList.count);
   // [table reloadData];
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
            //[self recivedCategoryList1:dataArray];
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
    
}



@end
