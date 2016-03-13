//
//  YJLoopViewCell.m
//  01-网易新闻-01
//
//  Created by Yip-Jun on 16/3/14.
//  Copyright © 2016年 YIPWJ. All rights reserved.
//

#import "YJLoopViewCell.h"
#import <UIImageView+WebCache.h>

@interface YJLoopViewCell ()

@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation YJLoopViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.iconView = [[UIImageView alloc] init];
        [self addSubview:self.iconView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconView.frame = self.bounds;
}

- (void)setURLStr:(NSString *)URLStr {
    
    _URLStr = URLStr;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:URLStr]];
}

@end
