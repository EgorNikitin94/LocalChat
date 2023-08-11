//
//  BaseRouter.m
//
//  Created by Andrey Zhukov
//

#import "BaseRouter.h"

@implementation BaseRouter

- (void)closeModule {
  if (self.view.parentViewController && ![self.view.parentViewController isKindOfClass:[UINavigationController class]]) {
    [self.view willMoveToParentViewController:nil];
    [self.view.view removeFromSuperview];
    [self.view removeFromParentViewController];
  } else if (self.view.navigationController) {
    [self.view.navigationController popViewControllerAnimated:YES];
  } else {
    [self.view dismissViewControllerAnimated:YES completion:nil];
  }
}

- (void)openModuleFromWindow:(UIWindow *)window {
  [window setRootViewController:_view];
}
- (void)openModuleFromViewController:(UIViewController *)viewController {
  if ([viewController isKindOfClass:[UINavigationController class]]) {
    [(UINavigationController *)viewController pushViewController:_view animated:YES];
  } else if (viewController.navigationController) {
    [viewController.navigationController pushViewController:_view animated:YES];
  } else {
    [viewController presentViewController:_view animated:YES completion:nil];
  }
}

@end
