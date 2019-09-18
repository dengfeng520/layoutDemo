//
//  UIDragButton.h
//  layoutDemo
//
//  Created by rp.wang on 16/9/26.
//  Copyright © 2016年 rp.wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Header.h"

/**
 *  代理按钮的点击事件
 */
@protocol UIDragButtonDelegate <NSObject>

-(void)clickChangBtn:(UIButton *)Btn;

@end

@interface UIDragButton : UIButton

/**
 *  悬浮窗所依赖的根视图
 */
@property (nonatomic, strong)UIView *rootView;

/**
 *  UIDragButton的点击事件代理
 */
@property (nonatomic, weak)id<UIDragButtonDelegate>btnDelegate;

/**
 *  开始按下的触点坐标
 */
@property (nonatomic, assign)CGPoint startPos;
@end
