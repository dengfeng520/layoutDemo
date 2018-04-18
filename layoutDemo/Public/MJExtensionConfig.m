//
//  MJExtensionConfig.m
//  ManagementSys
//
//  Created by rp.wang on 16/5/27.
//  Copyright © 2016年 rp.wang. All rights reserved.
//

#import "MJExtensionConfig.h"
#import "MJExtension.h"
#import "Model.h"


@implementation MJExtensionConfig

/**
 *  这个方法会在MJExtensionConfig加载进内存时调用一次
 */
+ (void)load
{
#pragma mark 如果使用NSObject来调用这些方法，代表所有继承自NSObject的类都会生效
#pragma mark NSObject中的ID属性对应着字典中的id
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"Description":@"description"
                 };
    }];
}



@end
