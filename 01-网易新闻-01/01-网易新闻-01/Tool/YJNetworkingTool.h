//
//  YJNetworkingTool.h
//  01-网易新闻-01
//
//  Created by Yip-Jun on 16/3/13.
//  Copyright © 2016年 YIPWJ. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

// 如果我们在使用AFNetwork框架时，建议网络访问工具继承AFHTTPSessionManager
@interface YJNetworkingTool : AFHTTPSessionManager

+ (instancetype)sharedNetworkTool;

@end
