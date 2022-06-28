//
//  DTBubbleTipsView.m
//  DTBubbleTipsDemo
//
//  Created by aa on 2022/6/27.
//

#import "DTBubbleTipsView.h"

@implementation DTBubbleTipsView

- (instancetype)initWithFrame:(CGRect)frame config:(nonnull DTBubbleTipsConfig *)config {
  if (self = [super initWithFrame:frame]) {
    _label = [[UILabel alloc] init];
    _board = [[UIImageView alloc] init];
    _triangle = [[UIImageView alloc] init];
    
    [self addSubview:_board];
    [self addSubview:_triangle];
    [_board addSubview:_label];
    
    _config = config;
    [self layoutWithNewConfig];
    [self drawWithNewConfig];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTouch)];
    [self addGestureRecognizer:tap];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  return [self initWithFrame:CGRectZero config:DTBubbleTipsConfig.new];
}

#pragma mark - Private

- (void)layoutWithNewConfig {
  DTBubbleTipsConfig *config = self.config;
  
  UILabel *label = self.label;
  UIImageView *board = self.board;
  UIImageView *triangle = self.triangle;
  
  CGFloat maxWidth = CGFLOAT_MAX;
  if (config.maximumWidth > 0) {
    maxWidth = config.maximumWidth;
  }
  
  CGSize boundSize = self.boundSize;
  CGFloat widthExceptsLabel = config.margin.left + config.margin.right
    + 2 * config.minimumHorizontalSafeSpacing
    + (self.isVertical ? 0 : config.triangleSize.width);
  maxWidth = MAX(MIN(maxWidth, boundSize.width - widthExceptsLabel), 0);
  
  CGFloat triangleOffset = self.isVertical
    ? (config.triangleOffset >= 1 ? config.triangleOffset : config.triangleOffset * config.boardSize.width)
    : (config.triangleOffset >= 1 ? config.triangleOffset : config.triangleOffset * config.boardSize.height);
  
  label.translatesAutoresizingMaskIntoConstraints = NO;
  board.translatesAutoresizingMaskIntoConstraints = NO;
  triangle.translatesAutoresizingMaskIntoConstraints = NO;
  
  [NSLayoutConstraint activateConstraints:@[
    [label.widthAnchor constraintLessThanOrEqualToConstant:maxWidth],
    [label.leadingAnchor constraintEqualToAnchor:board.leadingAnchor constant:config.margin.left],
    [label.topAnchor constraintEqualToAnchor:board.topAnchor constant:config.margin.top],
    [label.bottomAnchor constraintEqualToAnchor:board.bottomAnchor constant:config.margin.bottom],
    [label.trailingAnchor constraintEqualToAnchor:board.trailingAnchor constant:config.margin.right],
    
    [triangle.widthAnchor constraintEqualToConstant:config.triangleSize.width],
    [triangle.heightAnchor constraintEqualToConstant:config.triangleSize.height],
  ]];
  
  if (self.isVertical) {
    [triangle.centerXAnchor constraintEqualToAnchor:board.leadingAnchor constant:triangleOffset].active = YES;
    if (config.orientation == DTBubbleTipsTriangleOrientationPointingUp) {
      [triangle.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
      [triangle.bottomAnchor constraintEqualToAnchor:board.topAnchor].active = YES;
      [self.bottomAnchor constraintEqualToAnchor:board.bottomAnchor].active = YES;
    } else {
      [triangle.topAnchor constraintEqualToAnchor:board.bottomAnchor].active = YES;
      [triangle.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
      [self.topAnchor constraintEqualToAnchor:board.topAnchor].active = YES;
    }
    [board.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [board.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
  } else {
    [triangle.centerYAnchor constraintEqualToAnchor:board.topAnchor constant:triangleOffset].active = YES;
    if (config.orientation == DTBubbleTipsTriangleOrientationPointingLeft) {
      [triangle.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
      [triangle.trailingAnchor constraintEqualToAnchor:board.leadingAnchor].active = YES;
      [self.trailingAnchor constraintEqualToAnchor:board.trailingAnchor].active = YES;
    } else {
      [triangle.leadingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
      [triangle.trailingAnchor constraintEqualToAnchor:board.trailingAnchor].active = YES;
      [self.leadingAnchor constraintEqualToAnchor:board.leadingAnchor].active = YES;
    }
    [board.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [board.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
  }
}

- (void)drawWithNewConfig {
  DTBubbleTipsConfig *config = self.config;
  
  UILabel *label = self.label;
  label.text = config.text;
  label.font = config.font;
  label.textColor = config.textColor;
  
  UIImageView *board = self.board;
  UIImageView *triangle = self.triangle;
  
  if (config.triangleImage) {
    triangle.image = config.triangleImage;
  } else {
    UIBezierPath *boardPath = [UIBezierPath bezierPathWithRoundedRect:board.bounds cornerRadius:config.boardCornerRadius];
    CAShapeLayer *boardMaskLayer = [CAShapeLayer layer];
    boardMaskLayer.path = boardPath.CGPath;
    board.backgroundColor = config.boardColor;
    board.layer.mask = boardMaskLayer;
  }
  
  if (config.boardImage) {
    self.board.image = config.boardImage;
  } else {
    UIBezierPath *trianglePath = self.triangleBezierPath;
    CAShapeLayer *triangleMaskLayer = [CAShapeLayer layer];
    triangleMaskLayer.path = trianglePath.CGPath;
    triangle.backgroundColor = config.triangleColor;
    triangle.layer.mask = triangleMaskLayer;
  }
}

- (UIBezierPath *)triangleBezierPath {
  DTBubbleTipsConfig *config = self.config;
  UIBezierPath *trianglePath = [UIBezierPath bezierPath];
  
  CGFloat x = config.triangleSize.width;
  CGFloat y = config.triangleSize.height;
  
  if (config.orientation == DTBubbleTipsTriangleOrientationPointingUp) {
    [trianglePath moveToPoint:CGPointMake(0, y)];
    [trianglePath addLineToPoint:CGPointMake(x, y)];
    [trianglePath addLineToPoint:CGPointMake(x / 2, 0)];
    [trianglePath closePath];
  } else if (config.orientation == DTBubbleTipsTriangleOrientationPointingDown) {
    [trianglePath moveToPoint:CGPointMake(0, 0)];
    [trianglePath addLineToPoint:CGPointMake(x / 2, y)];
    [trianglePath addLineToPoint:CGPointMake(x, 0)];
    [trianglePath closePath];
  } else if (config.orientation == DTBubbleTipsTriangleOrientationPointingLeft) {
    [trianglePath moveToPoint:CGPointMake(0, y / 2)];
    [trianglePath addLineToPoint:CGPointMake(x, y)];
    [trianglePath addLineToPoint:CGPointMake(x, 0)];
    [trianglePath closePath];
  } else {
    [trianglePath moveToPoint:CGPointMake(0, 0)];
    [trianglePath addLineToPoint:CGPointMake(0, y)];
    [trianglePath addLineToPoint:CGPointMake(x, y / 2)];
    [trianglePath closePath];
  }
  
  return trianglePath;
}

- (void)onTouch {
  DTBubbleTipsConfig *config = self.config;
  if (config.touchOnBubbleCallback) {
    config.touchOnBubbleCallback();
  }
  if (config.dismissWhenTouchInsideBubble) {
    [self dismiss];
  }
}

- (void)dismiss {
  self.hidden = YES;
}

- (CGSize)boundSize {
  CGSize boundSize = UIScreen.mainScreen.bounds.size;
  if (UIApplication.sharedApplication.statusBarOrientation == UIInterfaceOrientationPortrait) {
    return CGSizeMake(boundSize.height, boundSize.width);
  } else {
    return boundSize;
  }
}

- (BOOL)isVertical {
  return self.config.orientation == DTBubbleTipsTriangleOrientationPointingUp
    || self.config.orientation == DTBubbleTipsTriangleOrientationPointingDown;
}

@end
