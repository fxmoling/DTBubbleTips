//
//  DTBubbleTipsAlphaAnimation.m
//  DTBubbleTipsDemo
//
//  Created by aa on 2023/2/9.
//

#import "DTBubbleTipsAlphaAnimation.h"

@implementation DTBubbleTipsAlphaAnimation

- (CAAnimation *)buildAnimationForView:(UIView *)view {
  CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
  alphaAnimation.fromValue = @(self.fromAlpha);
  alphaAnimation.toValue = @(self.toAlpha);
  alphaAnimation.duration = self.duration;
  alphaAnimation.timingFunction = self.timingFunction;
  alphaAnimation.beginTime = self.beginTime;
  alphaAnimation.removedOnCompletion = NO;
  alphaAnimation.fillMode = kCAFillModeBackwards;
  return alphaAnimation;
}

@end
