//
//  UIView+DTBubbleTips.h
//  DTBubbleTipsDemo
//
//  Created by aa on 2023/3/22.
//

#import <UIKit/UIKit.h>

@class DTBubbleTipsView;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (DTBubbleTips)

- (void)dt_appendBubbleTipsView:(DTBubbleTipsView *)tipsView;

@end

NS_ASSUME_NONNULL_END
