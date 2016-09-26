//
//  HomeTableViewCell.h
//  layoutDemo
//
//  Created by rp.wang on 16/9/23.
//  Copyright © 2016年 rp.wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import "Header.h"

@interface HomeTableViewCell : UITableViewCell


@property (strong, nonatomic) UIImageView *GoodsImg;

@property (strong, nonatomic) UILabel *TitleLab;

@property (strong, nonatomic) UILabel *InfoLab;

-(void)reloadDataWith:(Model *)model;
@end
