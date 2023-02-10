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
    _triangleColor = UIColor.blackColor;
    _boardColor = UIColor.blackColor;
    
    _triangleOffset = 0.5;
    _contentsMargin = UIEdgeInsetsMake(8, 8, 8, 8);
    
    _triangleSize = CGSizeMake(12, 6);
    _boardCornerRadius = 4;
    
    _triangleColor = UIColor.blackColor;
    _boardColor = UIColor.blackColor;
    
    _minimumHorizontalSafeSpacing = 8;
    _minimumVerticalSafeSpacing = 8;
  }
  return self;
}

- (NSString *)contentViewClassName {
  return @"";
}

@end
