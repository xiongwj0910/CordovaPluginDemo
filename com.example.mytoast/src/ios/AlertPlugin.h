//
//  AlertPlugin.h
//  cordovaTest
//
//  Created by xiongwenjie on 2020/5/26.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
NS_ASSUME_NONNULL_BEGIN

@interface AlertPlugin : CDVPlugin
//接收cordova消息方法
- (void)coolMethod:(CDVInvokedUrlCommand*)command;

@end

NS_ASSUME_NONNULL_END
