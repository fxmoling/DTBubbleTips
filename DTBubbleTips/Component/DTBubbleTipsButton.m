//
//  DTBubbleTipsButton.m
//  DTBubbleTipsDemo
//
//  Created by aa on 2023/3/6.
//

#import "DTBubbleTipsButton.h"

@implementation DTBubbleTipsButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
  CGSize size = self.expandedHotAreaSize;
  CGRect bounds = CGRectInset(self.bounds, -size.width, -size.height);
  return CGRectContainsPoint(bounds, point);
}

@end
