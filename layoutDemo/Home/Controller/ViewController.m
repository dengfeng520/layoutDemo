//
//  ViewController.m
//  FristScrollDemo
//
//  Created by rp.wang on 16/9/21.
//  Copyright © 2016年 rp.wang. All rights reserved.
//

#import "ViewController+Extension.h"

static NSString * const HomeFristCellID = @"HomeTabCellID";
static NSString * const HomeCollCellID = @"HomeCollCellID";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"HOME PAGE";
    
    [self configUI];
    [self configHeaderView];
    //------------------------
    [self configCollView];
    [self configChangeBtnView];
    [self configRefresh];
}

- (void)configUI {
    self.isChange = YES;
    //------------------------
    self.pageIndex = 1;
    self.pageSize = self.view.frame.size.height / 90;
    
    //设置整个视图的背景颜色
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //------------------------
    //判断设备是否联网
    if ([ISInternet isConnectionAvailable] == YES) {
        //从服务器获取到数据后updata
        [self fetchServerADData];
    } else {
        printf("\n---------没有联网给用户提示---------\n");
    }
}

- (void)configRefresh {
    //------------------------
    //下拉刷新
    __weak typeof (self) weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.collectionView.mj_header endRefreshing];
        if (weakSelf.homeDataList.count == 0) {
            [weakSelf fetchServerADData];
        } else {
            weakSelf.pageIndex = 1;
            weakSelf.pageSize = weakSelf.view.frame.size.height / 90;
            [weakSelf.collectionView reloadData];
        }
    }];
    
    //------------------------------
    //上拉加载更多
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^(void){
        // Hide the time
        [weakSelf.collectionView.mj_footer endRefreshing];
        ++weakSelf.pageIndex;
        weakSelf.pageSize = self.pageIndex * 4;
        [weakSelf.collectionView reloadData];
        if (weakSelf.pageSize >= self.homeDataList.count) {
            printf("\n--------暂无更多数据---------\n");
            --weakSelf.pageIndex;
        }
    }];
}

- (void)configHeaderView {
    //------------------------
    self.homeHeaderView = [[HeaderView alloc] init];
    self.homeHeaderView.BtnList = @[@"默认",@"热门",@"推荐",@"新品",@"价格"];
    self.homeHeaderView.clickHeaderBtnDelegate = self;
    [self.view addSubview:self.homeHeaderView];
    self.homeHeaderView.translatesAutoresizingMaskIntoConstraints = false;
    [[self.homeHeaderView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:0] setActive:true];
    [[self.homeHeaderView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0] setActive:true];
    [[self.homeHeaderView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0] setActive:true];
    [[self.homeHeaderView.heightAnchor constraintEqualToConstant:45] setActive:true];
}

- (void)configCollView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView  = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    //------------------------
    //代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //默认九宫格隐藏
    self.collectionView.prefetchDataSource = self;
    
    [self.collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:HomeCollCellID];
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.collectionView];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = false;
    [[self.collectionView.topAnchor constraintEqualToAnchor:self.homeHeaderView.topAnchor constant:0] setActive:true];
    [[self.collectionView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor] setActive:true];
    [[self.collectionView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor] setActive:true];
    [[self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor] setActive:true];
}

- (void)viewWillAppear:(BOOL)animated  {
    [super viewWillAppear:animated];
    [self.changBtn setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.changBtn setHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] init];
    self.navigationItem.backBarButtonItem.title = @"";
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

/// 初始化切换按钮
- (void)configChangeBtnView {
    //------------------------
    // 将视图尺寸设置为0，防止阻碍其他视图元素的交互
    self.view.frame = CGRectZero;
    // 悬浮按钮
    self.changBtn = [UIDragButton buttonWithType:UIButtonTypeCustom];
    [self.changBtn setBackgroundImage:[UIImage imageNamed:@"goods_two"] forState:UIControlStateNormal];
    // 按钮图片伸缩充满整个按钮
    self.changBtn.imageView.contentMode = UIViewContentModeScaleToFill;
    self.changBtn.frame = CGRectMake(0, 0, 40, 40);
    // 按钮点击事件
    [self.changBtn addTarget:self action:@selector(clickchangBtn:) forControlEvents:UIControlEventTouchUpInside];
    // 初始选中状态
    self.changBtn.selected = NO;
    // 禁止高亮
    self.changBtn.adjustsImageWhenHighlighted = NO;
    self.changBtn.rootView = self.view;
    self.changBtn.btnDelegate = self;
    
    // 悬浮窗
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH - 50, 115, 40, 40)];
    self.window.windowLevel = UIWindowLevelAlert + 1;
    self.window.backgroundColor = [UIColor clearColor];
    self.window.layer.cornerRadius = 5;
    self.window.layer.masksToBounds = YES;
    // 将按钮添加到悬浮按钮上
    [self.window addSubview:self.changBtn];
    //显示window
    [self.window makeKeyAndVisible];
}

