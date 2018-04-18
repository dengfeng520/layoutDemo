//
//  NetworkError.m
//  Property
//
//  Created by rp.wang on 2017/1/5.
//  Copyright © 2017年 rp.wang. All rights reserved.
//

#import "NetworkError.h"

@implementation NetworkError

+ (NSString *)errorMessageWithCode:(NSInteger)errorCode
{
    NSString *message = nil;
    switch (errorCode) {
        case WKNetworkOK:
        case WKNetworkTimeout:
            message = @"连接超时";
            break;
        case WKNetworkCannotConnectServer:
            message = @"连接服务器错误";
            break;
        case WKNertworkNotConnectInternet:
            message = @"未连接网络";
            break;
        case WKNetworkConnectionLost:
            message = @"连接服务器错误";
            break;
        case WKTokenTimeOut:
            message = @"请重新登录";
        default:
            message = @"未知错误";
            break;
    }
    return message;
}

@end
