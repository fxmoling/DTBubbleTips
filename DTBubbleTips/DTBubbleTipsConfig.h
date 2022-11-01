//
//  DTBubbleTipsConfig.h
//  DTBubbleTipsDemo
//
//  Created by aa on 2022/6/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/* *********************************** *
 * Area Defination:                    *
 *                                     *
 *  ---------------------------------  *
 * |             Screen              | *
 * |                                 | *
 * |                                 | *
 * |            [PointedView]        | *
 * |                /\  <- Triangle  | *
 * |          ------  -----------    | *
 * |         |       Label       |<->| *
 * |          -------------------  ↑ | *
 * |                               | | *
 * |    minimumHorizontalSafeSpacing | *
 * |---------------------------------| *
 *     Triangle + Board = Bubble       *
 * *********************************** */

typedef NS_ENUM(NSUInteger, DTBubbleTipsTriangleOrientation) {
  /// Triangle points up, the Board is below the Triangle, and the Bubble is below
  /// the aligned view.
  DTBubbleTipsTriangleOrientationPointingUp,
  /// Triangle points down, the Board is above the Triangle, and the Bubble is above
  /// the aligned view.
  DTBubbleTipsTriangleOrientationPointingDown,
  /// Triangle points left, the Board is on the right of the Triangle, and the Bubble
  /// is on the right of the aligned view.
  DTBubbleTipsTriangleOrientationPointingLeft,
  /// Triangle points right, the Board is on the left of the Triangle, and the Bubble
  /// is on the left of the aligned view.
  DTBubbleTipsTriangleOrientationPointingRight,
};

@interface DTBubbleTipsConfig : NSObject

#pragma mark - Layout & Alignment

/// @brief The offset of the Triangle. It's considered as the horizontal distance
///  between the LEADING of the Board and the CENTER-X of the Triangle, default to be 0.
/// @note If `triangleOffset` < 1, it will be considered as a fractional value,
///  otherwise as an absolute value. For example, `0.5` means the Triangle is
///  positioned exactly at the middle of the Board, while `5` means the
///  centerX of the Triangle is 5 points from the loading of the Board.
@property (nonatomic, assign) CGFloat triangleOffset;

/// @brief The orientation of the Triangle.
@property (nonatomic, assign) DTBubbleTipsTriangleOrientation orientation;

/// @brief By default, if the orienration is `PointingUp' or `PointingDown', meanwhile
/// The height of the Bubble is going to exceed the screen, the `orientation' will
/// be adjusted to the "opposite side" so that it can be fully displayed in screen.
/// To disable this default behaviour, just set this field to "NO".
@property (nonatomic, assign) BOOL disableAutoAdjustOrientation;

@property (nonatomic, assign) CGSize triangleSize;

/// @brief Margin of the label.
@property (nonatomic, assign) UIEdgeInsets marginForLabel;

/// @brief The maximum value of width. The text will be devided into multiple lines
///  if there were no enough horizontal space to display it correctly. Default to be
///  0, which means no constraint.
@property (nonatomic, assign) CGFloat maximumWidth;

@property (nonatomic, assign) CGFloat maximumHeight;

/// @brief The minimum spacing in horizontal between the Bubble and the Screen.
///  When the Bubble is too wide to be fully displayed in screen, the position of
///  the Board will be adjusted towards left or right, correspondingly. Default to
///  be 0, meaning limitted by screen bounds.
@property (nonatomic, assign) CGFloat minimumHorizontalSafeSpacing;

@property (nonatomic, assign) CGFloat minimumVerticalSafeSpacing;

#pragma mark - Appearance

/// @brief Text to be displayed on the Label.
@property (nonatomic, copy) NSString *text;

/// @brief Default to be system 14pt.
@property (nonatomic, strong) UIFont *font;

/// @brief Default to be white.
@property (nonatomic, strong) UIColor *textColor;

/// @brief Default to be black.
@property (nonatomic, strong, nullable) UIColor *triangleColor;

/// @brief Default to be black.
@property (nonatomic, strong, nullable) UIColor *boardColor;

/// @brief The filling image of the Triangle. If set, the `triangleColor`
///  will be ignored.
@property (nonatomic, strong, nullable) UIImage *triangleImage;

/// @brief The filling image of the Board. If set, the `boardColor`
///  will be ignored.
@property (nonatomic, strong, nullable) UIImage *boardImage;

/// @brief Default to be 4.
@property (nonatomic, assign) CGFloat boardCornerRadius;

#pragma mark - Actions

/// @brief If YES, when user touches inside the Bubble, the Bubble will dismiss
///  immediately.
@property (nonatomic, assign) BOOL dismissWhenTouchInsideBubble;

/// @brief If YES, when user touches outside the Bubble, the Bubble will dismiss
///  immediately.
@property (nonatomic, assign) BOOL dismissWhenTouchOutsideBubble;

/// @brief Triggered when user touches on(inside) the Bubble.
@property (nonatomic, copy, nullable) void(^touchOnBubbleCallback)(void);

@end

@interface DTBubbleTipsConfig (customized)

+ (DTBubbleTipsConfig *)exampleConfig;

@end

NS_ASSUME_NONNULL_END
