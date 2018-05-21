//
//  PCHShinelabel.m
//  PCHShineLabel
//
//  Created by 满脸胡茬的怪蜀黍 on 2018/5/20.
//  Copyright © 2018年 Puqin.Chen. All rights reserved.
//

#import "PCHShinelabel.h"

@interface PCHShinelabel()

@property(strong, nonatomic) NSMutableAttributedString *attributedString;
@property(nonatomic, strong) NSMutableArray *characterAnimationDurations;
@property(nonatomic, strong) NSMutableArray *characterAnimationDelays;
@property(strong, nonatomic) CADisplayLink *displaylink;
@property(assign, nonatomic) CFTimeInterval beginTime; // 动画开始时间
@property(assign, nonatomic) CFTimeInterval endTime; // 结束～～
@property(assign, nonatomic, getter = isFadeOut) BOOL fadeOut;
@property(nonatomic, copy) void (^completion)(void);

@end

@implementation PCHShinelabel

#pragma mark --InitMethod
- (instancetype)init {
    if ( !(self = [super init])) {
        return nil;
    }
    [self commonInit];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ( !(self = [super initWithFrame:frame] )) {
        return nil;
    }
    [self commonInit];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (!(self  = [super initWithCoder:aDecoder])) {
        return nil;
    }
    [self commonInit];
    return self;
}
- (void)commonInit {
    // Default
    _shineDuration = 2.5;
    _fadeOutDuration = 2.5;
    _autoStart = NO;
    _fadeOut = YES;
    self.textColor = [UIColor whiteColor];
    
    _characterAnimationDurations = [NSMutableArray array];
    _characterAnimationDelays = [NSMutableArray array];
    
    self.displaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateAttributeString)];
    _displaylink.paused = YES;
    [_displaylink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)didMoveToWindow {
    if (nil != self.window && self.autoStart) {
        [self shine];
    }
}

- (void)setText:(NSString *)text {
    self.attributedText = [[NSAttributedString alloc] initWithString:text];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    NSMutableAttributedString *mutableAttributeString = [attributedText mutableCopy];
    UIColor *color = [self.textColor colorWithAlphaComponent:0]; // 返回与指定的alpha组件相同颜色空间中的颜色。
    
    // 添加文字背景颜色
    [mutableAttributeString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, mutableAttributeString.length)];
    self.attributedString = mutableAttributeString;
    [super setAttributedText:self.attributedString];
    for (NSUInteger i = 0; i < attributedText.length; i++) {
        self.characterAnimationDelays[i]= @(arc4random_uniform(self.shineDuration / 2 * 100) / 100.0);
        CGFloat remain = self.shineDuration - [self.characterAnimationDelays[i] floatValue];
        self.characterAnimationDurations[i] = @(arc4random_uniform(remain * 100) / 100.0);
    }
}

#pragma mark --PublicMethod

- (void)shine {
    [self shineWithCompletion:NULL];
}

- (void)shineWithCompletion:(void (^)(void))completion {
    if (!self.isFinished && self.isFadeOut) {
        self.completion = completion;
        self.fadeOut = NO;
        [self startAnimationWithDuration:self.shineDuration];
    }
}

- (void)fadeOut {
    [self fadeOutWithCompletion:NULL];
}

- (void)fadeOutWithCompletion:(void (^)(void))completion {
    if (!self.isFadeOut && self.isFinished) {
        self.completion = completion;
        self.fadeOut = YES;
        [self startAnimationWithDuration:self.fadeOutDuration];
    }
}

- (BOOL)isFinished {
    return !self.displaylink.isPaused;
}

- (BOOL)isVisible {
    return NO == self.isFadeOut;
}

#pragma mark --PrivateMethod

- (void)updateAttributeString {
    CFTimeInterval now = CACurrentMediaTime();
    for (NSUInteger i = 0; i < self.attributedString.length; i++) {
        // NSCharactSet 是用来表示一组Unicode字符
        if ([[NSCharacterSet whitespaceAndNewlineCharacterSet] characterIsMember:[self.attributedString.string characterAtIndex:i]]) {
            continue;
        }
        [self.attributedString enumerateAttribute:NSForegroundColorAttributeName inRange:NSMakeRange(i, 1) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
            CGFloat currentAlpha = CGColorGetAlpha([(UIColor *)value CGColor]);
            BOOL shouldUpdateAlpha = (self.isFadeOut && currentAlpha > 0) || (!self.isFadeOut && currentAlpha < 1) || (now - self.beginTime) >= [self.characterAnimationDelays[i] floatValue];
            if (!shouldUpdateAlpha) {
                return;
            }
            CGFloat percentage = (now - self.beginTime - [self.characterAnimationDelays[i] floatValue]) / [self.characterAnimationDurations[i] floatValue];
            if (self.isFadeOut) {
                percentage = 1 - percentage;
            }
            UIColor *color = [self.textColor colorWithAlphaComponent:percentage];
            [self.attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
        }];
        [super setAttributedText:self.attributedString];
        if (now > self.endTime) {
            self.displaylink.paused = YES;
            if (self.completion) {
                self.completion();
            }
        }
    }
}

- (void)startAnimationWithDuration:(CFTimeInterval)duration {
    self.beginTime = CACurrentMediaTime();
    self.endTime = self.beginTime + self.shineDuration;
    self.displaylink.paused = NO;
}

@end
