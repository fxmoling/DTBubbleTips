//
//  DTBubbleTipsConfig.h
//  DTBubbleTipsDemo
//
//  Created by aa on 2022/6/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DTBubbleTipsAnimation;

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
 * |         |       Board       |<->| *
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

/// @brief The spacing between the triangle and the pointed view. Default to be
///  3.
@property(nonatomic, assign) CGFloat spacingToPointedView;

/// @brief By default, if the orienration is `PointingUp' or `PointingDown', meanwhile
/// The height of the Bubble is going to exceed the screen, the `orientation' will
/// be adjusted to the "opposite side" so that it can be fully displayed in screen.
/// To disable this default behaviour, just set this field to "NO".
@property (nonatomic, assign) BOOL disableAutoAdjustOrientation;

@property (nonatomic, assign) CGSize triangleSize;

/// @brief Margin of the contents.
@property (nonatomic, assign) UIEdgeInsets contentsMargin;

/// @brief The Bubble's max width. The text will be devided into multiple lines
///  if there were no enough horizontal space to display it correctly. Default to
///  0, which means no constraint.
/// @note If the content is too large to satify both width and height constraint,
///  the content would be clipped.
@property (nonatomic, assign) CGFloat maximumWidth;

/// @brief The Bubble's max height. The text will be devided into multiple lines
///  if there were no enough horizontal space to display it correctly. Default to
///  0, which means no constraint.
/// @note If the content is too large to satify both width and height constraint,
///  the content would be clipped. 
@property (nonatomic, assign) CGFloat maximumHeight;

/// @brief The minimum spacing in horizontal between the Bubble and the Screen.
///  When the Bubble is too wide to be fully displayed in screen, the position of
///  the Board will be adjusted towards left or right, correspondingly. Default to
///  0, meaning limitted by screen bounds.
@property (nonatomic, assign) CGFloat minimumHorizontalSafeSpacing;

/// @brief The minimum spacing in vertical between the Bubble and the Screen.
///  When the Bubble is too wide to be fully displayed in screen, the position of
///  the Board will be adjusted towards top or bottom, correspondingly. Default to
///  0, meaning limitted by screen bounds.
@property (nonatomic, assign) CGFloat minimumVerticalSafeSpacing;

#pragma mark - Appearance

/// @brief Default to be black.
@property (nonatomic, strong, nullable) UIColor *triangleColor;

/// @brief The filling image of the Triangle. If set, the `triangleColor`
///  will be ignored.
@property (nonatomic, strong, nullable) UIImage *triangleImage;

/// @brief Default to be black.
@property (nonatomic, strong, nullable) UIColor *boardColor;

/// @brief The filling image of the Board. If set, the `boardColor`
///  will be ignored.
@property (nonatomic, strong, nullable) UIImage *boardImage;

/// @brief Default to 4.
@property (nonatomic, assign) CGFloat boardCornerRadius;

#pragma mark - Shadow

/// @note The following shadow properties are the same as the corresponding properties in CALayer.
@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic, assign) CGSize shadowOffset;
@property (nonatomic, assign) CGFloat shadowRadius;
@property (nonatomic, assign) CGFloat shadowOpacity;

#pragma mark - Animation

@property (nonatomic, strong) DTBubbleTipsAnimation *appearAnimation;
@property (nonatomic, strong) DTBubbleTipsAnimation *disappearAnimation;

#pragma mark - Actions

/// @brief If YES, when user tap inside the Bubble, the Bubble will dismiss.
@property (nonatomic, assign) BOOL dismissWhenTouchInsideBubble;

/// @brief If YES, the tipsView can receive gesture even it overflows the superview.
@property (nonatomic, assign) BOOL clickableWhenOverflowFromSuperview;

/// @brief If YES, when user touches outside the Bubble, the Bubble will dismiss
///  immediately. Only working when the `hostView` is `nil`.
/// @note When the `hostView` is `nil`, the tipsView will be added to a window by default.
///  The window's `hitTest` is overwritten to dismiss the tipsView when user touches on it.
@property (nonatomic, assign) BOOL dismissWhenTouchOutsideBubble;

/// @brief Triggered when user touches on(inside) the Bubble.
@property (nonatomic, copy, nullable) void(^touchOnBubbleCallback)(void);

/// @brief Trigger when bubble is dismissed by one of the following actions:
/// - Bubble clicked and `dismissWhenTouchInsideBubble` is `YES`.
/// - Mask window clicked and `dismissWhenTouchOutsideBubble` is `YES`.
/// - Close button clicked (If exists and is enabled).
/// - [unimplemented] The display time ends.
/// @note If you call the `removeFromSuperview` manually or set the view's `hidden`
///  to `YES` or set it's alpha to 0, this callback will NOT be triggered.
@property (nonatomic, copy, nullable) void(^bubbleDisappearCallback)(void);

/// @brief For subclass
- (NSString *)contentViewClassName;

@end

NS_ASSUME_NONNULL_END
