//
//  ZSCircleLayout.m
//  线性布局
//
//  Created by 陈昭燊 on 16/3/2.
//  Copyright © 2016年 陈昭燊. All rights reserved.
//

#import "ZSCircleLayout.h"

@implementation ZSCircleLayout

/// 返回最终布局数组
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < count; i++) {
        
        // 创建i位置cell对应的IndexPath
        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
        
        // 创建i位置cell对应的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:index];
        
        //添加布局属性
        [mArray addObject:attrs];
    }
    return mArray.copy;
    
}

/// 返回每个item的布局
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //获取item数量
    NSInteger count = [self.collectionView numberOfItemsInSection:indexPath.section];
    
    
    // 半径
    CGFloat radius = 100;
    // 圆心坐标
    CGFloat centerX = self.collectionView.frame.size.width * 0.5;
    CGFloat centerY = self.collectionView.frame.size.height * 0.5;
    // 角度增量
    CGFloat deltaAngle = 2 * M_PI / count;
    
    // 创建i位置cell对应的布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.size = CGSizeMake(50, 50);

    if (count == 1) {
        attrs.center = CGPointMake(centerX, centerY);
    } else {
        // 旋转角度
        CGFloat angle = indexPath.item * deltaAngle;
        // cell中心点坐标
        CGFloat attrsCenterX = centerX + radius * cos(angle);
        CGFloat attrsCenterY = centerY + radius * sin(angle);
        
        attrs.center = CGPointMake(attrsCenterX, attrsCenterY);
        
        //    // 用来控制cell的层叠顺序，zIndex越大，cell越在上面
        //    attrs.zIndex = 100;
    }

    return attrs;
    
}

@end
