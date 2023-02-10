//
//  DTBubbleTipsScaleAnimation.m
//  DTBubbleTipsDemo
//
//  Created by aa on 2023/1/9.
//

#import "DTBubbleTipsScaleAnimation.h"

@implementation DTBubbleTipsScaleAnimation

- (instancetype)init {
  if (self = [super init]) {
    _centralPoint = CGPointMake(0.5, 0.5);
  }
  return self;
}

- (CAAnimation *)buildAnimationForView:(UIView *)view {
  CAAnimationGroup *group = [CAAnimationGroup animation];
  group.duration = self.duration;
  group.timingFunction = self.timingFunction;
  
  CGFloat width = CGRectGetWidth(view.frame);
  CGFloat height = CGRectGetHeight(view.frame);
  
  CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
  scaleAnimation.fromValue = @(self.fromScale);
  scaleAnimation.toValue = @(self.toScale);
  scaleAnimation.beginTime = self.beginTime;
  scaleAnimation.removedOnCompletion = NO;
  scaleAnimation.fillMode = kCAFillModeBackwards;
  
  CGPoint position = view.layer.position;
  CGPoint offset = CGPointMake((self.centralPoint.x - 0.5) * width, (self.centralPoint.y - 0.5) * height);
  
  CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
  positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(position.x + offset.x, position.y + offset.y)];
  positionAnimation.toValue = [NSValue valueWithCGPoint:position];
  positionAnimation.beginTime = self.beginTime;
  positionAnimation.removedOnCompletion = NO;
  positionAnimation.fillMode = kCAFillModeBackwards;
  
  group.animations = @[ scaleAnimation, positionAnimation ];
  
  return group;
}

@end
