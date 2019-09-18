//
//  ViewController.m
//  FristScrollDemo
//
//  Created by rp.wang on 16/9/21.
//  Copyright © 2016年 rp.wang. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+Extension.h"

static NSString * const HomeFristCellID = @"HomeTabCellID";
static NSString * const HomeCollCellID = @"HomeCollCellID";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"HOME PAGE";
    
    self.ISChange = YES;
    //------------------------
    self.CollPageNum = 1;
    self.CollNumber = self.view.frame.size.height / 90;
    
    //设置整个视图的背景颜色
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //------------------------
    [self configCollView];
    
    //------------------------
    //判断设备是否联网
    if ([ISInternet isConnectionAvailable] == YES) {
        //从服务器获取到数据后updata
        [self GetServerADData];
    } else {
        printf("\n---------没有联网给用户提示---------\n");
    }
    
    NSArray *LsList = @[@"1",@"2",@"2",@"3",@"3",@"4",@"5",@"7",@"8",@"8"];
    NSSet *LsSet = [NSSet setWithArray:LsList];
    NSLog(@"=====================%@",LsSet);
    
    
    //------------------------
    //下拉刷新
    __weak typeof (self) weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf.collectionView.mj_header endRefreshing];
        if (weakSelf.HomeDataList.count == 0) {
            [weakSelf GetServerADData];
        } else {
            weakSelf.CollPageNum = 1;
            weakSelf.CollNumber = weakSelf.view.frame.size.height / 90;
            [weakSelf.collectionView reloadData];
        }
    }];
    
    //------------------------------
    //上拉加载更多
       self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^(void){
        
        // Hide the time
        [weakSelf.collectionView.mj_footer endRefreshing];
        ++weakSelf.CollPageNum;
        weakSelf.CollNumber = self.CollPageNum * 4;
        [weakSelf.collectionView reloadData];
        if (weakSelf.CollNumber >= self.HomeDataList.count) {
            printf("\n--------暂无更多数据---------\n");
            --weakSelf.CollPageNum;
        }

    }];
    
    
    
    //------------------------
    // 将视图尺寸设置为0，防止阻碍其他视图元素的交互
    self.view.frame = CGRectZero;
    // 延时显示悬浮窗口
    [self performSelector:@selector(configChangeBtnView) withObject:nil afterDelay:1];
    
    
    //------------------------
    HeaderView *HomeHeaderView = [[HeaderView alloc] initWithHeaderView:CGPointMake(0, 64) andHeight:45];
    HomeHeaderView.BtnList = @[@"默认",@"热门",@"推荐",@"新品",@"价格"];
    HomeHeaderView.clickHeaderBtnDelegate = self;
    [self.view addSubview:HomeHeaderView];
}

- (void)fetchLivingRoom:(NSString *)retData secuessBlock:(void(^)(NSDictionary *secuess))getData {
    NSString *post = [NSString stringWithFormat:@"%@",retData];
    NSData *postdata = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:@"http://101.201.233.205/sdk/login.php"];
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
//                                                  NSLog(@"服务器返回的数据===%@",res);
                                                  
                                              } else {
                                                  //如果获取失败
                                                  NSLog(@"请求失败=======%@",error);
                                              }
                                              
                                          });
                                          
                                      }];
    //使用resume方法启动任务
    [dataTask resume];
    
}

