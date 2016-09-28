//
//  BtnListCollCell.h
//  layoutDemo
//
//  Created by rp.wang on 16/9/28.
//  Copyright © 2016年 rp.wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BtnListCollCell : UICollectionViewCell


@property (strong, nonatomic)  UILabel *TitleLab;


-(id)initWithFrame:(CGRect)frame;

-(void)CollreloadDataWithBtn:(NSString *)BtnTitile;

@end
