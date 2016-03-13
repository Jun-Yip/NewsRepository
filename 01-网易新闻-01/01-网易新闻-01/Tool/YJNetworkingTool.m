//
//  YJNetworkingTool.m
//  01-网易新闻-01
//
//  Created by Yip-Jun on 16/3/13.
//  Copyright © 2016年 YIPWJ. All rights reserved.
//

#import "YJNetworkingTool.h"

@implementation YJNetworkingTool

+ (instancetype)sharedNetworkTool {
    
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
//        http://c.m.163.com/nc/ad/headline/0-4.html
        NSURL *baseURl = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        instance = [[self alloc] initWithBaseURL:baseURl];
    });
    return instance;
}

@end
