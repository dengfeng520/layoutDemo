//
//  HeaderView.h
//  layoutDemo
//
//  Created by rp.wang on 16/9/28.
//  Copyright © 2016年 rp.wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BtnListCollCell.h"

static NSString * const HeaderViewBtnCellID = @"HeaderViewBtnCellID";

/**
 *  代理事件
 */
@protocol HeaderViewDelegate <NSObject>

-(void)clickHeaderBtn:(int)cellID;

@end

@interface HeaderView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

/*
 * 按钮的数组
 */
@property(strong, nonatomic) NSArray *BtnList;


@property (strong, nonatomic) UICollectionView *headerBtnListView;


@property (nonatomic, weak) id <HeaderViewDelegate> clickHeaderBtnDelegate;
@end