/// 点击切换九宫格或列表
- (void)clickchangBtn:(UIButton *)Btn {
    self.isChange = !self.isChange;
    // 设置翻转方向
    UIViewAnimationOptions option;
    if (self.isChange == YES) {
        [self.changBtn setBackgroundImage:[UIImage imageNamed:@"goods_two"] forState:UIControlStateNormal];
        option =  UIViewAnimationOptionTransitionFlipFromLeft;
    } else {
        [self.changBtn setBackgroundImage:[UIImage imageNamed:@"goods_one"] forState:UIControlStateNormal];
        option =  UIViewAnimationOptionTransitionFlipFromRight;
    }
    
    void (^update)(void) = ^ {
        // reload data
    };
    [UIView transitionWithView:self.collectionView
                      duration:0.5f
                       options:option
                    animations:^ {

    } completion:^ (BOOL finished){
        update();
    }];
    
    [self.collectionView reloadData];
}

- (void)clickHeaderBtn:(int)cellID {
    printf("\n===============%d\n",cellID);
}

// MARK: - 公开接口
- (void)fetchServerADData {
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/search?term=game&country=cn&entity=software&pageSize=20&pageIndex=1"];
    //POST请求，设置30S超时
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error) {
        //在主线程中更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            if (data != nil) {
                NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSArray *lsList = [Model mj_objectArrayWithKeyValuesArray: [res objectForKey:@"results"]];
                for (int i = 0; i < 50; i++) {
                    [weakSelf.homeDataList addObjectsFromArray:lsList];
                }
                [weakSelf.collectionView reloadData];
            } else {
                //如果获取失败
                NSLog(@"请求失败=======%@",error);
            }
        });
    }];
    //使用resume方法启动任务
    [dataTask resume];
}

// MARK: - UICollectionView代理
//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.pageSize >= self.homeDataList.count) {
        return self.homeDataList.count;
    } else {
        return self.pageSize;
    }
}

//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isChange == YES) {
        [collectionView registerClass:[FristCollectionViewCell class] forCellWithReuseIdentifier:HomeFristCellID];
        FristCollectionViewCell *cell = (FristCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:HomeFristCellID forIndexPath:indexPath];
        if (!cell) {
            cell = [[FristCollectionViewCell alloc] init];
        }
        cell.backgroundColor = [UIColor whiteColor];
        [cell FristCollreloadDataWith:[self.homeDataList objectAtIndex:indexPath.row]];
        
        return cell;
    } else {
        [collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:HomeCollCellID];
        HomeCollectionViewCell *collcell = (HomeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:HomeCollCellID forIndexPath:indexPath];
        if (!collcell) {
            
            collcell = [[HomeCollectionViewCell alloc] init];
        }
        collcell.backgroundColor = [UIColor whiteColor];
        [collcell CollreloadDataWith:[self.homeDataList objectAtIndex:indexPath.row]];
        return collcell;
        
    }
    return nil;
}
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat screenWith = self.view.frame.size.width;
    CGFloat cellWidth,cellHeight;
    if (self.isChange == YES) {
        cellWidth = screenWith;
        
        cellHeight = 90.f;
        
    } else {
        //每行2个Cell
        cellWidth = (screenWith - 2 ) / 2 - 2.5;
        
        cellHeight = cellWidth + 80;
    }
    return CGSizeMake(cellWidth, cellHeight);
}
//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(2.5, 0, 0, 0);
}
//UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    //获取数据后跳转
    
    //跳转判断在ViewModel中完成,此处根据点击的indexPath.row判断点击的是哪一行
    PayViewController *PayView = [[PayViewController alloc]initWithNibName:@"PayViewController" bundle:nil];
    
    [self.navigationController pushViewController:PayView animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = {5.f,5.f};
    return size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5.f;
}

#pragma mark - 内存相关
- (NSMutableArray <Model *> *)homeDataList {
    if (_homeDataList == nil) {
        _homeDataList = [NSMutableArray array];
    }
    return _homeDataList;
}

@end
