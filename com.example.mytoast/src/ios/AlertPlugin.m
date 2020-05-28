//
//  AlertPlugin.m
//  cordovaTest
//
//  Created by xiongwenjie on 2020/5/26.
//

#import "AlertPlugin.h"

@implementation AlertPlugin
- (void)coolMethod:(CDVInvokedUrlCommand*)command{
//    NSLog(@"className:%@ - callbackId:%@ - args:%@ - methodName:%@",
//          command.className,command.callbackId,command.arguments,command.methodName);
    
    if (command.arguments.count > 0) {
//        NSString *title = command.arguments[0];
//
//        TestViewController *controller = [[TestViewController alloc] init];
//        [self.viewController presentViewController:controller animated:YES completion:^{
//            CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"OC传回来的参数"];
//            controller.label.text = title;
//            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//        }];

        UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:@"显示的标题" message:command.arguments[0] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyle)UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"OC回传给js的参数"];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }];
        [alertCtr addAction:okAction];
        
        UIViewController *vc = [AlertPlugin topViewController];
        
        [vc presentViewController:alertCtr animated:YES completion:^{
            
        }];
    }else{
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"没有参数"];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }
    
}
/**
 * 获取当前视图的顶层视图控制器
 */
+ (UIViewController *)topViewController {
    return [self topVCWithRootVC:[UIApplication sharedApplication].windows.firstObject.rootViewController];
}

/**获取viewController可以跳转的*/
+ (UINavigationController *)navigationController:(UIViewController *)viewController{
    if (!viewController.navigationController) {
        UIResponder *responder = [viewController nextResponder];
        while (![responder isKindOfClass:[UIViewController class]]) {
            responder = [responder nextResponder];
            
            if (!responder) {
                return nil;
            }
        }
        viewController = (UIViewController *)responder;
        
        return [self navigationController:viewController];
    }
    
    return viewController.navigationController;
}
/**
* 根据根视图获取顶层视图控制器
*
* rootVC:根视图
*
*/
+ (UIViewController *)topVCWithRootVC:(UIViewController *)rootVC {
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *) rootVC;
        return [self topVCWithRootVC:tabBarController.selectedViewController];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *) rootVC;
        return [self topVCWithRootVC:navigationController.visibleViewController];
    } else if (rootVC.presentedViewController) {
        UIViewController *presentedViewController = rootVC.presentedViewController;
        return [self topVCWithRootVC:presentedViewController];
    } else {
        return rootVC;
    }
}

@end
