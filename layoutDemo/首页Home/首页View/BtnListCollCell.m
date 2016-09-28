//
//  BtnListCollCell.m
//  layoutDemo
//
//  Created by rp.wang on 16/9/28.
//  Copyright © 2016年 rp.wang. All rights reserved.
//

#import "BtnListCollCell.h"

@implementation BtnListCollCell


-(id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        
        
        //-------------------------
        //标题
        self.TitleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.TitleLab.font = [UIFont systemFontOfSize:14.5f];
        self.TitleLab.textColor = [UIColor grayColor];
        self.TitleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.TitleLab];
        
    }
    
    
    
    return self;
    
}

-(void)CollreloadDataWithBtn:(NSString *)BtnTitile
{
    self.TitleLab.text = BtnTitile;
}

@end
