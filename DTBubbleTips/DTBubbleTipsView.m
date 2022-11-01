//
//  DTBubbleTipsView.m
//  DTBubbleTipsDemo
//
//  Created by aa on 2022/6/27.
//

#import "DTBubbleTipsView.h"

@interface DTBubbleTipsView ()

@property (nonatomic, weak) id<DTBubbleTipsViewDelegate> delegate;

@end

@implementation DTBubbleTipsView

- (instancetype)initWithConfig:(DTBubbleTipsConfig *)config
                      delegate:(nullable id<DTBubbleTipsViewDelegate>)delegate {
  if (self = [super initWithFrame:CGRectZero]) {
    _label = [[UILabel alloc] init];
    _board = [[UIImageView alloc] init];
    _triangle = [[UIImageView alloc] init];
    _label.numberOfLines = 0;
    
    _delegate = delegate;
    
    [self addSubview:_board];
    [self addSubview:_triangle];
    [_board addSubview:_label];
    
    _config = config;
    [self drawWithNewConfig];
    [self setupUI];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTouch)];
    [self addGestureRecognizer:tap];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  return [self initWithConfig:DTBubbleTipsConfig.new delegate:nil];
}

#pragma mark - Private

- (void)setupUI {
  [self layoutLabel];
  [self layoutBoard];
  [self layoutTriangle];
  
  if (self.isVertical) {
    self.frame = CGRectMake(0, 0,
                            self.board.frame.size.width,
                            self.board.frame.size.height + self.config.triangleSize.height);
  } else {
    self.frame = CGRectMake(0, 0,
                            self.board.frame.size.width + self.config.triangleSize.width,
                            self.board.frame.size.height);
  }
}

- (void)layoutLabel {
  CGFloat hotizontalMargin = self.config.marginForLabel.left + self.config.marginForLabel.right;
  CGFloat verticalMargin = self.config.marginForLabel.top + self.config.marginForLabel.bottom;
  CGSize labelMaxSize = CGSizeMake(self.maximumWidth - hotizontalMargin,
                                   self.maximumHeight - verticalMargin);
  CGSize labelSize = [self.label sizeThatFits:labelMaxSize];
  
  self.label.frame = CGRectMake(self.config.marginForLabel.left,
                                self.config.marginForLabel.right,
                                labelSize.width,
                                labelSize.height);
}

- (void)layoutBoard {
  CGSize labelSize = self.label.frame.size;
  CGFloat width = labelSize.width + self.config.marginForLabel.left + self.config.marginForLabel.right;
  CGFloat height = labelSize.height + self.config.marginForLabel.top + self.config.marginForLabel.bottom;
  self.board.frame = CGRectMake(0, 0, width, height);
  
  
  if (self.config.orientation == DTBubbleTipsTriangleOrientationPointingUp) {
    self.board.center = CGPointMake(width / 2, height / 2 + self.config.triangleSize.height);
  } else if (self.config.orientation == DTBubbleTipsTriangleOrientationPointingDown) {
    self.board.center = CGPointMake(width / 2, height / 2);
  } // TODO: horizontal
}

- (void)layoutTriangle {
  UIImageView *triangle = self.triangle;
  CGSize triangleSize = self.config.triangleSize;
  triangle.frame = CGRectMake(0, 0, triangleSize.width, triangleSize.height);
  
  CGFloat triangleOffset = self.config.triangleOffset >= 1
    ? self.config.triangleOffset
    : self.config.triangleOffset * self.board.frame.size.width;
  
  if (self.config.orientation == DTBubbleTipsTriangleOrientationPointingUp) {
    triangle.center = CGPointMake(triangleOffset, triangleSize.height / 2);
  } else if (self.config.orientation == DTBubbleTipsTriangleOrientationPointingDown) {
    triangle.center = CGPointMake(triangleOffset, triangleSize.height / 2 + self.board.frame.size.height);
  } // TODO: horizontal
}

- (void)adjustPositionIfNeeded {
  if (!self.superview) {
    return;
  }
  
  UIView *rootView = self.superview;
  while (rootView.superview) {
    rootView = rootView.superview;
  }
  
  CGRect frame = [self.superview convertRect:self.frame toView:rootView];
  CGFloat x = CGRectGetMinX(frame);
  CGFloat width = CGRectGetWidth(frame);
  
  CGSize boundSize = self.boundSize;
  
  if (self.isVertical) {
    CGFloat spacing = self.config.minimumHorizontalSafeSpacing;
    CGFloat triangleOffset = self.triangle.center.x;
    CGFloat minOffset = self.config.triangleSize.width / 2 + self.config.boardCornerRadius;
    CGFloat overflowed = 0;
    if (x < self.config.minimumHorizontalSafeSpacing) {
      overflowed = MAX(x - spacing, minOffset - triangleOffset);
    } else if (x + width > boundSize.width - spacing) {
      overflowed = MIN(x + width - (boundSize.width - spacing), width - minOffset - triangleOffset);
    }
    
    self.triangle.center = CGPointMake(self.triangle.center.x + overflowed, self.triangle.center.y) ;
    self.frame = CGRectMake(self.frame.origin.x - overflowed, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
  } else {
    
  }
  
  // TODO: auto flipping
}

- (void)drawWithNewConfig {
  DTBubbleTipsConfig *config = self.config;
  
  UILabel *label = self.label;
  label.text = config.text;
  label.font = config.font;
  label.textColor = config.textColor;
  label.numberOfLines = 0;
  label.lineBreakMode = NSLineBreakByWordWrapping;
  label.textAlignment = NSTextAlignmentLeft;
  
  UIImageView *board = self.board;
  UIImageView *triangle = self.triangle;
  
  if (config.boardImage) {
    board.image = config.boardImage;
  } else {
    board.backgroundColor = config.boardColor;
  }
  board.layer.cornerRadius = config.boardCornerRadius;
  
  if (config.triangleImage) {
    triangle.image = config.triangleImage;
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
  // TODO: Split view?
  CGSize boundSize = UIScreen.mainScreen.bounds.size;
  if (UIApplication.sharedApplication.statusBarOrientation == UIInterfaceOrientationPortrait) {
    return boundSize;
  } else {
    return CGSizeMake(boundSize.height, boundSize.width);
  }
}

- (CGFloat)maximumWidth {
  CGFloat value = self.boundSize.width - 2 * self.config.minimumHorizontalSafeSpacing;
  if (self.config.maximumWidth > 0) {
    value = MIN(value, self.config.maximumWidth);
  }
  return value;
}

- (CGFloat)maximumHeight {
  CGFloat value = self.boundSize.height - 2 * self.config.minimumVerticalSafeSpacing;
  if (self.config.maximumHeight > 0) {
    value = MIN(value, self.config.maximumHeight);
  }
  return value;
}

- (BOOL)isVertical {
  return self.config.orientation == DTBubbleTipsTriangleOrientationPointingUp
    || self.config.orientation == DTBubbleTipsTriangleOrientationPointingDown;
}

@end
