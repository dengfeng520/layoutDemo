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

@property (assign, nonatomic) BOOL ISAnmin;
@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.ISAnmin = NO;
    
    self.AnminView = [[UIView alloc]init];
    [self.view addSubview:self.AnminView];
    __weak typeof (self) weakSelf = self;
    [self.AnminView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(70.f);
        make.centerX.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    self.AnminView.backgroundColor = [UIColor redColor];
    
    
    
    //-----------------------------
    UIButton *AnminBtn = [[UIButton alloc]init];
    [self.view addSubview:AnminBtn];
    [AnminBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //居中
        make.centerX.equalTo(weakSelf.view);
        //设置宽度
        make.width.equalTo(weakSelf.view.mas_width).multipliedBy(0.8);
        make.height.mas_equalTo(45);
        make.bottom.equalTo(weakSelf.view).with.offset(-100);

        
    }];
    AnminBtn.backgroundColor = [UIColor redColor];
    AnminBtn.layer.cornerRadius = 5.f;
    [AnminBtn setTitle:@"阻尼效果" forState:UIControlStateNormal];
    [AnminBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    AnminBtn.tag = 100;
    [AnminBtn addTarget:self action:@selector(ClickAnminBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //-----------------------------
    UIButton *AnminBtnTWo = [[UIButton alloc]init];
    [self.view addSubview:AnminBtnTWo];
    [AnminBtnTWo mas_makeConstraints:^(MASConstraintMaker *make) {
        //居中
        make.centerX.equalTo(weakSelf.view);
        //设置宽度
        make.width.equalTo(weakSelf.view.mas_width).multipliedBy(0.8);
        //设置高度
        make.height.mas_equalTo(45);
        make.bottom.equalTo(weakSelf.view).with.offset(-40);
    }];
    AnminBtnTWo.backgroundColor = [UIColor redColor];
    AnminBtnTWo.layer.cornerRadius = 5.f;
    [AnminBtnTWo setTitle:@"平移动画效果" forState:UIControlStateNormal];
    [AnminBtnTWo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    AnminBtnTWo.tag = 101;
    [AnminBtnTWo addTarget:self action:@selector(ClickAnminBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //-----------------------------
    UIButton *AnminBtnThrid = [[UIButton alloc]init];
    [self.view addSubview:AnminBtnThrid];
    [AnminBtnThrid mas_makeConstraints:^(MASConstraintMaker *make) {
        //居中
        make.centerX.equalTo(weakSelf.view);
        //设置宽度
        make.width.equalTo(weakSelf.view.mas_width).multipliedBy(0.8);
        //设置高度
        make.height.mas_equalTo(45);
        make.bottom.equalTo(weakSelf.view).with.offset(-155);
        
        
    }];
    AnminBtnThrid.backgroundColor = [UIColor redColor];
    AnminBtnThrid.layer.cornerRadius = 5.f;
    [AnminBtnThrid setTitle:@"翻页动画效果" forState:UIControlStateNormal];
    [AnminBtnThrid setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    AnminBtnThrid.tag = 102;
    [AnminBtnThrid addTarget:self action:@selector(ClickAnminBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //-----------------------------
    UIButton *AnminBtnFour = [[UIButton alloc]init];
    [self.view addSubview:AnminBtnFour];
    [AnminBtnFour mas_makeConstraints:^(MASConstraintMaker *make) {
        //居中
        make.centerX.equalTo(weakSelf.view);
        //设置宽度
        make.width.equalTo(weakSelf.view.mas_width).multipliedBy(0.8);
        //设置高度
        make.height.mas_equalTo(45);
        make.bottom.equalTo(weakSelf.view).with.offset(-210);
        
        
    }];
    AnminBtnFour.backgroundColor = [UIColor redColor];
    AnminBtnFour.layer.cornerRadius = 5.f;
    [AnminBtnFour setTitle:@"翻转动画效果" forState:UIControlStateNormal];
    [AnminBtnFour setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    AnminBtnFour.tag = 103;
    [AnminBtnFour addTarget:self action:@selector(ClickAnminBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)ClickAnminBtn :(UIButton *)Btntag {
    __weak typeof (self) weakSelf = self;
    switch (Btntag.tag) {
        case 100: {
            printf("\n==================阻尼动画效果\n");
            UIViewPropertyAnimator *AnminTwo = [[UIViewPropertyAnimator alloc]initWithDuration:0.8 dampingRatio:0.3 animations:^(){
                weakSelf.ISAnmin = !weakSelf.ISAnmin;
                if (weakSelf.ISAnmin == YES) {
                    weakSelf.AnminView.center = CGPointMake((DEF_SCREEN_WIDTH / 2), DEF_SCREEN_HEIGHT - (self.AnminView.frame.size.height / 2));
                    
                } else {
                    weakSelf.AnminView.center = CGPointMake((DEF_SCREEN_WIDTH / 2), 114.f);
                }
                
                
            }];
            [AnminTwo startAnimation];
        }
            break;
        case 101: {
            printf("\n==================平移动画效果\n");
            UIViewPropertyAnimator *AnminTwo = [[UIViewPropertyAnimator alloc]initWithDuration:0.5 curve:UIViewAnimationCurveLinear animations:^{
            weakSelf.ISAnmin = !weakSelf.ISAnmin;
            if (weakSelf.ISAnmin == YES) {
                weakSelf.AnminView.center = CGPointMake((DEF_SCREEN_WIDTH / 2), DEF_SCREEN_HEIGHT - (self.AnminView.frame.size.height / 2));
                
            } else {
                weakSelf.AnminView.center = CGPointMake((DEF_SCREEN_WIDTH / 2), 114.f);
            }

        }];
            
        [AnminTwo startAnimation];

        }
            break;
        case 102: {
            printf("\n==================翻页动画效果\n");
            [UIView beginAnimations:@"animation" context:nil];
            [UIView setAnimationDuration:1.0f];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
            [UIView commitAnimations];
        }
            break;
        case 103: {
            CATransition *transition = [CATransition animation];
            transition.duration = 1.0f;
            transition.type = @"oglFlip";
            /*
             *淡化、推挤、揭开、覆盖
             NSString * const kCATransitionFade;
             NSString * const kCATransitionMoveIn;
             NSString * const kCATransitionPush;
             NSString * const kCATransitionReveal;
             *动画方向
             NSString * const kCATransitionFromRight;
             NSString * const kCATransitionFromLeft;
             NSString * const kCATransitionFromTop;
             NSString * const kCATransitionFromBottom;
             私有的类型的动画类型：
             立方体、吸收、翻转、波纹、翻页、反翻页、镜头开、镜头关
             animation.type = @"cube"
             animation.type = @"suckEffect";
             animation.type = @"oglFlip";//不管subType is "fromLeft" or "fromRight",official只有一种效果
             animation.type = @"rippleEffect";
             animation.type = @"pageCurl";
             animation.type = @"pageUnCurl"
             animation.type = @"cameraIrisHollowOpen ";
             animation.type = @"cameraIrisHollowClose ";
             */
            transition.subtype = kCATransitionFromRight;
//            [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
            [self.view.layer addAnimation:transition forKey:@"animation"];
        }
            break;
        default:
            break;
    }
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
