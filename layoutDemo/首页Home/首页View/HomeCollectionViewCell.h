//
//  HomeCollectionViewCell.h
//  layoutDemo
//
//  Created by rp.wang on 16/9/23.
//  Copyright © 2016年 rp.wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "Model.h"

@interface HomeCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic)  UIImageView *GoodsImg;

@property (strong, nonatomic)  UILabel *TitleLab;

@property (strong, nonatomic)  UILabel *InfoLab;

@property (assign, nonatomic) BOOL ISNotChange;

-(id)initWithFrame:(CGRect)frame;

-(void)CollreloadDataWith:(Model *)model;
@end
