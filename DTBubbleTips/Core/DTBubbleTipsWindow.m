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
  for (UIView *tipsView in self.tipsViews) {
    if (CGRectContainsPoint(tipsView.frame, point)) {
      return tipsView;
    }
  }
  [self.delegate didClickOnTipsWindow:self];
  return nil;
}

@end
