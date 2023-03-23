//
//  DTBubbleTipsWindow.m
//  DTBubbleTipsDemo
//
//  Created by aa on 2022/10/25.
//

#import "DTBubbleTipsWindow.h"

@implementation DTBubbleTipsWindow

- (NSArray<DTBubbleTipsView *> *)tipsViews {
  NSMutableArray *views = [NSMutableArray array];
  for (UIView *tipsView in self.subviews) {
    if ([tipsView isKindOfClass:DTBubbleTipsView.class]) {
      [views addObject:tipsView];
    }
  }
  return views;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  UIView *view = [super hitTest:point withEvent:event];
  for (UIView *tipsView in self.tipsViews) {
    if (CGRectContainsPoint(tipsView.frame, point)) {
      return view;
    }
  }
  [self.delegate didClickOnTipsWindow:self];
  // Do not intercept the gesture.
  return nil;
}

- (void)addSubview:(UIView *)view {
  [super addSubview:view];
}

@end
