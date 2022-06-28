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
  }
  return self;
}

+ (DTBubbleTipsConfig *)exampleConfig {
  DTBubbleTipsConfig *config = self.new;
  config.text = @"Welcome:)";
  config.triangleOffset = 0.5;
  config.triangleSize = CGSizeMake(20, 15);
  
  return config;
}

@end
