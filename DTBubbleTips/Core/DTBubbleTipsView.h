//
//  DTBubbleTipsView.h
//  DTBubbleTipsDemo
//
//  Created by aa on 2022/6/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DTBubbleTipsView;
@class DTBubbleTipsConfig;
@class DTBubbleTipsContentView;

@protocol DTBubbleTipsViewDelegate <NSObject>
@required

- (void)tipsViewDidEndDisplay:(DTBubbleTipsView *)tipsView;

@end

@interface DTBubbleTipsView : UIView

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithConfig:(DTBubbleTipsConfig *)config
                      delegate:(nullable id<DTBubbleTipsViewDelegate>)delegate NS_DESIGNATED_INITIALIZER;

@property (nonatomic, strong, readonly) UIImageView *board;
@property (nonatomic, strong, readonly) UIImageView *triangle;
@property (nonatomic, strong, readonly) DTBubbleTipsContentView *contentView;

@property (nonatomic, strong, readonly) DTBubbleTipsConfig *config;

- (void)adjustPositionIfNeeded;

@end

NS_ASSUME_NONNULL_END
