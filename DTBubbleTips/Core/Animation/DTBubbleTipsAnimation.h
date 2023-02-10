//
//  DTBubbleTipsAnimation.h
//  DTBubbleTipsDemo
//
//  Created by aa on 2023/1/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DTBubbleTipsAnimation : NSObject

@property (nonatomic, assign) CFTimeInterval duration;

@property (nonatomic, assign) CFTimeInterval beginTime;

@property (nonatomic, strong, nullable) CAMediaTimingFunctionName timingFunctionName;

// Default to be (0, 0)
@property (nonatomic, assign) CGPoint timingFunctionControlPoint1;
// Default to be (1, 1)
@property (nonatomic, assign) CGPoint timingFunctionControlPoint2;

//@property (nonatomic, strong) void(^animationCompletion)(UIView *animatedView, BOOL finished);

- (CAMediaTimingFunction *)timingFunction;
- (CAAnimation *)buildAnimationForView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
