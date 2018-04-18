//
//  WSWaterFlowLayout.h
//  WaterFlowLayout
//
//  Created by Watson on 2018/4/18.
//  Copyright © 2018年 Watson. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSWaterFlowLayout;
@protocol WSWaterFlowLayoutDelegate <NSObject>

@required
- (CGFloat)waterFlowLayout:(WSWaterFlowLayout *)layout heightForItemAtIndex:(NSInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (NSInteger)waterFlowLayoutColumnCount:(WSWaterFlowLayout *)layout;
- (CGFloat)waterFlowLayoutColumnSpacing:(WSWaterFlowLayout *)layout;
- (CGFloat)waterFlowLayoutRowSpacing:(WSWaterFlowLayout *)layout;
- (UIEdgeInsets)waterFlowLayoutEdgeInsets:(WSWaterFlowLayout *)layout;

@end

@interface WSWaterFlowLayout : UICollectionViewLayout

@property (nonatomic, weak) id<WSWaterFlowLayoutDelegate> delegate;

@end
