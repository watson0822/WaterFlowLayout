//
//  WSWaterFlowLayout.m
//  WaterFlowLayout
//
//  Created by Watson on 2018/4/18.
//  Copyright © 2018年 Watson. All rights reserved.
//

#import "WSWaterFlowLayout.h"

static NSInteger const DefaultColumnCount = 3;
static CGFloat const DefaultColumnSpacing = 10;
static CGFloat const DefaultRowSpacing = 10;
static UIEdgeInsets const DefaultEdgeInsets = {10, 10, 10, 10};

@interface WSWaterFlowLayout ()
@property (nonatomic, strong) NSMutableArray *attArray;
@property (nonatomic, strong) NSMutableArray *maxYArray;

- (NSInteger)columnCount;
- (NSInteger)columnSpacing;
- (CGFloat)rowSpacing;
- (UIEdgeInsets)edgeInsets;
@end
@implementation WSWaterFlowLayout
- (NSInteger)columnCount{
    if ([self.delegate respondsToSelector:@selector(waterFlowLayoutColumnCount:)]) {
        return [self.delegate waterFlowLayoutColumnCount:self];
    }
    return DefaultColumnCount;
}

- (NSInteger)columnSpacing{
    if ([self.delegate respondsToSelector:@selector(waterFlowLayoutColumnSpacing:)]) {
        return [self.delegate waterFlowLayoutColumnSpacing:self];
    }
    return DefaultColumnSpacing;
}

- (CGFloat)rowSpacing{
    if ([self.delegate respondsToSelector:@selector(waterFlowLayoutRowSpacing:)]) {
        return [self.delegate waterFlowLayoutRowSpacing:self];
    }
    return DefaultRowSpacing;
}

- (UIEdgeInsets)edgeInsets{
    if ([self.delegate respondsToSelector:@selector(waterFlowLayoutEdgeInsets:)]) {
        return [self.delegate waterFlowLayoutEdgeInsets:self];
    }
    return DefaultEdgeInsets;
}
- (NSMutableArray *)attArray{
    if (!_attArray) {
        _attArray = [NSMutableArray new];
    }
    return _attArray;
}

- (NSMutableArray *)maxYArray{
    if (!_maxYArray) {
        _maxYArray = [NSMutableArray new];
    }
    return _maxYArray;
}
//调用方法
- (void)prepareLayout{
    [super prepareLayout];
    
    [self.attArray removeAllObjects];
    [self.maxYArray removeAllObjects];
    for (NSInteger i = 0; i < [self columnCount]; i++) {
        [self.maxYArray addObject:@([self edgeInsets].top)];
        
    }
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        [self.attArray addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
}
//元素个数
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attArray;
}
//布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSInteger __block minHeightColumn = 0;
    NSInteger __block minHeight = [self.maxYArray[minHeightColumn] floatValue];
    [self.maxYArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat columnHeight = [(NSNumber *)obj floatValue];
        if (minHeight > columnHeight) {
            minHeight = columnHeight;
            minHeightColumn = idx;
        }
    }];
    
    UIEdgeInsets edgeInsets = [self edgeInsets];
    CGFloat width = (CGRectGetWidth(self.collectionView.frame) - edgeInsets.left - edgeInsets.right - [self columnSpacing] * ([self columnCount] - 1)) / [self columnCount];
    CGFloat height = [self.delegate waterFlowLayout:self heightForItemAtIndex:indexPath.item itemWidth:width];
    CGFloat originX = edgeInsets.left + minHeightColumn * (width + [self columnSpacing]);
    CGFloat originY = minHeight + [self rowSpacing];
    if (originY != edgeInsets.top) {
        originY += [self columnSpacing];
    }
    
    [attributes setFrame:CGRectMake(originX, originY, width, height)];
    self.maxYArray[minHeightColumn] = @(CGRectGetMaxY(attributes.frame));
    return attributes;
}
//可视范围
- (CGSize)collectionViewContentSize{
    NSInteger __block maxHeight = 0;
    
    [self.maxYArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat columnHeight = [(NSNumber *)obj floatValue];
        if (maxHeight < columnHeight) {
            maxHeight = columnHeight;
        }
    }];
    return CGSizeMake(0, maxHeight + [self edgeInsets].bottom);
}

@end
