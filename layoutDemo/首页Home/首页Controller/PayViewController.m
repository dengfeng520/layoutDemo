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

static NSString * const PayViewCellID = @"PayViewCellID";

@interface PayViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.title = @"支付充值";
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [ISInternet setExtraCellLineHidden:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 4)
    {
        return 45.f;
    }else if(indexPath.row == 0)
    {
        return  70;
    }else
    {
        return 150;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PayViewCellID];
    
    switch (indexPath.row) {
        case 0:
        {
           cell.textLabel.text = @"账号：123456789";
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"充值金额";
            cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
            break;
        case 2:
        {
            NSArray *labelAry = @[@"50",@"100",@"500",@"1000",@"2000",@"5000"];
            for(int i = 0  ; i < labelAry.count ; i++)
            {
                CGFloat magin = 30;
                CGFloat lbW = DEF_SCREEN_WIDTH / 3 - 30;
                CGFloat lbH = 30;
                CGFloat lbX = 15 + i % 3 * (lbW+magin);
                CGFloat lbY = 5 + i / 3 * (lbH+10);
                UIButton * lb = [[UIButton alloc] initWithFrame:CGRectMake(lbX, lbY, lbW, lbH)];
                [lb setTitle:[labelAry objectAtIndex:i] forState:UIControlStateNormal];
                lb.titleLabel.font = [UIFont systemFontOfSize:14.f];
                lb.layer.borderWidth = 2.0;
                lb.layer.cornerRadius = 5.0;
                lb.tag = 100 + i;
                [lb addTarget:self action:@selector(menuListBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                lb.layer.borderColor = [UIColorFromRGB(0x51A6FF) CGColor];
                [lb setTitleColor:UIColorFromRGB(0x51A6FF) forState:UIControlStateNormal];
                
                [cell addSubview:lb];
                
            }
            
            
            UITextField *number = [[UITextField alloc]initWithFrame:CGRectMake(15, 80, DEF_SCREEN_WIDTH - 30, 30)];
            [cell addSubview:number];
            number.layer.borderWidth = 2;
            number.layer.cornerRadius = 5.f;
            number.layer.borderColor = [UIColorFromRGB(0x51A6FF) CGColor];
            number.placeholder = @"输入自定义";
            
            
            
            UILabel *NumTxt = [[UILabel alloc]initWithFrame:CGRectMake(15, 120, DEF_SCREEN_WIDTH - 30, 20)];
            NumTxt.text = @"可获得1000平台币";
            [cell addSubview:NumTxt];
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"选择支付方式";
            cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
            break;
        case 4:
        {
            cell.textLabel.text = @"支付宝";
            // 右边的箭头
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;

        case 5:
        {
             cell.textLabel.text = @"客服QQ12937198312    QQ群：2349252952";
            cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
            break;
       
        default:
            break;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //去除点击效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)menuListBtnClicked:(id)sender {

    UIButton *button = (UIButton*)sender;
    button.layer.borderColor = [UIColorFromRGB(0x51A6FF) CGColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = UIColorFromRGB(0x51A6FF);

    NSString * btnTitle = [button titleForState:UIControlStateNormal];
    NSLog(@"============%@",btnTitle);
    if ([btnTitle isEqualToString:@"50"]) {
        
        
    } else if ([btnTitle isEqualToString:@"100"]) {
        
       
    } else if ([btnTitle isEqualToString:@"500"]) {
        
        
    } else if ([btnTitle isEqualToString:@"1000"]) {
        
        
    } else if ([btnTitle isEqualToString:@"2000"]) {
        
        
    } else if ([btnTitle isEqualToString:@"5000"]) {
  
    }
}
@end
