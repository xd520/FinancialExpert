//
//  URLUtil.m
//  WeiXiu
//
//  Created by Chris on 13-7-15.
//  Copyright (c) 2013年 Chris. All rights reserved.
//

#import "URLUtil.h"
#import "AppDelegate.h"
@implementation URLUtil
+ (NSString *)getURLByBusinessTag:(kBusinessTag)tag
{
    switch ([[NSNumber numberWithInt:tag] intValue]) {
        case 0:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/jrzc/cplist"];
            break;
        case 1:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/fixCommon/func2list"];
            break;
        case 2:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"//jrzc/cplist"];
            break;
        case 3:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/fixCommon/func2list"];
            break;
        case 4:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/cpxx/getUiStruct"];
            break;
        case 5:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/login"];
            break;
        case 6:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/order/getEleOrderList.action"];
            break;
        case 7:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/order/getEleOrderList.action"];
            break;
        case 8:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/order/getEleOrderList.action"];
            break;
        case 9:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/eleGoods/getEleGoodsListByOrderId.action"];
            break;
        case 10:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/order/deleteOrder.action"];
            break;
        case 11:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/eleShop/getEleShop.action"];
            break;
        case 12:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/eleShop/updateLinkMan.action"];
            break;
        case 13:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/eleShop/updatePhone.action"];
            break;
        case 14:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/eleShop/updateAddress.action"];
            break;
        case 15:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/eleShop/updateShopName.action"];
        case 16:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/eleShop/editPwd.action"];
            break;
        case 17:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/eleCategory/getEleCategoryList.action"];
            break;
        case 18:
            return [NSString stringWithFormat:@"%@%@", SERVERURL, @"/eleCategory/getEleCategoryList.action"];
            break;
        default:
            break;
    }
    return @"";
}
@end
