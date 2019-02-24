//
//  ViewController.m
//  QQNavigationBarDemo
//
//  Created by dulf on 2019/1/31.
//  Copyright © 2019 dulf. All rights reserved.
//

#import "ViewController.h"
#import "QQViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pushButton setTitle:@"跳转" forState:UIControlStateNormal];
    [pushButton addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [pushButton setBackgroundColor:[UIColor redColor]];
    pushButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:pushButton];
    
    [pushButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
}

- (void)push {
    QQViewController *ctr = [[QQViewController alloc] init];
    [self.navigationController pushViewController:ctr animated:YES];
}


@end
