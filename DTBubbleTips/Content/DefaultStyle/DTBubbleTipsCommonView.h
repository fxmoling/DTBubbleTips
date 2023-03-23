//
//  DTBubbleTipsCommonView.h
//  DTBubbleTipsDemo
//
//  Created by aa on 2022/12/13.
//

#import "DTBubbleTipsContentView.h"
#import "DTBubbleTipsCommonConfig.h"

@class DTBubbleTipsButton;

NS_ASSUME_NONNULL_BEGIN

@interface DTBubbleTipsCommonView : DTBubbleTipsContentView

@property (nonatomic, strong, readonly) DTBubbleTipsCommonConfig *config;

@property (nonatomic, strong, readonly) UIImageView *imageView;
@property (nonatomic, strong, readonly) UILabel *label;
@property (nonatomic, strong, readonly) DTBubbleTipsButton *closeButton;

- (instancetype)initWithConfig:(DTBubbleTipsCommonConfig *)config NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
