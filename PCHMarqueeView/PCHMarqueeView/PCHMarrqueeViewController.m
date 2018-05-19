//
//  PCHMarrqueeViewController.m
//  PCHMarqueeView
//
//  Created by 满脸胡茬的怪蜀黍 on 2018/5/7.
//  Copyright © 2018年 Puqin.Chen. All rights reserved.
//

#import "PCHMarrqueeViewController.h"
#import "ViewController.h"

@interface PCHMarrqueeViewController ()

@property(nonatomic, strong) PCHMarqueeView *marqueeView;

@end

@implementation PCHMarrqueeViewController

#pragma mark -system Method
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view .backgroundColor = [UIColor whiteColor];
    
    UILabel * label = [[UILabel alloc] init];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:16];
    label.text = @"这个世界不断被有志向、独立思考、敢想敢干的年轻人推动着。年轻时，要选难走的路，因为那是向上的路，让明天的你和今天的你更不一样。";
    
    self.marqueeView = [[PCHMarqueeView alloc] init];
    _marqueeView.contentView = label;
    _marqueeView.pointsPerFrame = 0.5f;
    _marqueeView.frameInterVal = 60;
    _marqueeView.backgroundColor = [UIColor whiteColor];
    _marqueeView.contentMargin = 50;
    _marqueeView.style = self.style;

    
    [self.view addSubview:_marqueeView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _marqueeView.frame = CGRectMake(10, 40, self.view.bounds.size.width - 20, 60);
//    _marqueeView.center = self.view.center;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --delegate

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:[UIViewController new] completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
