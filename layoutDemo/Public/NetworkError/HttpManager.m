//
//  HttpManager.m
//  Property
//
//  Created by rp.wang on 2017/1/5.
//  Copyright © 2017年 rp.wang. All rights reserved.
//

#import "HttpManager.h"


@implementation HttpManager

+ (instancetype)sharedManager
{
    static HttpManager *_sharedManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSURL *url = [NSURL URLWithString:APPLE_SERVER];
        httpManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
        //开启SSL证书绑定，安全通信
        httpManager.securityPolicy.allowInvalidCertificates = YES;
        //设置超时时间35秒
        httpManager.requestSerializer.timeoutInterval = 30.0f;
        [self startCheckOnlineStatus];
    }
    return self;
}


- (void)startCheckOnlineStatus{
    
    NSOperationQueue *operationQueue = httpManager.operationQueue;
    
    _isOnline = YES;
    
    [httpManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
            {
                [operationQueue setSuspended:YES];
                _isOnline = NO;
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                [operationQueue setSuspended:NO];
                _isOnline = YES;
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                [operationQueue setSuspended:NO];
                _isOnline = YES;
                break;
            }
            default:
            {
                [operationQueue setSuspended:YES];
                _isOnline = NO;
            }
                break;
        }
    }];
    [httpManager.reachabilityManager startMonitoring];
    
}


@end
