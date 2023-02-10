//
//  DTBubbleTipsAnimation.m
//  DTBubbleTipsDemo
//
//  Created by aa on 2023/1/9.
//

#import "DTBubbleTipsAnimation.h"

@interface DTBubbleTipsAnimation ()

// Unused for now.
@property (nonatomic, strong, readonly) NSMutableArray<DTBubbleTipsAnimation *> *animations;

@end

@implementation DTBubbleTipsAnimation

- (instancetype)init {
  if (self = [super init]) {
    _animations = [NSMutableArray array];
    // Default to be linear.
    _timingFunctionControlPoint1 = CGPointMake(0, 0);
    _timingFunctionControlPoint2 = CGPointMake(1, 1);
  }
  return self;
}

- (CAAnimation *)buildAnimationForView:(UIView *)view {
  CAAnimationGroup *group = [CAAnimationGroup animation];
  NSMutableArray<CAAnimation *> *animations = [NSMutableArray array];
  for (DTBubbleTipsAnimation *model in self.animations) {
    CAAnimation *animation = [model buildAnimationForView:view];
    [animations addObject:animation];
  }
  
  return group;
}

- (CAMediaTimingFunction *)timingFunction {
  CAMediaTimingFunction *timingFunction = nil;
  if (self.timingFunctionName.length != 0) {
    timingFunction = [CAMediaTimingFunction functionWithName:self.timingFunctionName];
  } else {
    timingFunction = [CAMediaTimingFunction functionWithControlPoints
                      :self.timingFunctionControlPoint1.x
                      :self.timingFunctionControlPoint1.y
                      :self.timingFunctionControlPoint2.x
                      :self.timingFunctionControlPoint2.y];
  }
  return timingFunction;
}

@end
