//
//  HeaderView.m
//  layoutDemo
//
//  Created by rp.wang on 16/9/28.
//  Copyright © 2016年 rp.wang. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
       
    
    }
    return self;
}

-(instancetype)initWithHeaderView:(CGPoint)origin andHeight:(CGFloat)height
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self = [self initWithFrame:CGRectMake(origin.x, origin.y, screenSize.width, height)];

    
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];

    
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    self.HeaderBtnListView  = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, height) collectionViewLayout:flowLayout];
    self.HeaderBtnListView.scrollEnabled = NO;
    
    self.HeaderBtnListView.backgroundColor = [UIColor clearColor];
    [self.HeaderBtnListView  registerClass:[BtnListCollCell class] forCellWithReuseIdentifier:HeaderViewBtnCellID];
    
    [self addSubview:self.HeaderBtnListView];
    
    
    self.HeaderBtnListView.delegate = self;
    self.HeaderBtnListView.dataSource = self;
    
    return self;
}


//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.BtnList.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BtnListCollCell *collcell = (BtnListCollCell *)[collectionView dequeueReusableCellWithReuseIdentifier:HeaderViewBtnCellID forIndexPath:indexPath];
    if (!collcell) {
        
        collcell = [[BtnListCollCell alloc] init];
        
        
        
    }
    collcell.backgroundColor = [UIColor whiteColor];
    
    
    [collcell CollreloadDataWithBtn:[self.BtnList objectAtIndex:indexPath.row]];
    
    return collcell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat screenWith = self.frame.size.width / [self.BtnList count] - 1;
    return CGSizeMake(screenWith, 45);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    [self.ClickHeaderBtnDelegate ClickHeaderBtn:indexPath.row];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = {0.1f,0.1f};
    return size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.1f;
}
@end
