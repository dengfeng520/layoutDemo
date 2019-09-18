//
//  ViewController+Extension.h
//  layoutDemo
//
//  Created by rp.wang on 2019/9/18.
//  Copyright © 2019 rp.wang. All rights reserved.
//

#import "ViewController.h"
#import "HomeCollectionViewCell.h"
#import "FristCollectionViewCell.h"
#import "UIDragButton.h"
#import "PayViewController.h"
#import "HeaderView.h"

#import "Header.h"
#import "ISInternet.h"
#import "Model.h"

#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "Masonry.h"
#import "MBProgressHUD.h"
#import "Best64.h"

#import "XHTestViewController.h"

static NSString * const HomeFristCellID = @"HomeTabCellID";

static NSString * const HomeCollCellID = @"HomeCollCellID";

NS_ASSUME_NONNULL_BEGIN

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,HeaderViewDelegate,UIDragButtonDelegate>

/**
 *  悬浮的window
 */
@property(strong, nonatomic) UIWindow *window;
/*
 *  首页数据源数组
 */
@property (strong, nonatomic) NSMutableArray *HomeDataList;
/*
 *  首页的九宫格视图
 */
@property (strong, nonatomic) UICollectionView *collectionView;
/*
 * 点击切换九宫格或列表，默认为YES
 */
@property (assign, nonatomic) BOOL ISChange;
/**
 *  悬浮的按钮
 */
@property (strong, nonatomic)  UIDragButton *ChangBtn;
/**
 *  九宫格分页显示相关，默认为1
 */
@property (assign, nonatomic) int CollPageNum;
/**
 *  九宫格分页显示相关默认为当前屏幕最多显示的条数
 */
@property (assign, nonatomic) int CollNumber;

@end

NS_ASSUME_NONNULL_END
