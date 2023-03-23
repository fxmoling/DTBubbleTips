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
                                  onView:(nullable UIView*)hostView
                          pointingToView:(const UIView*)pointedView;

@end

NS_ASSUME_NONNULL_END
