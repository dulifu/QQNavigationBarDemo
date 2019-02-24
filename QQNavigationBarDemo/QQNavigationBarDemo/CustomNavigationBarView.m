//
//  CustomNavigationBarView.m
//  QQNavigationBarDemo
//
//  Created by dulf on 2019/2/1.
//  Copyright © 2019 dulf. All rights reserved.
//

#import "CustomNavigationBarView.h"

@implementation CustomNavigationBarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftBtn setBackgroundColor:[UIColor redColor]];
    [self addSubview:_leftBtn];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.text = @"可渐变导航栏";
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.bottom.mas_equalTo(-12);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(-12);
        
    }];
}

@end
