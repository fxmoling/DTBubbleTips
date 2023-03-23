//
//  UIView+DTBubbleTips.m
//  DTBubbleTipsDemo
//
//  Created by aa on 2023/3/22.
//

#import "UIView+DTBubbleTips.h"
#import <objc/runtime.h>
#import "DTBubbleTipsView.h"

// 暂时想法:
// 加一个flag，标记是否需要expand
// 加一个弱引用数组，指向所有tipsView
// 重写pointInside，把点到tipsView里的也给insede了
// 重写hitTest，以防触发view本身的事件。比如UIButton，把事件在这里拦截
// 事件dispatch到tipsView

@implementation UIView (DTBubbleTips)

+ (void)load {
  SEL pointInsideSel = @selector(pointInside:withEvent:);
  SEL pointInsideNewSel = @selector(dt_pointInside:withEvent:);
  Method pointInsideMethod = class_getInstanceMethod(self, pointInsideSel);
  Method pointInsideNewMethod = class_getInstanceMethod(self, pointInsideNewSel);
  method_exchangeImplementations(pointInsideMethod, pointInsideNewMethod);
}

- (BOOL)dt_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
  if ([self dt_pointInside:point withEvent:event] || ![self dt_expandInteractableArea]) {
    return YES;
  }
  for (DTBubbleTipsView *view in [self dt_bubbleTipsViewList]) {
    // TODO: filter flag
    if (!view || view.hidden || view.alpha < 0.01 || view.superview != self || !view.userInteractionEnabled) {
      continue;
    }
    if (CGRectContainsPoint(view.frame, point)) {
      return YES;
    }
  }
  return NO;
}

- (void)dt_setExpandInteractableArea:(BOOL)expand {
  objc_setAssociatedObject(self, @selector(dt_expandInteractableArea), @(expand), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)dt_expandInteractableArea {
  return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)dt_appendBubbleTipsView:(DTBubbleTipsView *)tipsView {
  NSPointerArray *views = [self dt_bubbleTipsViewList];
  [views addPointer:(__bridge void * _Nullable)(tipsView)];
  [self dt_clearInvalidTipsView:views];
  [self dt_updateExpandInteractableArea];
  [self dt_setBubbleTipsViewList:views];
}

- (void)dt_clearInvalidTipsView:(NSPointerArray *)views {
  [views addPointer:NULL];
  [views compact];
}

- (void)dt_updateExpandInteractableArea {
  
}

- (void)dt_setBubbleTipsViewList:(NSPointerArray *)list {
  objc_setAssociatedObject(self, @selector(dt_bubbleTipsViewList), list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSPointerArray *)dt_bubbleTipsViewList {
  return objc_getAssociatedObject(self, _cmd) ?: [NSPointerArray weakObjectsPointerArray];
}


@end
