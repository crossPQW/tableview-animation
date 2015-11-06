//
//  ViewController.m
//  tableview-animation
//
//  Created by 黄少华 on 15/11/6.
//  Copyright © 2015年 黄少华. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "UIView+YYAdd.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *images;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableview];
    [self scrollViewDidScroll:self.tableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil] lastObject];
    }
    
    NSString *string = self.images[indexPath.row% 3];
    cell.image.image = [UIImage imageNamed:string];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat viewHeight = scrollView.bounds.size.height + scrollView.contentInset.top;
    for (TableViewCell *cell in [self.tableview visibleCells]) {
        CGFloat y = cell.centerY - scrollView.contentOffset.y;
        CGFloat p = y - viewHeight / 2;
        CGFloat scale = cos(p / viewHeight * 0.9) * 0.95;
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
            cell.image.transform = CGAffineTransformMakeScale(scale, scale);
        } completion:NULL];
    }
}

- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = [UIScreen mainScreen].bounds.size.width * 0.625;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}

- (NSArray *)images
{
    if (!_images) {
        _images = @[@"8f34ccfccc4394d68368ffc9cd407c1d.jpg",@"14b9c8d9c2511608f92a09cdb77802ed.jpg",@"580c7f8419ffc514ef7924b0d4ef4177.jpg"];
    }
    return _images;
}


@end
