//
//  DTBubbleTipsView.h
//  DTBubbleTipsDemo
//
//  Created by aa on 2022/6/27.
//

#import <UIKit/UIKit.h>

#import "DTBubbleTipsConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface DTBubbleTipsView : UIView

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame config:(DTBubbleTipsConfig *)config NS_DESIGNATED_INITIALIZER;

@property (nonatomic, strong, readonly) UILabel *label;
@property (nonatomic, strong, readonly) UIImageView *board;
@property (nonatomic, strong, readonly) UIImageView *triangle;

@property (nonatomic, strong, readonly) DTBubbleTipsConfig *config;

@end

NS_ASSUME_NONNULL_END
