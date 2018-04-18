//
//  XHTestViewController.m
//  testApp
//
//  Created by ColdMountain on 2017/3/8.
//  Copyright © 2017年 ColdMountain. All rights reserved.
//

#import "XHTestViewController.h"

#import "XHTestCell.h"

@interface XHTestViewController ()<XHTestCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *ui_tableView;
@property (weak, nonatomic) IBOutlet UIView *ui_menuItemTagView;
@property (weak, nonatomic) IBOutlet UIButton *ui_orderBtn1;
@property (weak, nonatomic) IBOutlet UIButton *ui_orderBtn2;
@property (weak, nonatomic) IBOutlet UIButton *ui_orderBtn3;
@property (strong, nonatomic) NSArray * m_dataArray;
@property (assign, nonatomic) CGFloat m_noteHeight;
@end

@implementation XHTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.m_dataArray = [NSArray new];
    
    [self.ui_tableView registerNib:[UINib nibWithNibName:@"XHTestCell" bundle:nil] forCellReuseIdentifier:XHTestCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.m_dataArray = @[@{@"note":@"PDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDDPDD",
                           @"class":@"1"},
                         @{@"note":@"五五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开五开",
                           @"class":@"2"}
                         ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; 
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.m_dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = nil;
    
    cell = [self testCell:indexPath];
    
    return cell;
}

- (XHTestCell *)testCell:(NSIndexPath*)indexPath
{
    XHTestCell *cell = [self.ui_tableView dequeueReusableCellWithIdentifier:XHTestCellIdentifier];
    cell.delegate=self;
    NSDictionary * dic = self.m_dataArray[indexPath.section];
    cell.ui_noteLabel.text = [NSString stringWithFormat:@"%@",dic[@"note"]];
    NSString * class = [NSString stringWithFormat:@"%@",dic[@"class"]];
    if ([class isEqualToString:@"1"])
    {
        //存在三个按钮
        cell.ui_bgView.hidden=NO;
    }
    else if ([class isEqualToString:@"2"])
    {
        cell.ui_bgView.hidden=YES;
    }
    
    return cell;
}

#pragma - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height=500;
    NSDictionary * dic = self.m_dataArray[indexPath.section];
    NSString * class = [NSString stringWithFormat:@"%@",dic[@"class"]];
    XHTestCell * cell = (XHTestCell*)[self tableView:self.ui_tableView cellForRowAtIndexPath:indexPath];
    [cell setNoteLayout];
    if ([class isEqualToString:@"1"])
    {
        //存在三个按钮
        height = [cell  setNoteLayout]+250;
        
    }
    else if ([class isEqualToString:@"2"])
    {
        height = [cell  setNoteLayout] + 200;
    }

    return height;
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0.1;
    return height;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat height = 5;
    return height;
}

#pragma XHTestCellDelegate

- (void)testCellWithNoteHeight:(CGFloat)noteHeight
{
    self.m_noteHeight = noteHeight;
//    [self.ui_tableView reloadData];
    NSLog(@"%.f",self.m_noteHeight);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
