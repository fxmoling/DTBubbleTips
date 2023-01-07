//
//  DTBubbleTipsHelper.h
//  DTBubbleTipsDemo
//
//  Created by aa on 2022/6/27.
//

#import "DTBubbleTipsView.h"

#import "DTBubbleTipsCommonConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface DTBubbleTipsHelper : NSObject

+ (DTBubbleTipsView *)showTipsWithConfig:(DTBubbleTipsConfig *)config
                          pointingToView:(UIView *)pointedView
                                 spacing:(CGFloat)spacing;

@end

NS_ASSUME_NONNULL_END