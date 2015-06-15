//
//  Customer.h
//  FinancialExpert
//
//  Created by mac on 14-9-25.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Customer : NSObject
{
    NSString *customerName;
    NSString *customerNum;
    NSString *customerId;
    BOOL loginSueccss;
}
@property(nonatomic,strong) NSString *customerName;
@property(nonatomic,strong) NSString *customerNum;
@property(nonatomic,strong) NSString *customerId;
@property(nonatomic,assign) BOOL loginSueccss;

+(id) CustomerInformation:(NSString *)_customerName withNum:(NSString *)_customerNum withId:(NSString *)_customerId withSueccss:(BOOL)_loginSue;


@end
