//
//  YJHeadLine.h
//  01-网易新闻-01
//
//  Created by Yip-Jun on 16/3/13.
//  Copyright © 2016年 YIPWJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJHeadLine : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imgsrc;

+ (instancetype)headLineWithDict:(NSDictionary *)dict;

+ (void)loadHeadLineSuccess:(void (^)(NSArray *headLine))success failed:(void (^)(NSError *error))failed;

@end
