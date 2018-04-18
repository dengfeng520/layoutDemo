//
//  ISInternet.h
//  ScrollDemo
//
//  Created by rp.wang on 16/9/20.
//  Copyright © 2016年 rp.wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface ISInternet : NSObject

/**
 *  检查设备是否联网
 */
+(BOOL) isConnectionAvailable;


+(void)setExtraCellLineHidden: (UITableView *)tableView;
@end
