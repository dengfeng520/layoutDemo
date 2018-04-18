//
//  CheckNetwork.h
//  Property
//
//  Created by rp.wang on 2017/1/5.
//  Copyright © 2017年 rp.wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpManager.h"


@interface CheckNetwork : NSObject

@property (nonatomic, assign) BOOL isOnline;

+ (BOOL)isExistenceNetwork;

@end
