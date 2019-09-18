//
//  FristCollectionViewCell.m
//  layoutDemo
//
//  Created by rp.wang on 16/9/23.
//  Copyright © 2016年 rp.wang. All rights reserved.
//

#import "FristCollectionViewCell.h"

#import "UIImageView+WebCache.h"

@implementation FristCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {

   
            //-------------------------
            self.GoodsImg = [[UIImageView alloc]initWithFrame:CGRectMake(18, 10, 90, 70)];
            [self addSubview:self.GoodsImg];
            
            //-------------------------
            //标题
            self.TitleLab = [[UILabel alloc]initWithFrame:CGRectMake(115, 15, self.frame.size.width - 120, 15)];
            self.TitleLab.font = [UIFont systemFontOfSize:16.5f];
            [self addSubview:self.TitleLab];
            
            //-------------------------
            //简介
            self.InfoLab = [[UILabel alloc]initWithFrame:CGRectMake(115, 35, self.frame.size.width - 120, 55)];
            
            self.InfoLab.textColor = [UIColor grayColor];
            self.InfoLab.font = [UIFont systemFontOfSize:14.f];
            self.InfoLab.numberOfLines = 0;
            [self addSubview:self.InfoLab];
        }

    return self;
    
}

-(void)FristCollreloadDataWith:(Model *)model
{
    //-------------------------
    //设置图片
    [self.GoodsImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.artworkUrl60]] placeholderImage:[UIImage imageNamed:@"chat_placeholder_image"]];
    
    self.TitleLab.text = [NSString stringWithFormat:@"%@",model.trackName];
    
    
    self.InfoLab.text = [NSString stringWithFormat:@"%@",model.Description];
    
}


@end
        
