//
//  Customer.m
//  FinancialExpert
//
//  Created by mac on 14-9-25.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "Customer.h"

@implementation Customer
@synthesize customerId,customerName,customerNum,loginSueccss;
+(id) CustomerInformation:(NSString *)_customerName withNum:(NSString *)_customerNum withId:(NSString *)_customerId withSueccss:(BOOL)_loginSue {
    Customer *customer = [[Customer alloc] init];
    customer.customerNum = _customerNum;
    customer.customerName = _customerName;
    customer.customerId = _customerId;
    customer.loginSueccss = _loginSue;
    return customer;


}
@end
