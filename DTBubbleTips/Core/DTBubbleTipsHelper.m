//
//  DTBubbleTipsHelper.m
//  DTBubbleTipsDemo
//
//  Created by aa on 2022/6/27.
//

#import "DTBubbleTipsHelper.h"
#import "DTBubbleTipsView.h"
#import "DTBubbleTipsWindow.h"
#import "DTBubbleTipsAnimation.h"

@interface DTBubbleTipsHelper() <DTBubbleTipsViewDelegate, DTBubbleTipsWindowDelegate>

@property (nonatomic, strong, class, readonly) DTBubbleTipsWindow *window;

// Used to play a delegate role.
@property (nonatomic, strong, class, readonly) DTBubbleTipsHelper *eventHandler;

@end

@implementation DTBubbleTipsHelper

+ (instancetype)eventHandler {
  static dispatch_once_t tok;
  static DTBubbleTipsHelper *instance;
  dispatch_once(&tok, ^{
    instance = [[DTBubbleTipsHelper alloc] init];
  });
  return instance;
}

+ (DTBubbleTipsWindow *)window {
  static dispatch_once_t tok;
  static DTBubbleTipsWindow *window;
  dispatch_once(&tok, ^{
    window = [self createWindow];
    window.windowLevel = UIWindowLevelStatusBar + 1;
    window.rootViewController = [UIViewController new];
    window.backgroundColor = UIColor.clearColor;
  });
  return window;
}

+ (DTBubbleTipsWindow *)createWindow {
  DTBubbleTipsWindow *window;
  if (@available(iOS 13.0, *)) {
    if (!UIApplication.sharedApplication.keyWindow) {
      for (UIWindowScene *scene in UIApplication.sharedApplication.connectedScenes) {
        // TODO: ?why unattached
        if (scene.activationState <= UISceneActivationStateForegroundActive) {
          window = [[DTBubbleTipsWindow alloc] initWithWindowScene:scene];
        }
      }
    }
  }
  
  if (!window) {
    window = [[DTBubbleTipsWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
  }
  
  window.delegate = self.eventHandler;
  return window;
}

+ (DTBubbleTipsView *)showTipsWithConfig:(DTBubbleTipsConfig *)config
                          pointingToView:(UIView *)pointedView
                                 spacing:(CGFloat)spacing {
  DTBubbleTipsView *bubble = [[DTBubbleTipsView alloc] initWithConfig:config delegate:self.eventHandler];
  DTBubbleTipsWindow *window = self.window;
  [window makeKeyAndVisible];
  [window addSubview:bubble];
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self.eventHandler action:@selector(didClickTipsView:)];
  [bubble addGestureRecognizer:tap];
  
  CGPoint originInpointedView = CGPointMake(pointedView.frame.size.width / 2 - bubble.triangle.center.x, pointedView.frame.size.height);
  CGPoint origin = [pointedView convertPoint:originInpointedView toView:window];
  CGFloat x = origin.x;
  CGFloat y = origin.y;
  CGFloat width = bubble.frame.size.width;
  CGFloat height = bubble.frame.size.height;
  
  if (config.orientation == DTBubbleTipsTriangleOrientationPointingUp) {
    bubble.frame = CGRectMake(x, y + spacing, width, height);
  } else if (config.orientation == DTBubbleTipsTriangleOrientationPointingDown) {
    bubble.frame = CGRectMake(x, y - spacing - height - pointedView.frame.size.height, width, height);
  } // TODO: horizontal
  
  [bubble adjustPositionIfNeeded];
  [bubble animatedShow];
  return bubble;
}

- (void)didClickTipsView:(UITapGestureRecognizer *)tap {
  DTBubbleTipsView *tipsView = (DTBubbleTipsView *)tap.view;
  NSAssert([tipsView isKindOfClass:DTBubbleTipsView.class], @"Illegal parameter");
  if (tipsView.config.dismissWhenTouchInsideBubble) {
    [self dismissTipsView:tipsView];
  }
  if (tipsView.config.touchOnBubbleCallback) {
    tipsView.config.touchOnBubbleCallback();
  }
}

- (void)dismissTipsView:(DTBubbleTipsView *)tipsView {
  [tipsView animatedDismiss];
}

- (void)tipsViewDidDisappear:(DTBubbleTipsView *)tipsView {
  [tipsView removeFromSuperview];
  DTBubbleTipsWindow *window = DTBubbleTipsHelper.window;
  if (window.subviews.count == 0) {
    window.hidden = YES;
  }
}

#pragma mark - DTBubbleTipsWindowDelegate Methods

- (void)didClickOnTipsWindow:(DTBubbleTipsWindow *)tipsWindow {
  for (DTBubbleTipsView *tipsView in tipsWindow.tipsViews) {
    if (tipsView.config.dismissWhenTouchOutsideBubble) {
      [tipsView removeFromSuperview];
    }
  }
}

@end
