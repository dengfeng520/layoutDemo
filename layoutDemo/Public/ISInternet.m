//
//  ISInternet.m
//  ScrollDemo
//
//  Created by rp.wang on 16/9/20.
//  Copyright © 2016年 rp.wang. All rights reserved.
//

#import "ISInternet.h"

@implementation ISInternet

+(BOOL) isConnectionAvailable
{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostname:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            break;
    }
    
    if (!isExistenceNetwork)
    {
        return NO;
    }
    return isExistenceNetwork;
}


+(void)setExtraCellLineHidden: (UITableView *)tableView
{
    
    UIView *view =[ [UIView alloc]init];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
    [tableView setTableHeaderView:view];
    
}

@end
