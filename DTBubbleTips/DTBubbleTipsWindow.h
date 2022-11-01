//
//  DTBubbleTipsWindow.h
//  DTBubbleTipsDemo
//
//  Created by aa on 2022/10/25.
//

#import <UIKit/UIKit.h>

#import "DTBubbleTipsView.h"

NS_ASSUME_NONNULL_BEGIN

@class DTBubbleTipsWindow;

@protocol DTBubbleTipsWindowDelegate <NSObject>
@required

- (void)didClickOnTipsWindow:(DTBubbleTipsWindow *)tipsWindow;

@end

@interface DTBubbleTipsWindow : UIWindow

@property (nonatomic, weak) id<DTBubbleTipsWindowDelegate> delegate;

- (NSArray<DTBubbleTipsView *> *)tipsViews;

@end

NS_ASSUME_NONNULL_END