- (void)configCollView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView  = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    
    //------------------------
    //代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //默认九宫格隐藏
    self.collectionView.prefetchDataSource = self;
    
    [self.collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:HomeCollCellID];
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.collectionView];
    
    __weak typeof (self) weakSelf = self;
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        //使左边等于self.view的左边，间距为0
        make.left.equalTo(weakSelf.view.mas_left).offset(0);
        //使顶部与self.view的间距为45
        make.top.equalTo(weakSelf.view.mas_top).offset(45);
        //设置宽度
        make.width.equalTo(weakSelf.view.mas_width).multipliedBy(1);
        //设置高度
        make.height.equalTo(weakSelf.view.mas_height).multipliedBy(1);
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated  {
    [super viewWillAppear:animated];
    
    [self.ChangBtn setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.ChangBtn setHidden:YES];
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


/*
 *  初始化切换按钮
 */
- (void)configChangeBtnView {
    // 悬浮按钮
    self.ChangBtn = [UIDragButton buttonWithType:UIButtonTypeCustom];
    [self.ChangBtn setBackgroundImage:[UIImage imageNamed:@"goods_two"] forState:UIControlStateNormal];
    // 按钮图片伸缩充满整个按钮
    self.ChangBtn.imageView.contentMode = UIViewContentModeScaleToFill;
    self.ChangBtn.frame = CGRectMake(0, 0, 40, 40);
    self.ChangBtn.clickDragBlock = ^(UIButton *dragBtn) {
        NSLog(@"================");
        
    };
    // 按钮点击事件
    [self.ChangBtn addTarget:self action:@selector(clickChangBtn:) forControlEvents:UIControlEventTouchUpInside];
    // 初始选中状态
    self.ChangBtn.selected = NO;
    // 禁止高亮
    self.ChangBtn.adjustsImageWhenHighlighted = NO;
    self.ChangBtn.rootView = self.view.superview;
    self.ChangBtn.btnDelegate = self;
    self.ChangBtn.imageView.alpha = 0.8;
    
    // 悬浮窗
    _window = [[UIWindow alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH - 50, 115, 40, 40)];
    _window.windowLevel = UIWindowLevelAlert + 1;
    _window.backgroundColor = [UIColor clearColor];
    _window.layer.cornerRadius = 5;
    _window.layer.masksToBounds = YES;
    // 将按钮添加到悬浮按钮上
    [_window addSubview:self.ChangBtn];
    //显示window
    [_window makeKeyAndVisible];
}



/*
 *  点击切换九宫格或列表
 */
- (void)clickChangBtn:(UIButton *)Btn {
   
    self.ISChange = !self.ISChange;
    // 设置翻转方向
    UIViewAnimationOptions option;
    if (self.ISChange == YES) {
        [self.ChangBtn setBackgroundImage:[UIImage imageNamed:@"goods_two"] forState:UIControlStateNormal];
        
       option =  UIViewAnimationOptionTransitionFlipFromLeft;
       
    } else {
        [self.ChangBtn setBackgroundImage:[UIImage imageNamed:@"goods_one"] forState:UIControlStateNormal];
        
        option =  UIViewAnimationOptionTransitionFlipFromRight;
    }
    
    void (^update)(void) = ^ {
        // reload data
    };
    [UIView transitionWithView:self.collectionView
                      duration:0.5f
                       options:option
                    animations:^ {
                        
                    }
                    completion:^ (BOOL finished){
                        update();
                    }];

    [self.collectionView reloadData];
}

- (void)clickHeaderBtn:(int)cellID {
    printf("\n===============%d\n",cellID);
}

#pragma mark - 公开接口
- (void)GetServerADData {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSURL *url = [NSURL URLWithString:APPLE_SERVER];
    //POST请求，设置30S超时
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error) {
                                          //在主线程中更新UI
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                                              if (data != nil) {
                                                  NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                                                  NSLog(@"服务器返回的数据===%@",res);
                                                  NSArray *lsList = [Model mj_objectArrayWithKeyValuesArray: [res objectForKey:@"results"]];
                                                 
                                                  for (int i = 0;i<50;i++) {
                                                      [self.HomeDataList addObjectsFromArray:lsList];
                                                  }
                                                  
                                                  //获取数据
                                           
                                                  //updata
//                                                  [self GetTraversalDatafromList:self.HomeDataList];
                                                  [self.collectionView reloadData];
                                              } else {
                                                  //如果获取失败
                                                  NSLog(@"请求失败=======%@",error);
                                              }

                                          
                                          });
                                          
                                      }];
    //使用resume方法启动任务
    [dataTask resume];
}


/**
 *  采用Objective-C 1.0的NSEnumerator方法
 */
- (NSSet *)GetTraversalDatafromList:(NSArray *)DataAry {
    NSSet *WXList = [[NSSet alloc]init];
    WXList = [NSSet setWithArray:DataAry];
    return WXList;
}

#pragma mark - UICollectionView代理
//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.CollNumber >= self.HomeDataList.count) {
        return self.HomeDataList.count;
    } else {
        return self.CollNumber;
    }
}

//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (self.ISChange == YES) {
        [self.collectionView registerClass:[FristCollectionViewCell class] forCellWithReuseIdentifier:HomeFristCellID];
        FristCollectionViewCell *cell = (FristCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:HomeFristCellID forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[FristCollectionViewCell alloc] init];
            
            
        }
        cell.backgroundColor = [UIColor whiteColor];
        [cell FristCollreloadDataWith:[self.HomeDataList objectAtIndex:indexPath.row]];
        
        return cell;
        
    } else {
      

        [self.collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:HomeCollCellID];
        HomeCollectionViewCell *collcell = (HomeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:HomeCollCellID forIndexPath:indexPath];
        if (!collcell) {
            
            collcell = [[HomeCollectionViewCell alloc] init];
        }
        collcell.backgroundColor = [UIColor whiteColor];
        [collcell CollreloadDataWith:[self.HomeDataList objectAtIndex:indexPath.row]];
        
        return collcell;

    }
    return nil;
}
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat screenWith = self.view.frame.size.width;
    CGFloat cellWidth,cellHeight;
    if (self.ISChange == YES) {
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
- (NSMutableArray *)HomeDataList {
    if (_HomeDataList == nil) {
        _HomeDataList = [NSMutableArray array];
    }
    return _HomeDataList;
}

@end
