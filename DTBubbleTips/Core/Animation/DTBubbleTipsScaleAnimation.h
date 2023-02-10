//
//  DTBubbleTipsScaleAnimation.h
//  DTBubbleTipsDemo
//
//  Created by aa on 2023/1/9.
//

#import "DTBubbleTipsAnimation.h"

NS_ASSUME_NONNULL_BEGIN

@interface DTBubbleTipsScaleAnimation : DTBubbleTipsAnimation

/// @brief x and y should be fractional value, i.e. from 0 to 1.
///  Default to be (0.5, 0.5).
@property (nonatomic, assign) CGPoint centralPoint;

/// @brief Default to be 0.
@property (nonatomic, assign) CGFloat fromScale;

/// @brief Default to be 0.
@property (nonatomic, assign) CGFloat toScale;

@end

NS_ASSUME_NONNULL_END
