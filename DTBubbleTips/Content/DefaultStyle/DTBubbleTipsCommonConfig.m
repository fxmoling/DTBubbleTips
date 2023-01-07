//
//  DTBubbleTipsCommonConfig.m
//  DTBubbleTipsDemo
//
//  Created by aa on 2022/12/14.
//

#import "DTBubbleTipsCommonConfig.h"

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
  config.text = @"Try webpage translation here 如此美妙的开局💪🏻💪🏻💪🏻💪🏻💪🏻💪🏻💪🏻💪🏻💪🏻💪🏻💪🏻💪🏻好的嘻嘻好的嘻嘻好的嘻嘻好的嘻嘻好的嘻嘻好的嘻嘻好的嘻嘻好的嘻嘻好的嘻嘻好的嘻嘻好的嘻嘻好的嘻嘻好的嘻嘻好的嘻嘻好的嘻嘻好的嘻嘻好的嘻嘻好的嘻嘻";
  config.triangleSize = CGSizeMake(16, 10);
  config.boardCornerRadius = 8;
  config.orientation = DTBubbleTipsTriangleOrientationPointingDown;
  config.dismissWhenTouchOutsideBubble = YES;
  config.boardColor = UIColor.systemBlueColor;
  config.triangleColor = UIColor.systemBlueColor;
  config.maximumWidth = 230;
  
  config.contentsMargin = UIEdgeInsetsMake(12, 12, 12, 12);
  config.labelLeftSpacing = 12;
  config.labelRightSpacing = 12;
  
  if (@available(iOS 13.0, *)) {
    config.image = [UIImage systemImageNamed:@"a.circle.fill"];
    config.imageTintColor = UIColor.whiteColor;
    config.imageSize = CGSizeMake(36, 36);
    config.imageCornerRadius = 4;
    
    config.closeButtonImage = [UIImage systemImageNamed:@"xmark"];
    config.closeButtonTintColor = UIColor.whiteColor;
    config.closeButtonImageSize = CGSizeMake(16, 16);
  }
  
  return config;
}

#endif  // DISABLE_DTBUBBLETIPS_EXAMPLE

@end
