//
//  UIView+DTBubbleTips.m
//  DTBubbleTipsDemo
//
//  Created by aa on 2023/3/22.
//

#import "UIView+DTBubbleTips.h"
#import <objc/runtime.h>
#import "DTBubbleTipsView.h"
#import "DTBubbleTipsConfig.h"

@implementation UIView (DTBubbleTips)

+ (void)load {
  [self dt_swizzleSel1:@selector(pointInside:withEvent:) sel2:@selector(dt_pointInside:withEvent:)];
}

+ (void)dt_swizzleSel1:(SEL)sel1 sel2:(SEL)sel2 {
  Method method1 = class_getInstanceMethod(self, sel1);
  Method method2 = class_getInstanceMethod(self, sel2);
  method_exchangeImplementations(method1, method2);
}

#pragma mark - Public

- (void)dt_appendBubbleTipsView:(DTBubbleTipsView *)tipsView {
  NSPointerArray *views = [self dt_bubbleTipsViewList];
  [views addPointer:(__bridge void * _Nullable)(tipsView)];
  [self dt_clearInvalidTipsView:views];
  [self dt_setBubbleTipsViewList:views];
}

- (void)dt_removeBubbleTipsView:(DTBubbleTipsView *)tipsView {
  NSPointerArray *views = [self dt_bubbleTipsViewList];
  for (NSInteger i = 0; i < views.count; i++) {
    if ((DTBubbleTipsView *)[views pointerAtIndex:i] == tipsView) {
      [views removePointerAtIndex:i];
      break;
    }
  }
}

#pragma mark - Private

- (BOOL)dt_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
  if ([self dt_pointInside:point withEvent:event]) {
    return YES;
  }
  if (event.allTouches.count > 1) {
    return NO;
  }
  for (DTBubbleTipsView *view in [self dt_bubbleTipsViewList]) {
    if (!view || view.hidden || view.alpha <= 0.01 || view.superview != self
        || !view.userInteractionEnabled || !view.config.clickableWhenOverflowFromSuperview) {
      continue;
    }
    if (CGRectContainsPoint(view.frame, point)) {
      // Fail the gestures in the hostView. Tapping on the overflowed tipsView should only trigger itself's
      // touch event.
      for (UIGestureRecognizer *ges in self.gestureRecognizers) {
        [ges setState:UIGestureRecognizerStateFailed];
      }
      return YES;
    }
  }
  return NO;
}

- (void)dt_clearInvalidTipsView:(NSPointerArray *)views {
  for (NSInteger i = views.count - 1; i >= 0; i--) {
    UIView *view = [views pointerAtIndex:i];
    if (!view || view.superview != self) {
      [views removePointerAtIndex:i];
    }
  }
}

- (void)dt_setBubbleTipsViewList:(NSPointerArray *)list {
  objc_setAssociatedObject(self, @selector(dt_bubbleTipsViewList), list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSPointerArray *)dt_bubbleTipsViewList {
  return objc_getAssociatedObject(self, _cmd) ?: [NSPointerArray weakObjectsPointerArray];
}

@end
