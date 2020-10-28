//
//  HomeViewModel.m
//  layoutDemo
//
//  Created by rp.wang on 2020/10/28.
//  Copyright © 2020 rp.wang. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel
- (void)fetchLivingRoom:(NSString *)path secuessBlock:(void(^)(NSDictionary *secuess))block {
    NSString *post = [NSString stringWithFormat:@"%@",path];
    NSData *postdata = [post dataUsingEncoding:NSUTF8StringEncoding];
    //    NSURL *url = [NSURL URLWithString:@"http://101.201.233.205/sdk/login.php"];
    NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/lookup"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSMutableData *commit = [[NSMutableData alloc]init];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:commit];
    [commit appendData:postdata];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error) {
        //在主线程中更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if(data != nil) {
                NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"服务器返回的数据===%@",res);
            } else {
                //如果获取失败
                NSLog(@"请求失败=======%@",error);
            }
            
        });
        
    }];
    //使用resume方法启动任务
    [dataTask resume];
}


@end
