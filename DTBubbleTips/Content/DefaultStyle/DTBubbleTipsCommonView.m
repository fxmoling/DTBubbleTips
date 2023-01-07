//
//  DTBubbleTipsCommonView.m
//  DTBubbleTipsDemo
//
//  Created by aa on 2022/12/13.
//

#import "DTBubbleTipsCommonView.h"

@implementation DTBubbleTipsCommonView

@dynamic config;

- (instancetype)initWithConfig:(DTBubbleTipsCommonConfig *)config {
  if (self = [super initWithConfig:config]) {
    UILabel *label = [[UILabel alloc] init];
    [self addSubview:label];
    label.numberOfLines = 0;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.textAlignment = NSTextAlignmentLeft;
    _label = label;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView = imageView;
    
    UIButton *closeButton = [[UIButton alloc] init];
    [self addSubview:closeButton];
    [closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _closeButton = closeButton;
  }
  return self;
}

- (CGSize)layoutAndCalcSizeInBoundSize:(CGSize)boundSize {
  DTBubbleTipsCommonConfig *config = self.config;
  
  CGFloat leftWidth = 0;
  CGFloat rightWidth = 0;
  
  UILabel *label = self.label;
  label.text = config.text;
  label.font = config.font;
  label.textColor = config.textColor;
  
  CGFloat labelMaxWidth = boundSize.width;
  CGSize contentSize = CGSizeMake(0, 0);
  
  CGSize imageSize = config.imageSize;
  UIImageView *imageView = self.imageView;
  if (config.image && imageSize.width > 0 && imageSize.height > 0) {
    imageView.image = config.image;
    imageView.tintColor = config.imageTintColor;
    imageView.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
    leftWidth += imageSize.width + config.labelLeftSpacing;
    labelMaxWidth -= imageSize.width + config.labelLeftSpacing;
    contentSize.height = MAX(contentSize.height, imageSize.height);
  }
  
  CGSize closeButtonSize = config.closeButtonImageSize;
  UIEdgeInsets closeButtonInsets = config.closeButtonExpandedHotArea;
  UIButton *closeButton = self.closeButton;
  if (config.closeButtonImage && closeButtonSize.width > 0 && closeButtonSize.height > 0) {
    [closeButton setImage:config.closeButtonImage forState:UIControlStateNormal];
    closeButton.tintColor = config.closeButtonTintColor;
    closeButton.contentEdgeInsets = closeButtonInsets;
    closeButton.frame = CGRectMake(0, 0, closeButtonSize.width, closeButtonSize.height);
    labelMaxWidth -= imageSize.width + config.labelRightSpacing;
    contentSize.height = MAX(contentSize.height, closeButtonSize.height + closeButtonInsets.top + closeButtonInsets.bottom);
    rightWidth = closeButtonSize.width + config.labelRightSpacing;
  }
  
  CGSize labelSize = [self.label sizeThatFits:CGSizeMake(labelMaxWidth, boundSize.height)];
  contentSize.height = MIN(MAX(contentSize.height, labelSize.height), boundSize.height);
  contentSize.width = MIN(labelSize.width + leftWidth + rightWidth, boundSize.width);
  label.frame = CGRectMake(leftWidth, (contentSize.height - labelSize.height) / 2, labelSize.width, labelSize.height);
  
  imageView.center = CGPointMake(imageSize.width / 2, contentSize.height / 2);
  closeButton.center = CGPointMake(contentSize.width - closeButtonSize.width / 2, contentSize.height / 2);
  
  return contentSize;
}

- (void)closeButtonClicked:(UIButton *)closeButton {
  if (self.config.didClickCloseButton) {
    self.config.didClickCloseButton(closeButton);
  }
}

@end
