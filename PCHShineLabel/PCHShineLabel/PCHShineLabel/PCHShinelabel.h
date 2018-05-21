//
//  PCHShinelabel.h
//  PCHShineLabel
//
//  Created by 满脸胡茬的怪蜀黍 on 2018/5/20.
//  Copyright © 2018年 Puqin.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCHShinelabel : UILabel

 // 淡入文本持续时间 ，默认为 2.5
@property(nonatomic, assign) CFTimeInterval shineDuration;
// 淡出时间， 默认为 2.5
@property(nonatomic, assign) CFTimeInterval fadeOutDuration;
// 是否自动开始动画，默认为 NO
@property(nonatomic, assign, getter = isAutoStart) BOOL autoStart;
// 检查动画是否完成
@property(nonatomic, assign, readonly, getter = isFinished) BOOL finished;
// 是否是显示的
@property(nonatomic, assign, readonly, getter = isVisible) BOOL visible;

// 淡入动画
- (void)shine;
- (void)shineWithCompletion:(void (^)(void))completion;

// 淡出动画
- (void)fadeOut;
- (void)fadeOutWithCompletion:(void(^)(void))completion;

@end
