//
//  ViewController.m
//  PCHShineLabel
//
//  Created by 满脸胡茬的怪蜀黍 on 2018/5/19.
//  Copyright © 2018年 Puqin.Chen. All rights reserved.
//

#import "ViewController.h"
#import "PCHShinelabel.h"

@interface ViewController ()

@property(nonatomic, strong) PCHShinelabel *shineLabel;
@property(nonatomic, strong) NSArray *textArray;
@property(nonatomic, assign) NSUInteger textIndex;
@property(nonatomic, strong) UIImageView *backgroundImage1;
@property(nonatomic, strong) UIImageView *backgroundImage2;

@end

@implementation ViewController

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder]) {
        _textArray = @[
                       @"我们总是喜欢拿“顺其自然”来敷衍人生道路上的棘坎坷，却很少承认，真正的顺其自然，其实是竭尽所能之后的不强求，而非两手一摊的不作为。",
                       @"一别两宽，各生欢喜。我们的爱情到这儿刚刚好 ",
                       @"忧郁是因为自己无能，烦恼是由于欲望得不到满足，暴躁是一种虚怯的表现。——大仲马 《三个火枪手》"
                       ];
        _textIndex  = 0;
    }
    return self;
}

#pragma mark -- SystemMethod
- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundImage1 = ({
        UIImageView *imageView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wallpaper1"]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.frame = self.view.bounds;
        imageView;
    });
    [self.view addSubview:self.backgroundImage1];
    
    self.backgroundImage2 = ({
        UIImageView *imageView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wallpaper2"]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.frame = self.view.bounds;
        imageView.alpha = 0;
        imageView;
    });
    [self.view addSubview:self.backgroundImage2];
    
    self.shineLabel = ({
        PCHShinelabel *label = [[PCHShinelabel alloc] initWithFrame:CGRectMake(16, 16, 320 - 32, CGRectGetHeight(self.view.bounds) - 16)];
        label.numberOfLines = 0;
        label.text = [self.textArray objectAtIndex:self.textIndex];
        label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24.0];
        label.backgroundColor = [UIColor clearColor];
        [label sizeToFit];
        label.center = self.view.center;
        label;
    });
    [self.view addSubview:self.shineLabel];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.shineLabel shine];
}

#pragma mark --delegate

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    [super touchesBegan:touches withEvent:event];
    if (self.shineLabel.isVisible) {
        [self.shineLabel fadeOutWithCompletion:^{
            [self changeText];
            [UIView animateWithDuration:2.5 animations:^{
                if (self.backgroundImage1.alpha > 0.1) {
                    self.backgroundImage1.alpha = 0;
                    self.backgroundImage2.alpha = 1;
                }
                else {
                    self.backgroundImage1.alpha = 1;
                    self.backgroundImage2.alpha = 0;
                }
            }];
            [self.shineLabel shine];
        }];
    }
    else {
        [self.shineLabel shine];
    }
}

- (void)changeText {
    self.shineLabel.text = self.textArray[(++self.textIndex) % self.textArray.count];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
