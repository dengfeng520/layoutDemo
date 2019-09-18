//
//  XHTestCell.h
//  testApp
//
//  Created by ColdMountain on 2017/3/8.
//  Copyright © 2017年 ColdMountain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@protocol XHTestCellDelegate <NSObject>

- (void)testCellWithNoteHeight:(CGFloat)noteHeight;

@end

static NSString * const XHTestCellIdentifier = @"XHTestCellIdentifier";

@interface XHTestCell : UITableViewCell
@property (assign, nonatomic) id<XHTestCellDelegate>delegate;
@property (strong, nonatomic) UILabel *ui_noteLabel;
@property (weak, nonatomic) IBOutlet UIView *ui_bgView;
@property (weak, nonatomic) IBOutlet UILabel *TopLab;
@property (weak, nonatomic) IBOutlet UILabel *LeftLab;
@property (weak, nonatomic) IBOutlet UILabel *BomLab;
- (CGFloat)setNoteLayout;
@end
