//
//  DTBubbleTipsHelper.m
//  DTBubbleTipsDemo
//
//  Created by aa on 2022/6/27.
//

#import "DTBubbleTipsHelper.h"

@implementation DTBubbleTipsHelper

+ (DTBubbleTipsView *)showTipsWithConfig:(DTBubbleTipsConfig *)config
                             alignToView:(UIView *)alignedView
                                 spacing:(CGFloat)spacing {
  DTBubbleTipsView *bubble = [[DTBubbleTipsView alloc] initWithFrame:CGRectZero config:config];
  
  
  
  return bubble;
}

@end
