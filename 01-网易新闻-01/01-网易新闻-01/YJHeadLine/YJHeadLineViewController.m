//
//  YJHeadLineViewController.m
//  01-网易新闻-01
//
//  Created by Yip-Jun on 16/3/13.
//  Copyright © 2016年 YIPWJ. All rights reserved.
//

#import "YJHeadLineViewController.h"
#import "YJLoopView.h"
#import "YJHeadLine.h"

@interface YJHeadLineViewController ()

@end

@implementation YJHeadLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 首页广告
    [YJHeadLine loadHeadLineSuccess:^(NSArray *headLine) {
        
        NSLog(@"%@", headLine);
        
//        YJLoopView *loopView = [[YJLoopView alloc] initWithURLStrs:@[@"http://img3.cache.netease.com/3g/2016/3/13/20160313133235cd1fe.jpg"] titles:@[@"东北汉子冰水中采藕 防水服重30斤"]];

        YJLoopView *loopView = [[YJLoopView alloc] initWithURLStrs:[headLine valueForKey:@"imgsrc"] titles:[headLine valueForKey:@"title"]];
        
        loopView.frame = self.view.bounds;
        [self.view addSubview:loopView];
        
    } failed:^(NSError *error) {
        
    }];
}

@end
