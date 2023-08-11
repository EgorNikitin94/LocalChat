//
//  BaseRouter.h
//
//  Created by Andrey Zhukov
//

#import <UIKit/UIKit.h>

@protocol BaseRouterInput <NSObject>

- (void)openModuleFromWindow:(UIWindow *)window;
- (void)openModuleFromViewController:(UIViewController *)viewController;

- (void)closeModule;

@end

@interface BaseRouter : NSObject<BaseRouterInput>

@property (weak, nonatomic) UIViewController *view;

@end
