//
//  HttpManager.h
//  Property
//
//  Created by rp.wang on 2017/1/5.
//  Copyright © 2017年 rp.wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Header.h"




@interface HttpManager : NSObject
{
    AFHTTPSessionManager *httpManager;
}

@property (nonatomic, assign) BOOL isOnline;
+ (instancetype)sharedManager;
@end
