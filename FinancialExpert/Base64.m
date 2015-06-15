//
//  Base64.m
//  Sellthree
//
//  Created by Chris on 14-7-28.
//  Copyright (c) 2014年 Chris. All rights reserved.
//

#import "Base64.h"
#import "GTMBase64.h"

@implementation Base64
@synthesize strBase64;
+ (id)encodeBase64String:(NSString *)input{

    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    Base64 *baseData = [[Base64 alloc] init];
    baseData.strBase64 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return baseData;

}

+ (id)decodeBase64String:(NSString *)input{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 decodeData:data];
    Base64 *baseData = [[Base64 alloc] init];
    baseData.strBase64 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return baseData;

}

+ (id)encodeBase64Data:(NSData *)data{
    data = [GTMBase64 encodeData:data];
     Base64 *baseData = [[Base64 alloc] init];
    baseData.strBase64 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return baseData;

}

+ (id)decodeBase64Data:(NSData *)data{
    data = [GTMBase64 decodeData:data];
     Base64 *baseData = [[Base64 alloc] init];
    baseData.strBase64 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return baseData;

}


@end
