//
//  YJHeadLine.m
//  01-网易新闻-01
//
//  Created by Yip-Jun on 16/3/13.
//  Copyright © 2016年 YIPWJ. All rights reserved.
//

#import "YJHeadLine.h"
#import "YJNetworkingTool.h"

@implementation YJHeadLine

+ (instancetype)headLineWithDict:(NSDictionary *)dict {
    
    id object = [[self alloc] init];
    [object setValuesForKeysWithDictionary:dict];
    return object;
}

// 解决参数个数不对称造成的键值对错误
// 如果找不到对应的属性和字典key匹配，则系统会在该方法中跑出一场。只要重写了该方法，就会覆盖了系统默认的做法。
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

/**
 *  加载头条新闻
 *
 *  @param success 成功回调
 *  @param failed  失败回调
 */
+ (void)loadHeadLineSuccess:(void (^)(NSArray *headLine))success failed:(void (^)(NSError *error))failed {

    // 断言
    NSAssert(success != nil, @"必须输入出入完成回调");
    
    //        http://c.m.163.com/nc/ad/headline/0-4.html
    [[YJNetworkingTool sharedNetworkTool] GET:@"ad/headline/0-4.html" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        NSLog(@"%@", responseObject);
        
        NSString *rootKey = responseObject.keyEnumerator.nextObject;
        NSArray *headLine = responseObject[rootKey];
        
        NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:headLine.count];
        [headLine enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            YJHeadLine *headLine = [YJHeadLine headLineWithDict:obj];
            [mArr addObject:headLine];
        }];
        // 完成回调
        success(mArr.copy);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        if (failed) {
            failed(error.copy);
        }
    }];
}
@end
