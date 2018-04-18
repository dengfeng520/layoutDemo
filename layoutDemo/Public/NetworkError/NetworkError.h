//
//  NetworkError.h
//  Property
//
//  Created by rp.wang on 2017/1/5.
//  Copyright © 2017年 rp.wang. All rights reserved.
//

#import <Foundation/Foundation.h>

enum{
    WKNetworkOK = 200,
    WKNetworkTimeout = -1001,
    WKNetworkCannotConnectServer = -1004,
    WKNetworkConnectionLost = -1005,
    WKNertworkNotConnectInternet = -1009,
    WKTokenTimeOut = -1111
};

@interface NetworkError : NSObject



+ (NSString *)errorMessageWithCode:(NSInteger)errorCode;

@end
