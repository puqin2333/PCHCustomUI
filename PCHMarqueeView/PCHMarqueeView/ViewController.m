//
//  ViewController.m
//  PCHMarqueeView
//
//  Created by 满脸胡茬的怪蜀黍 on 2018/5/4.
//  Copyright © 2018年 Puqin.Chen. All rights reserved.
//

#import "ViewController.h"
#import "PCHMarrqueeViewController.h"
#import "PCHMArrqueeImageController.h"

// 屏幕宽
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
// 屏幕高
#define kScreenHeigth ([UIScreen mainScreen].bounds.size.height)
// RGB颜色 r->red, g->green, b->blue, a->alpha
#define kCustomColorWithRGB(r, g, b, a) [UIColor colorWithRed:r green:g blue:b alpha:a]


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView * functionTableView;
@property(nonatomic, strong) NSArray *functionNameArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _functionNameArray = @[@"向左滚动", @"向右滚动", @"反转", @"图片", @"自定义"];
    
    [self setUpSubView];
    
}


#pragma mark - custom Method

- (UITableView *)functionTableView {
    if (_functionTableView == nil) {
        UITableView *functionTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth * 0.1, kScreenHeigth * 0.2, kScreenWidth * 0.8, kScreenHeigth * 0.6) style:UITableViewStylePlain];
        functionTableView.backgroundColor = kCustomColorWithRGB(0.23f, 0.26f, 0.39f, 1.00f);
        functionTableView.delegate = self;
        functionTableView.dataSource = self;
        functionTableView.scrollEnabled = NO;
        functionTableView.rowHeight = kScreenHeigth * 0.12;
        self.functionTableView = functionTableView;
        [self.view addSubview:self.functionTableView];
        
    }
    return _functionTableView;
}

- (void)setUpSubView {
    [self functionTableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _functionNameArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *functionCell = [[UITableViewCell alloc] init];
    functionCell.backgroundColor = kCustomColorWithRGB(0.23f, 0.26f, 0.39f, 1.00f);
    functionCell.textLabel.text = _functionNameArray[indexPath.row];
    functionCell.textLabel.textAlignment = NSTextAlignmentCenter;
    functionCell.selectionStyle = UITextAutocapitalizationTypeNone;
    functionCell.textLabel.textColor = kCustomColorWithRGB(1, 1, 1, 1);
    return functionCell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            PCHMarrqueeViewController *leftVC = [[PCHMarrqueeViewController alloc] init];
            leftVC.style = 0;
            [self presentViewController:leftVC animated:NO completion:nil];
            
        }
            break;
            
        case 1:{
            PCHMarrqueeViewController *rightVC = [[PCHMarrqueeViewController alloc] init];
            rightVC.style = 1;
            [self presentViewController:rightVC animated:NO completion:nil];
            
        }
            break;
            
        case 2:{
            PCHMarrqueeViewController *reserveVC = [[PCHMarrqueeViewController alloc] init];
            reserveVC.style = 2;
            [self presentViewController:reserveVC animated:NO completion:nil];
            
        }
            break;
        case 3:{
            PCHMArrqueeImageController *imageVC = [[PCHMArrqueeImageController alloc] init];
            imageVC.style = 2;
            [self presentViewController:imageVC animated:NO completion:nil];
            
        }
            break;
        default:
            break;
    }
    
}


#pragma mark - System Method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
