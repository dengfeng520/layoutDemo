//
//  HomeTableViewCell.m
//  layoutDemo
//
//  Created by rp.wang on 16/9/23.
//  Copyright © 2016年 rp.wang. All rights reserved.
//

#import "HomeTableViewCell.h"

#import "UIImageView+WebCache.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        //-------------------------
        self.GoodsImg = [[UIImageView alloc]initWithFrame:CGRectMake(18, 10, 90, 70)];
        [self addSubview:self.GoodsImg];
       
        //-------------------------
        //标题
        self.TitleLab = [[UILabel alloc]initWithFrame:CGRectMake(115, 15, DEF_SCREEN_WIDTH - 120, 15)];
        self.TitleLab.font = [UIFont systemFontOfSize:16.5f];
        [self addSubview:self.TitleLab];
        
        //-------------------------
        //简介
        self.InfoLab = [[UILabel alloc]initWithFrame:CGRectMake(115, 35, DEF_SCREEN_WIDTH - 120, 55)];
        
        self.InfoLab.textColor = [UIColor grayColor];
        self.InfoLab.font = [UIFont systemFontOfSize:14.f];
        self.InfoLab.numberOfLines = 0;
        [self addSubview:self.InfoLab];

    }
    return self;
    
}

-(void)reloadDataWith:(Model *)model
{
    //-------------------------
    //设置图片
    [self.GoodsImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.artworkUrl60]] placeholderImage:[UIImage imageNamed:@"chat_placeholder_image"]];
    
    self.TitleLab.text = [NSString stringWithFormat:@"%@",model.trackName];
    
    
    self.InfoLab.text = [NSString stringWithFormat:@"%@",model.Description];

}
@end
