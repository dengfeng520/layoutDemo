//
//  HomeCollectionViewCell.m
//  layoutDemo
//
//  Created by rp.wang on 16/9/23.
//  Copyright © 2016年 rp.wang. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation HomeCollectionViewCell

- (id)initWithFrame:(CGRect)frame  {
    if ((self = [super initWithFrame:frame])) {
        self.GoodsImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, self.frame.size.width - 20, self.frame.size.width - 20)];
            [self addSubview:self.GoodsImg];
            
            //-------------------------
            //标题
            self.TitleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, self.GoodsImg.frame.size.height + 13, self.frame.size.width - 20, 15)];
            self.TitleLab.font = [UIFont systemFontOfSize:16.5f];
            [self addSubview:self.TitleLab];
            
            //-------------------------
            //简介
            self.InfoLab = [[UILabel alloc]initWithFrame:CGRectMake(10, self.TitleLab.frame.size.height + self.TitleLab.frame.origin.y, self.frame.size.width - 20, self.frame.size.height - self.TitleLab.frame.size.height - self.TitleLab.frame.origin.y  -10)];
            
            self.InfoLab.textColor = [UIColor grayColor];
            self.InfoLab.font = [UIFont systemFontOfSize:14.f];
            self.InfoLab.numberOfLines = 0;
            [self addSubview:self.InfoLab];
        }
          return self;

}

- (void)CollreloadDataWith:(Model *)model {
    //-------------------------
    //设置图片
    [self.GoodsImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.artworkUrl60]] placeholderImage:[UIImage imageNamed:@"chat_placeholder_image"]];
    
    self.TitleLab.text = [NSString stringWithFormat:@"%@",model.trackName];
    
    self.InfoLab.text = [NSString stringWithFormat:@"%@",model.Description];
}

@end
