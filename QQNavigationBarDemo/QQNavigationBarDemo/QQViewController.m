//
//  QQViewController.m
//  QQNavigationBarDemo
//
//  Created by dulf on 2019/1/31.
//  Copyright © 2019 dulf. All rights reserved.
//

#import "QQViewController.h"
#import "CustomNavigationBarView.h"

@interface QQViewController () <UITableViewDataSource, UITableViewDelegate>

/* 数据源数组 **/
@property (nonatomic, copy) NSArray *dataArray;
/* backgroundImageView的初始frame **/
@property (nonatomic, assign) CGRect originFrame;
/* table **/
@property (nonatomic, strong) UITableView *tableView;
/* 导航栏view **/
@property (nonatomic, strong) CustomNavigationBarView *barView;
/* 可拉伸背景图 **/
@property (nonatomic ,strong) UIImageView *backgroundImageView;


@end

@implementation QQViewController

#define BarHeight ([UIApplication sharedApplication].statusBarFrame.size.height + 44)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArray = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",@"10", nil];
    [self createUI];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)createUI {
    _backgroundImageView = [[UIImageView alloc] init];
    _backgroundImageView.image = [UIImage imageNamed:@"background"];
    [self.view addSubview:_backgroundImageView];
    
    _barView = [[CustomNavigationBarView alloc] init];
    [self.view addSubview:_barView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];

    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 240 - BarHeight)];
    headView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = headView;
    [self.view addSubview:_tableView];
    
    //添加约束
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(240);
    }];
    
    [_barView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(BarHeight);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.barView.mas_bottom);
        if (@available (iOS 11, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }else{
            make.bottom.mas_equalTo(self.view);
        }
    }];
    
    //此处必须要先layoutIfNeeded，否则无法获取正确的frame
    [self.view layoutIfNeeded];
    _originFrame = self.backgroundImageView.frame;
    
}

#pragma mark - UITableViewDataSource UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseId = @"reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    
    //滑动过程中改变 颜色alpha ，因为改变view的alpha会改变子view的alpha
    if (offsetY < 240 - BarHeight) {
        CGFloat colorAlpha = offsetY/(240 - BarHeight);
        self.barView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:colorAlpha];
    }else {
        self.barView.backgroundColor = [UIColor whiteColor];
    }
    
    //向上滑动改变y坐标
    if (offsetY > 0) {
        CGRect rect = _originFrame;
        rect.origin.y = rect.origin.y - offsetY;
        self.backgroundImageView.frame = rect;
    }else {
        //向下滑动改变size，改变size之后会向一边倾斜，必须同时改变初始x坐标
        CGRect rect = _originFrame;
        rect.size.height = _originFrame.size.height - offsetY;
        rect.size.width = rect.size.height * self.view.frame.size.width/240;
        rect.origin.x = -(rect.size.width - _originFrame.size.width)/2;
        self.backgroundImageView.frame = rect;
    }
}



@end
