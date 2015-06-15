
enum kPostStatus{
    kPostStatusNone=0,
    kPostStatusBeging=1,
    kPostStatusEnded=2,
    kPostStatusError=3,
    kPostStatusReceiving=4
};
typedef enum kPostStatus kPostStatus;

enum kBusinessTag
{
	kBusinessTagUserGetList = 0,
    kBusinessTagGetFun2List = 1,
    kBusinessTagUserGetListAgain = 2,
    kBusinessTagGetFun2ListAgain = 3,
    kBusinessTagGetUiStruct = 4,
    kBusinessTagUserLogin = 5,
    kBusinessTagGetNoEleOrderListAgain = 6,
    kBusinessTagGetFinishEleOrderList = 7,
    kBusinessTagGetFinishEleOrderListAgain = 8,
    kBusinessTagGetGoodsListByOrder = 9,
    kBusinessTagDeleteOrder = 10,
    kBusinessTagGetEleShop = 11,
    kBusinessTagUpdateLinkMan = 12,
    kBusinessTagUpdatePhone = 13,
    kBusinessTagUpdateAddress = 14,
    kBusinessTagUpdateShopName = 15,
    kBusinessTagEditPwd = 16,
    kBusinessTagGetEleCategoryList = 17,
    kBusinessTagGetEleCategoryListAgain = 18,
};
typedef enum kBusinessTag kBusinessTag;

@protocol NetworkModuleDelegate<NSObject>
@required
-(void)beginPost:(kBusinessTag)tag;
-(void)endPost:(NSString*)result business:(kBusinessTag)tag;
-(void)errorPost:(NSError*)err business:(kBusinessTag)tag;
@end