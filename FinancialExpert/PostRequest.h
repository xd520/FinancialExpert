//
//  PostRequest.h
//  mPortal
//
//  Created by chen neng on 11-12-20.
//  Copyright (c) 2011年 ydtf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "NetworkModuleDelegate.h"


@interface PostRequest : NSObject{
    ASIFormDataRequest *_request;
}
@property (nonatomic,retain)id<NetworkModuleDelegate> owner;
@property (nonatomic,retain)NSString* url;
@property (assign)kPostStatus postStatus;
@property (assign)kBusinessTag businessTag;
@property (assign)NSStringEncoding enc;
@property (nonatomic,readonly,getter = result)NSString* result;

-(void)cancel;

-(void)postXML:(NSString*)xml delegate:(id)delegate;
-(void)postDictionary:(NSMutableDictionary *)dic delegate:(id)delegate;
-(void)postDictionaryAndData:(NSMutableDictionary *)dic data:(NSData *)data delegate:(id)delegate;
@end
