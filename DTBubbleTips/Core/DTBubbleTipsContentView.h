//
//  DTBubbleTipsContentView.h
//  DTBubbleTipsDemo
//
//  Created by aa on 2022/12/14.
//

#import <UIKit/UIKit.h>

#import "DTBubbleTipsConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface DTBubbleTipsContentView : UIView

@property (nonatomic, strong, readonly) DTBubbleTipsConfig *config;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithConfig:(DTBubbleTipsConfig *)config NS_DESIGNATED_INITIALIZER;

/// Layout within the given bound size and return the content size.
///
/// @param boundSize The maximum size the content may take.
///
/// @return The size that the content is displayed with. If the return value is larger
///   than the given restriction, the content would not be fully displayed.
- (CGSize)layoutAndCalcSizeInBoundSize:(CGSize)boundSize;

@end

NS_ASSUME_NONNULL_END
