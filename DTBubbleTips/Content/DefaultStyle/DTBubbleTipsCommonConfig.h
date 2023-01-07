//
//  DTBubbleTipsCommonConfig.h
//  DTBubbleTipsDemo
//
//  Created by aa on 2022/12/14.
//

#import "DTBubbleTipsConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface DTBubbleTipsCommonConfig : DTBubbleTipsConfig

#pragma mark - Layout Configs

@property (nonatomic, assign) CGFloat labelLeftSpacing;

@property (nonatomic, assign) CGFloat labelRightSpacing;

#pragma mark - Label Configs

/// @brief Text to be displayed on the Label.
@property (nonatomic, strong) NSString *text;

/// @brief Default to be 14pt system font.
@property (nonatomic, strong) UIFont *font;

/// @brief Default to be white.
@property (nonatomic, strong) UIColor *textColor;

#pragma mark - ImageView Configs

/// @brief Default to be nil, means no left icon will show.
@property (nonatomic, strong, nullable) UIImage *image;

@property (nonatomic, strong, nullable) UIColor *imageTintColor;

/// @brief Default to be {0, 0}, means no left icon will show.
@property (nonatomic, assign) CGSize imageSize;

/// @brief Default to be 0.
@property (nonatomic, assign) CGFloat imageCornerRadius;

#pragma mark - CloseButton Configs

/// @brief Default to be nil, means no close button will show.
@property (nonatomic, strong) UIImage *closeButtonImage;

@property (nonatomic, strong) UIColor *closeButtonTintColor;

/// @brief Default to be {0, 0}, means no close button will show.
@property (nonatomic, assign) CGSize closeButtonImageSize;

/// @brief Allow user to expand the hot area of close button.
/// @note Actually be button's contentEdgeInsets.
@property (nonatomic, assign) UIEdgeInsets closeButtonExpandedHotArea;

@property (nonatomic, strong, nullable) void(^didClickCloseButton)(UIButton *closeButton);

/// @brief If set to NO, the bubble will not dismiss when close button
///  is clicked. Default to be YES.
@property (nonatomic, assign) BOOL dismissWhenClickCloseButton;

@end

@interface DTBubbleTipsCommonConfig (customized)

+ (DTBubbleTipsConfig *)exampleConfig;

@end

NS_ASSUME_NONNULL_END
