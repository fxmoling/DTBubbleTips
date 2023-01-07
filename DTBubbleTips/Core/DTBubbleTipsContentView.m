//
//  DTBubbleTipsContentView.m
//  DTBubbleTipsDemo
//
//  Created by aa on 2022/12/14.
//

#import "DTBubbleTipsContentView.h"

@implementation DTBubbleTipsContentView

- (instancetype)initWithConfig:(DTBubbleTipsConfig *)config {
  if (self = [super initWithFrame:CGRectZero]) {
    _config = config;
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  return [self initWithConfig:DTBubbleTipsConfig.new];
}

- (CGSize)layoutAndCalcSizeInBoundSize:(CGSize)boundSize {
  return CGSizeZero;
}

@end
