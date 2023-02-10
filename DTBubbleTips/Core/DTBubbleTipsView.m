//
//  DTBubbleTipsView.m
//  DTBubbleTipsDemo
//
//  Created by aa on 2022/6/27.
//

#import "DTBubbleTipsView.h"

#import "DTBubbleTipsConfig.h"
#import "DTBubbleTipsContentView.h"
#import "DTBubbleTipsAnimation.h"

NSString * const DTBubbleTipsAppearAnimationKey = @"bubble_appear";
NSString * const DTBubbleTipsDisappearAnimationKey = @"bubble_disappear";

@interface DTBubbleTipsView () <DTBubbleTipsContentViewDelegate>

@end

@implementation DTBubbleTipsView

- (instancetype)initWithConfig:(DTBubbleTipsConfig *)config
                      delegate:(nullable id<DTBubbleTipsViewDelegate>)delegate {
  if (self = [super initWithFrame:CGRectZero]) {
    _board = [[UIImageView alloc] init];
    _triangle = [[UIImageView alloc] init];
    
    Class contentViewClass = NSClassFromString(config.contentViewClassName);
    NSAssert([contentViewClass isSubclassOfClass:DTBubbleTipsContentView.class],
             @"Bad contentViewClass name. class = %@", contentViewClass);
    _contentView = [[contentViewClass alloc] initWithConfig:config];
    _contentView.delegate = self;
    
    _delegate = delegate;
    
    [self addSubview:_board];
    [self addSubview:_triangle];
    [_board addSubview:_contentView];
    
    _config = config;
    [self drawWithNewConfig];
    [self setupUI];
    
    self.userInteractionEnabled = YES;
    _board.userInteractionEnabled = YES;
    _contentView.userInteractionEnabled = YES;
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  return [self initWithConfig:DTBubbleTipsConfig.new delegate:nil];
}

#pragma mark - Private

- (void)setupUI {
  [self layoutContentView];
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

- (void)layoutContentView {
  CGFloat hotizontalMargin = self.config.contentsMargin.left + self.config.contentsMargin.right;
  CGFloat verticalMargin = self.config.contentsMargin.top + self.config.contentsMargin.bottom;
  CGSize contentBoundSize = CGSizeMake(self.maximumWidth - hotizontalMargin,
                                       self.maximumHeight - verticalMargin);
  CGSize contentSize = [self.contentView layoutAndCalcSizeInBoundSize:contentBoundSize];
  
  self.contentView.frame = CGRectMake(self.config.contentsMargin.left,
                                      self.config.contentsMargin.right,
                                      contentSize.width,
                                      contentSize.height);
}

- (void)layoutBoard {
  CGSize contentSize = self.contentView.frame.size;
  CGFloat width = contentSize.width + self.config.contentsMargin.left + self.config.contentsMargin.right;
  CGFloat height = contentSize.height + self.config.contentsMargin.top + self.config.contentsMargin.bottom;
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

#pragma mark - Animation

- (void)animatedShow {
  DTBubbleTipsAnimation *animationModel = self.config.appearAnimation;
  if (!animationModel) {
    return;
  }
  [CATransaction begin];
  CAAnimation *animation = [animationModel buildAnimationForView:self];
  __weak __typeof(self) weakSelf = self;
  [CATransaction setCompletionBlock:^{
    [weakSelf animationDidStop:YES];
  }];
  [self.layer addAnimation:animation forKey:DTBubbleTipsAppearAnimationKey];
  [CATransaction commit];
}

- (void)animatedDismiss {
  DTBubbleTipsAnimation *animationModel = self.config.disappearAnimation;
  if (!animationModel) {
    [self.delegate tipsViewDidDisappear:self];
    return;
  }
  CAAnimation *animation = [animationModel buildAnimationForView:self];
  __weak __typeof(self) weakSelf = self;
  [CATransaction setCompletionBlock:^{
    [weakSelf animationDidStop:NO];
  }];
  [self.layer addAnimation:animation forKey:DTBubbleTipsDisappearAnimationKey];
  [CATransaction commit];
}

- (void)cancelAnimationOnView {
  [self.layer removeAnimationForKey:DTBubbleTipsAppearAnimationKey];
  [self.layer removeAnimationForKey:DTBubbleTipsDisappearAnimationKey];
}

// CAAnimationDelegate's `anim` is not what was added to layer, don't know why.
// So use CATransaction instead.
- (void)animationDidStop:(BOOL)appear {
  if (!appear) {
    [self.delegate tipsViewDidDisappear:self];
  }
}

#pragma mark - DTBubbleTipsContentViewDelegate Methods

- (void)dismissWithContentView:(DTBubbleTipsContentView *)contentView {
  [self animatedDismiss];
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
