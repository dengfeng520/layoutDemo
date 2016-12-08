//
//  PayViewController.m
//  layoutDemo
//
//  Created by rp.wang on 16/9/26.
//  Copyright © 2016年 rp.wang. All rights reserved.
//

#import "PayViewController.h"
#import "Header.h"
#import "ISInternet.h"
#import "Masonry.h"

static NSString * const PayViewCellID = @"PayViewCellID";

@interface PayViewController ()


@property (strong, nonatomic) UIView *AnminView;
@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.AnminView = [[UIView alloc]init];
    [self.view addSubview:self.AnminView];
    __weak typeof (self) weakSelf = self;
    [self.AnminView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).offset(70.f);
        make.centerX.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(80, 80));

    }];
    self.AnminView.backgroundColor = [UIColor redColor];

    
    UIButton *AnminBtn = [[UIButton alloc]init];
    [self.view addSubview:AnminBtn];
    [AnminBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //居中
        make.centerX.equalTo(weakSelf.view);
        //设置宽度
        make.width.equalTo(self.view.mas_width).multipliedBy(0.8);
        //设置高度
        make.height.equalTo(weakSelf.view.mas_height).height.offset(-80);
        
    }];
    AnminBtn.backgroundColor = [UIColor redColor];
    AnminBtn.layer.cornerRadius = 5.f;
    [AnminBtn setTitle:@"动画" forState:UIControlStateNormal];
    [AnminBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [AnminBtn addTarget:self action:@selector(ClickAnminBtn) forControlEvents:UIControlEventTouchUpInside];
   
}

-(void)ClickAnminBtn
{
//    UIViewPropertyAnimator *animator = [[UIViewPropertyAnimator  alloc]initWithDuration:0.8 curve:UIViewAnimationCurveEaseOut animations:^(){
//        
//        self.AnminView.center = CGPointMake((DEF_SCREEN_WIDTH / 2), DEF_SCREEN_HEIGHT - (self.AnminView.frame.size.height / 2));
//    }];
//    [animator startAnimation];
    
    UIViewPropertyAnimator *AnminTwo = [[UIViewPropertyAnimator alloc]initWithDuration:0.8 dampingRatio:0.5 animations:^(){
        self.AnminView.center = CGPointMake((DEF_SCREEN_WIDTH / 2), DEF_SCREEN_HEIGHT - (self.AnminView.frame.size.height / 2));

    }];
    [AnminTwo startAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
