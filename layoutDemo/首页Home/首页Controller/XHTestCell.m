//
//  XHTestCell.m
//  testApp
//
//  Created by ColdMountain on 2017/3/8.
//  Copyright © 2017年 ColdMountain. All rights reserved.
//

#import "XHTestCell.h"

//#import "XHTestViewController.h"
//
//@interface XHTestCell()
//
//@end

@implementation XHTestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //防止Block循环引用
    __weak typeof (self) weakSelf = self;
    self.ui_noteLabel = [[UILabel alloc]init];
    [self addSubview:self.ui_noteLabel];
    [weakSelf.ui_noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
       make.top.equalTo(weakSelf.TopLab.mas_bottom).offset(5);
       make.left.equalTo(weakSelf.LeftLab.mas_right).offset(5);
       make.right.equalTo(weakSelf).offset(-5);
       make.bottom.equalTo(weakSelf.BomLab.mas_top).offset(-5);
    }];
    self.ui_noteLabel.backgroundColor = [UIColor redColor];
    self.ui_noteLabel.numberOfLines = 0;
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    [self setNoteLayout];
//}

- (CGFloat)setNoteLayout
{
    CGSize size = [self.ui_noteLabel sizeThatFits:CGSizeMake(self.ui_noteLabel.frame.size.width,MAXFLOAT)];
    CGRect frame = [self frame];
    frame.size.height = size.height;
    self.frame = frame;
//    NSLog(@"高度:%.f",frame.size.height);
     NSLog(@"宽度===============%.f",self.ui_noteLabel.frame.size.width);
//    [self noteFrameWithHeight:frame.size.height];
    return frame.size.height;
}

- (void)noteFrameWithHeight:(CGFloat)height
{
    [_delegate testCellWithNoteHeight:height];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
