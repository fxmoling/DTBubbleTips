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
  BOOL touchedOnTipsView = NO;
  for (UIView *tipsView in self.tipsViews) {
    if (CGRectContainsPoint(tipsView.frame, point)) {
      touchedOnTipsView = YES;
      break;
    }
  }
  if (!touchedOnTipsView) {
    [self.delegate didClickOnTipsWindow:self];
  }
  return view;
}

- (void)addSubview:(UIView *)view {
  [super addSubview:view];
}

@end
