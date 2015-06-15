//
//  PostRequest.m
//  mPortal
//
//  Created by chen neng on 11-12-20.
//  Copyright (c) 2011年 ydtf. All rights reserved.
//

#import "PostRequest.h"

@implementation PostRequest
@synthesize postStatus;
@synthesize enc,url;
@synthesize businessTag;
@synthesize owner;
-(void)cancel{
    if (_request!=nil) {
        [_request release],_request=nil;
    }
}
-(void)setOwner:(id<NetworkModuleDelegate>)_owner{
    owner=[_owner retain];
}
-(id<NetworkModuleDelegate>)owner{
    return owner;
}

-(NSString*)result{
    if(postStatus==kPostStatusEnded){
        NSData *data = [_request responseData];
        //`处理
        //原NSString* string=[[NSString alloc] initWithData:data encoding:self.enc];
        NSString* string=[[[NSString alloc] initWithData:data encoding:self.enc] autorelease];
        return string;
    }else
        return nil;
}

-(void)postXML:(NSString*)xml delegate:(id)delegate{
    [self cancel];
    _request=[[ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]]retain];
	[_request setShouldAttemptPersistentConnection:NO];
    [_request setResponseEncoding:self.enc];
	NSMutableDictionary *reqHeaders = [[NSMutableDictionary alloc] init];
	[reqHeaders setValue:@"text/xml; charset=UTF-8" forKey:@"Content-Type"];
	_request.requestHeaders = reqHeaders;
	[reqHeaders release];
    NSLog(@"post xml:%@",xml);
    // 重要
    _request.tag=self.businessTag;
	[_request appendPostData:[xml dataUsingEncoding:self.enc]];
    [_request setDelegate:delegate];
    postStatus=kPostStatusBeging;
	[_request startAsynchronous];
}

//wowjsfjisj 
-(void)postDictionary:(NSMutableDictionary *)dic delegate:(id)delegate
{
    [self cancel];
    _request = [[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]] retain];
    [_request setShouldAttemptPersistentConnection:NO];
    [_request setTimeOutSeconds:5];
    [_request setResponseEncoding:self.enc];
    NSEnumerator *enumerator = [[dic keyEnumerator] retain];
    for (NSString *key in enumerator) {
        [_request setPostValue:[dic objectForKey:key] forKey:key];
    }
    [enumerator release];
    _request.tag = self.businessTag;
    [_request setDelegate:delegate];
    postStatus = kPostStatusBeging;
    [_request startAsynchronous];
}
-(void)postDictionaryAndData:(NSMutableDictionary *)dic data:(NSData *)data delegate:(id)delegate
{
    [self cancel];
    _request = [[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]] retain];
    [_request setShouldAttemptPersistentConnection:NO];
    [_request setTimeOutSeconds:5];
    [_request setResponseEncoding:self.enc];
    NSEnumerator *enumerator = [[dic keyEnumerator] retain];
    for (NSString *key in enumerator) {
        [_request setPostValue:[dic objectForKey:key] forKey:key];
    }
    [enumerator release];
    [_request setData:data withFileName:@"image.jpg" andContentType:@"image/jpg" forKey:@"file"];
    _request.tag = self.businessTag;
    [_request setDelegate:delegate];
    postStatus = kPostStatusBeging;
    [_request startAsynchronous];
}
////收拾收拾是收拾收拾是是

-(void)dealloc{
    [owner release],owner=nil;
    [_request release];
    [super dealloc];
}
@end
