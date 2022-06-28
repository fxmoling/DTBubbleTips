//
//  DTBubbleTipsConfig.h
//  DTBubbleTipsDemo
//
//  Created by aa on 2022/6/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/* ********************************** *
 * Area Defination:                   *
 *                                    *
 *        /\  <- Triangle             *
 *  ------  -----------               *
 * |       Label       |  <- Board    *
 *  -------------------               *
 *                                    *
 * Triangle + Board = Bubble          *
 * ********************************** */

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

@property (nonatomic, assign) DTBubbleTipsTriangleOrientation orientation;

@property (nonatomic, assign) CGSize triangleSize;
@property (nonatomic, assign) CGSize boardSize;

/// @brief Margin of the label.
@property (nonatomic, assign) UIEdgeInsets margin;

/// @brief The maximum value of width. The text will be devided into multiple lines
///  if there were no enough horizontal space to display it correctly. Default to be
///  0, which means no constraint.
@property (nonatomic, assign) CGFloat maximumWidth;

/// @brief The minimum spacing in horizontal between the Board and the Screen.
///  When the Board is too wide to be fully displayed in screen, the position of
///  the Board will be adjusted towards left or right, correspondingly. This value
///  makes sense when the adjustion occurs.
@property (nonatomic, assign) CGFloat minimumHorizontalSafeSpacing;

#pragma mark - Appearance

/// @brief Text to be displayed on the Label.
@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) UIFont *font;

/// Default to be white.
@property (nonatomic, strong) UIColor *textColor;

/// Default to be black.
@property (nonatomic, strong, nullable) UIColor *triangleColor;

/// Default to be black.
@property (nonatomic, strong, nullable) UIColor *boardColor;

///// Default to be black.
//@property (nonatomic, strong) UIColor *borderColor;
//
///// Default to be 0.
//@property (nonatomic, assign) CGFloat boarderWidth;

/// @brief The filling image of the Triangle. If set, the `triangleColor`
///  will be ignored.
@property (nonatomic, strong, nullable) UIImage *triangleImage;

/// @brief The filling image of the Board. If set, the `boardColor`
///  will be ignored.
@property (nonatomic, strong, nullable) UIImage *boardImage;

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

NS_ASSUME_NONNULL_END
