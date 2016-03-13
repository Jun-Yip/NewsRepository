//
//  YJLoopView.m
//  01-网易新闻-01
//
//  Created by Yip-Jun on 16/3/13.
//  Copyright © 2016年 YIPWJ. All rights reserved.
//

#import "YJLoopView.h"
#import "YJHeadLine.h"
#import "YJLoopViewFlowLayout.h"
#import "YJLoopViewCell.h"
#import "HMWeakTimerTarget.h"

@interface YJLoopView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSArray *URLStrs;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation YJLoopView

- (instancetype)initWithURLStrs:(NSArray <NSString *> *)URLStrs titles:(NSArray <NSString *> *)titles {
    
    if (self = [super init]) {
        
        self.URLStrs = URLStrs;
        self.titles = titles;
        
        self.titleLable.text = self.titles[0];
        self.pageControl.numberOfPages = self.URLStrs.count;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [self starTimer];
        });
    }
    return self;
}

- (void)starTimer {
    
    self.timer = [HMWeakTimerTarget scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextImg) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)nextImg {
    
    NSInteger index = self.collectionView.contentOffset.x / self.collectionView.frame.size.width;
    
    CGFloat offset = (index + 1) * self.collectionView.frame.size.width;
    
    [self.collectionView setContentOffset:CGPointMake(offset, 0) animated:YES];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[YJLoopViewFlowLayout alloc] init]];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[YJLoopViewCell class] forCellWithReuseIdentifier:@"loopCell"];
    [self addSubview:self.collectionView];
    
    self.titleLable = [[UILabel alloc] init];
    self.titleLable.font = [UIFont systemFontOfSize:14];
    self.titleLable.textColor = [UIColor blackColor];
    [self addSubview:self.titleLable];
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.hidesForSinglePage = YES;
    [self addSubview:self.pageControl];
}

- (void)layoutSubviews {
    
    CGFloat margin = 10;
    CGFloat titleH = 40;
    
    // 设置collectionView的frame
    CGRect frame = self.bounds;
    frame.size.height -= titleH;
    self.collectionView.frame = frame;
    NSLog(@"%@", NSStringFromCGSize(self.collectionView.frame.size));
    
    // 设置pageControl的frame
    CGFloat pageW = self.URLStrs.count * 15;
    CGFloat pageH = titleH;
    CGFloat pageX = self.bounds.size.width - pageW - margin;
    CGFloat pageY = CGRectGetMaxY(self.collectionView.frame);
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    
    // 设置titleLable的frame
    CGFloat titleW = self.bounds.size.width - pageW - margin * 3;
    CGFloat titleX = margin;
    CGFloat titleY = pageY;
    self.titleLable.frame = CGRectMake(titleX, titleY, titleW, titleH);
}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.URLStrs.count * (self.URLStrs.count == 1 ? 1 : 3);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YJLoopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"loopCell" forIndexPath:indexPath];
    cell.URLStr = self.URLStrs[indexPath.item % self.URLStrs.count];
    return cell;
}

#pragma mark - 代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 获取当前偏移值
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    // 判断当前位置
    if (index == 0 || index == ([self.collectionView numberOfItemsInSection:0] - 1)) {
        
//        index = (index % self.URLStrs.count) + self.URLStrs.count;
        index = self.URLStrs.count - (index == 0 ? 0 : 1);
        [self.collectionView setContentOffset:CGPointMake(index * self.collectionView.frame.size.width, 0)];
    }
    
    self.titleLable.text = self.titles[index % self.URLStrs.count];
    self.pageControl.currentPage = index % self.URLStrs.count;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    [self starTimer];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndDecelerating:scrollView];
}

@end
