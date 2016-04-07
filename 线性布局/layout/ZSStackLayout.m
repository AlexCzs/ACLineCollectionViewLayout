//
//  ZSStackLayout.m
//  线性布局
//
//  Created by 陈昭燊 on 16/3/2.
//  Copyright © 2016年 陈昭燊. All rights reserved.
//

#import "ZSStackLayout.h"

@implementation ZSStackLayout
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSUInteger count = [self.collectionView numberOfItemsInSection:indexPath.section];
    
    attrs.center = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5);
    attrs.size = CGSizeMake(100, 100);
    attrs.zIndex = count - indexPath.item;
    
    if (count >= 5) {
        count = 5;
    }
    if (indexPath.item >= count) {
        attrs.hidden = YES;
        return attrs;
    }
    CGFloat deltaAngle = M_PI_2 / count;
    CGFloat angle = indexPath.item * deltaAngle;
    attrs.transform = CGAffineTransformMakeRotation(angle);
    
    return attrs;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *array = [NSMutableArray array];
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [array addObject:attrs];
    }
    
    return array;
}
@end
