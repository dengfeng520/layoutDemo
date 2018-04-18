//
//  CheckNetwork.m
//  Property
//
//  Created by rp.wang on 2017/1/5.
//  Copyright © 2017年 rp.wang. All rights reserved.
//

#import "CheckNetwork.h"



@implementation CheckNetwork

+ (BOOL)isExistenceNetwork
{
    return [HttpManager sharedManager].isOnline;
}

@end
