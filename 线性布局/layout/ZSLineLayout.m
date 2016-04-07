//
//  ZSLineLayout.m
//  线性布局
//
//  Created by 陈昭燊 on 16/3/2.
//  Copyright © 2016年 陈昭燊. All rights reserved.
//

#import "ZSLineLayout.h"

@implementation ZSLineLayout

-(instancetype)init{
    self = [super init];
    return self;
}

/// 准备布局
-(void)prepareLayout{
    [super prepareLayout];
    
    //滚动方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置cell的尺寸
    CGFloat itemWH = self.collectionView.frame.size.height * 0.6;
    self.itemSize = CGSizeMake(itemWH, itemWH);
    
    // 设置内边距
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    
    //组合组之间最小间距
    self.minimumLineSpacing = 50;
}

/// 返回item最终布局数组
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *mArray = [NSMutableArray new];
    
    // 获得CollectionView中点的x值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 在默认布局属性的基础上进行微调
    for (UICollectionViewLayoutAttributes *attrs in array) {
        UICollectionViewLayoutAttributes *mAttrs = attrs.copy;
        // 计算cell中点x值到CollectionView中点x值的距离
        CGFloat delta = ABS(attrs.center.x - centerX);
        
        // 根据距离计算缩放比例（成反比）
        CGFloat scale = 1 - delta / (self.collectionView.frame.size.width + self.itemSize.width);
        mAttrs.transform = CGAffineTransformMakeScale(scale, scale);
        [mArray addObject:mAttrs];
    }
    
    
    return mArray.copy;
}

/**
 *  当CollectionView的bounds发生改变的时候是否刷新布局
 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}


/// 滑动最终定位
///  targetContentOffset：CollectionView最终的偏移量
///  proposedContentOffset：CollectionView预期的偏移量
///

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    // 计算最终的可见范围
    CGRect rect;
    rect.origin = proposedContentOffset;
    rect.size = self.collectionView.frame.size;
    
    // 取得cell的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 计算CollectionView中线的x值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        CGFloat delta = attrs.center.x - centerX;
        
        if (ABS(delta) <= ABS(minDelta)) {
            minDelta = delta;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + minDelta, proposedContentOffset.y);
}

@end
