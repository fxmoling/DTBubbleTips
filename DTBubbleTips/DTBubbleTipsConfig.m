//
//  DTBubbleTipsConfig.m
//  DTBubbleTipsDemo
//
//  Created by aa on 2022/6/27.
//

#import "DTBubbleTipsConfig.h"

@implementation DTBubbleTipsConfig

- (instancetype)init {
  if (self = [super init]) {
    _textColor = UIColor.whiteColor;
    _triangleColor = UIColor.blackColor;
    _boardColor = UIColor.blackColor;
    
    _triangleOffset = 0.5;
    _marginForLabel = UIEdgeInsetsMake(8, 8, 8, 8);
    _font = [UIFont systemFontOfSize:14];
    
    _triangleSize = CGSizeMake(12, 6);
    _boardCornerRadius = 4;
    
    _textColor = UIColor.whiteColor;
    _triangleColor = UIColor.blackColor;
    _boardColor = UIColor.blackColor;
    
    _minimumHorizontalSafeSpacing = 8;
    _minimumVerticalSafeSpacing = 8;
  }
  return self;
}

#ifndef DISABLE_DTBUBBLETIPS_EXAMPLE

+ (DTBubbleTipsConfig *)exampleConfig {
  DTBubbleTipsConfig *config = self.new;
  config.text = @"Welcome:)123 yeah this is very long cool who know 2022 kkkkkkkkkkkkkkkkkWelcome:)123 yeah this is very long cool who know 2022 kkkkkkkkkkkkkkkkk";
  config.triangleSize = CGSizeMake(12, 6);
  config.boardCornerRadius = 4;
  config.orientation = DTBubbleTipsTriangleOrientationPointingDown;
  config.dismissWhenTouchOutsideBubble = YES;
  return config;
}

#endif  // DISABLE_DTBUBBLETIPS_EXAMPLE

@end
