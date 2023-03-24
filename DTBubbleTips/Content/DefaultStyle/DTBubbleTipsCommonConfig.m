//
//  DTBubbleTipsCommonConfig.m
//  DTBubbleTipsDemo
//
//  Created by aa on 2022/12/14.
//

#import "DTBubbleTipsCommonConfig.h"
#import "DTBubbleTipsAnimation.h"
#import "DTBubbleTipsScaleAnimation.h"
#import "DTBubbleTipsAlphaAnimation.h"

@implementation DTBubbleTipsCommonConfig

- (instancetype)init {
  if (self = [super init]) {
    _font = [UIFont systemFontOfSize:15];
    _textColor = UIColor.whiteColor;
    _dismissWhenClickCloseButton = YES;
  }
  return self;
}

- (NSString *)contentViewClassName {
  return @"DTBubbleTipsCommonView";
}

#ifndef DISABLE_DTBUBBLETIPS_EXAMPLE

+ (DTBubbleTipsCommonConfig *)exampleConfig {
  DTBubbleTipsCommonConfig *config = self.new;
  config.text = @"Try webpage translation here";
  config.orientation = DTBubbleTipsTriangleOrientationPointingDown;
  
  config.maximumWidth = 230;
  config.boardCornerRadius = 8;
  config.boardColor = UIColor.systemBlueColor;
  
  config.triangleSize = CGSizeMake(16, 10);
  config.triangleColor = UIColor.systemBlueColor;
  
  config.contentsMargin = UIEdgeInsetsMake(12, 12, 12, 12);
  config.labelLeftSpacing = 12;
  config.labelRightSpacing = 12;
  
  config.shadowColor = UIColor.blackColor;
  config.shadowRadius = 5;
  config.shadowOpacity = 0.35;
  config.shadowOffset = CGSizeMake(5, 5);
  
  config.dismissWhenTouchInsideBubble = YES;
  config.dismissWhenTouchOutsideBubble = YES;
  config.clickableWhenOverflowFromSuperview = YES;
  
  if (@available(iOS 13.0, *)) {
    config.image = [UIImage systemImageNamed:@"a.circle.fill"];
    config.imageTintColor = UIColor.whiteColor;
    config.imageSize = CGSizeMake(36, 36);
    config.imageCornerRadius = 4;
    
    config.closeButtonImage = [UIImage systemImageNamed:@"xmark"];
    config.closeButtonTintColor = UIColor.whiteColor;
    config.closeButtonImageSize = CGSizeMake(16, 16);
  }
  
  DTBubbleTipsScaleAnimation *appearAnimation = [[DTBubbleTipsScaleAnimation alloc] init];
  appearAnimation.duration = 0.25;
  appearAnimation.fromScale = 0;
  appearAnimation.toScale = 1;
  appearAnimation.timingFunctionName = @"easeOut";
  appearAnimation.centralPoint = CGPointMake(0.5, 1);
  config.appearAnimation = appearAnimation;
  
  DTBubbleTipsAlphaAnimation *disappearAnimation = [[DTBubbleTipsAlphaAnimation alloc] init];
  disappearAnimation.duration = 0.25;
  disappearAnimation.fromAlpha = 1;
  disappearAnimation.toAlpha = 0;
  disappearAnimation.timingFunctionName = @"easeOut";
  config.disappearAnimation = disappearAnimation;
  
  config.closeButtonExpandedHotAreaSize = CGSizeMake(10, 10);
  
  return config;
}

#endif  // DISABLE_DTBUBBLETIPS_EXAMPLE

@end
