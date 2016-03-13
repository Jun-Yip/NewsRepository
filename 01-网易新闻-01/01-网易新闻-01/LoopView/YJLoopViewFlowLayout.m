//
//  YJLoopViewFlowLayout.m
//  01-网易新闻-01
//
//  Created by Yip-Jun on 16/3/13.
//  Copyright © 2016年 YIPWJ. All rights reserved.
//

#import "YJLoopViewFlowLayout.h"

@implementation YJLoopViewFlowLayout

// 在调用该方法前，collectionView尺寸已经确定
- (void)prepareLayout {
    [super prepareLayout];
    
    self.itemSize = self.collectionView.bounds.size;
    // 设置间距
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

@end
