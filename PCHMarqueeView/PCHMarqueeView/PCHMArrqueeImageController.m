//
//  PCHMArrqueeImageController.m
//  PCHMarqueeView
//
//  Created by 满脸胡茬的怪蜀黍 on 2018/5/16.
//  Copyright © 2018年 Puqin.Chen. All rights reserved.
//

#import "PCHMArrqueeImageController.h"



@interface PCHMArrqueeImageController ()

@property(nonatomic, strong) PCHMarqueeView *marqueeView;

@end

@implementation PCHMArrqueeImageController

#pragma mark -system Method

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view .backgroundColor = [UIColor whiteColor];
    
    
    UIImageView *marrqueeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"what_i_am.jpg"]];
    marrqueeImageView.contentMode = UIViewContentModeScaleToFill;
    
    self.marqueeView = [[PCHMarqueeView alloc] init];
    _marqueeView.contentView = marrqueeImageView;
    _marqueeView.pointsPerFrame = 0.5f;
    _marqueeView.frameInterVal = 60;
    _marqueeView.backgroundColor = [UIColor whiteColor];
    _marqueeView.contentMargin = 10;
    _marqueeView.style = self.style;
    
    [self.view addSubview:_marqueeView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _marqueeView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 180);
    _marqueeView.center = self.view.center;
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
