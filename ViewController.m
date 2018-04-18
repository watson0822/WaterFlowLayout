//
//  ViewController.m
//  WaterFlowLayout
//
//  Created by Watson on 2018/4/18.
//  Copyright © 2018年 Watson. All rights reserved.
//

#import "ViewController.h"
#import "WSWaterFlowLayout.h"
@interface ViewController ()<UICollectionViewDataSource, WSWaterFlowLayoutDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    WSWaterFlowLayout *flow = [WSWaterFlowLayout new];
    flow.delegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flow];
    collectionView.dataSource = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:collectionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - collection View Data Source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    NSInteger tag = 100;
    UILabel *label = [cell.contentView viewWithTag:tag];
    if (!label) {
        label = [UILabel new];
        label.tag = tag;
        [cell.contentView addSubview:label];
    }
    label.text = [NSString stringWithFormat:@"%zd", indexPath.item];
    [label sizeToFit];
    return cell;
}

#pragma mark - waterFlowLayoutDelegate

- (CGFloat)waterFlowLayout:(WSWaterFlowLayout *)layout heightForItemAtIndex:(NSInteger)index itemWidth:(CGFloat)itemWidth{
    return 100 + arc4random_uniform(150);
}

- (NSInteger)WaterFlowLayoutColumnCount:(WSWaterFlowLayout *)layout{
    return 3;
}

- (CGFloat)waterFlowLayoutColumnSpacing:(WSWaterFlowLayout *)layout{
    return 5;
}

- (CGFloat)waterFlowLayoutRowSpacing:(WSWaterFlowLayout *)layout{
    return 15;
}

//- (UIEdgeInsets)waterFlowLayoutEdgeInsets:(WaterFlowLayout *)layout{
//    return UIEdgeInsetsMake(5, 5, 5, 5);
//}

@end
