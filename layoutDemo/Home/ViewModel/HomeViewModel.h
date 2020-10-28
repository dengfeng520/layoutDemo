//
//  HomeViewModel.h
//  layoutDemo
//
//  Created by rp.wang on 2020/10/28.
//  Copyright © 2020 rp.wang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewModel : NSObject
- (void)fetchLivingRoom:(NSString *)path secuessBlock:(void(^)(NSDictionary *secuess))block;
@end

NS_ASSUME_NONNULL_END
