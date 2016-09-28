//
//  UIDragButton.m
//  layoutDemo
//
//  Created by rp.wang on 16/9/26.
//  Copyright © 2016年 rp.wang. All rights reserved.
//

#import "UIDragButton.h"

@implementation UIDragButton

// 枚举四个吸附方向
typedef enum {
    LEFT,
    RIGHT,
    TOP,
    BOTTOM
}Dir;

/**
 *  开始触摸，记录触点位置用于判断是拖动还是点击
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    // 获得触摸在根视图中的坐标
    UITouch *touch = [touches anyObject];
    _startPos = [touch locationInView:_rootView];
    _startPos = [self ConvertDir:_startPos];
}

/**
 *  手指按住移动过程,通过悬浮按钮的拖动事件来拖动整个悬浮窗口
 */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 获得触摸在根视图中的坐标
    UITouch *touch = [touches anyObject];
    CGPoint curPoint = [touch locationInView:_rootView];
    curPoint = [self ConvertDir:curPoint];
    // 移动按钮到当前触摸位置
    self.superview.center = curPoint;
}

/**
 *  拖动结束后使悬浮窗口吸附在最近的屏幕边缘
 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 获得触摸在根视图中的坐标
    UITouch *touch = [touches anyObject];
    CGPoint curPoint = [touch locationInView:_rootView];
    curPoint = [self ConvertDir:curPoint];
    // 通知代理,如果结束触点和起始触点极近则认为是点击事件
    if (pow((_startPos.x - curPoint.x),2) + pow((_startPos.y - curPoint.y),2) < 1) {
        [self.btnDelegate ClickChangBtn:self];
        // 点击后不吸附
        return;
    }
    // 由于计算吸附时，坐标要转换到手机竖直不旋转时的坐标系，因此要保证屏幕宽度是竖直时的宽度，高度也是竖直时的高度，不随屏幕旋转而变化
    // 获取屏幕方向
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat W = DEF_SCREEN_WIDTH;
    CGFloat H = DEF_SCREEN_HEIGHT;
    if (orientation == UIInterfaceOrientationLandscapeRight||orientation ==UIInterfaceOrientationLandscapeLeft) {
        W = DEF_SCREEN_HEIGHT;
        H = DEF_SCREEN_WIDTH;
    }
    // 与四个屏幕边界距离
    CGFloat left = curPoint.x;
    CGFloat right = W - curPoint.x;
    CGFloat top = curPoint.y;
    CGFloat bottom = H - curPoint.y;
    // 计算四个距离最小的吸附方向
    Dir minDir = LEFT;
    CGFloat minDistance = left;
    if (right < minDistance) {
        minDistance = right;
        minDir = RIGHT;
    }
    if (top < minDistance) {
        minDistance = top;
        minDir = TOP;
    }
    if (bottom < minDistance) {
        minDir = BOTTOM;
    }
    
    // 开始吸附
    switch (minDir) {
        case LEFT:
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.superview.center = CGPointMake(self.superview.frame.size.width / 2 + 10, self.superview.center.y);
            }];
            break;
        }
        case RIGHT:
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.superview.center = CGPointMake(W - self.superview.frame.size.width / 2 - 10, self.superview.center.y);
            }];
            break;
        }
        case TOP:
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.superview.center = CGPointMake(self.superview.center.x, self.superview.frame.size.height / 2 + 74);
            }];
            break;
        }
        case BOTTOM:
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.superview.center = CGPointMake(self.superview.center.x, H - self.superview.frame.size.height / 2 - 10);
            }];
            break;
        }
        default:
            break;
    }
}

// 屏幕颠倒时坐标转换
- (CGPoint)UpsideDown:(CGPoint)p {
    return CGPointMake(DEF_SCREEN_WIDTH - p.x, DEF_SCREEN_HEIGHT - p.y);
}
// 屏幕左转时坐标转换
- (CGPoint)LandscapeLeft:(CGPoint)p {
    return CGPointMake(p.y, DEF_SCREEN_WIDTH - p.x);
}
// 屏幕右转时坐标转换
- (CGPoint)LandscapeRight:(CGPoint)p {
    return CGPointMake(DEF_SCREEN_HEIGHT - p.y, p.x);
}
/**
 *  坐标转换，转换到屏幕旋转之前的坐标系中
 */
- (CGPoint)ConvertDir:(CGPoint)p {
    // 获取屏幕方向
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    switch (orientation) {
        case UIInterfaceOrientationLandscapeLeft:
            return [self LandscapeLeft:p];
            break;
        case UIInterfaceOrientationLandscapeRight:
            return [self LandscapeRight:p];
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            return [self UpsideDown:p];
            break;
        default:
            return p;
            break;
    }
}


@end
