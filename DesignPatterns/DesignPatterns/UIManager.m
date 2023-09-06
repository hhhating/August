//
//  UIManager.m
//  DesignPatterns
//
//  Created by ByteDance on 2023/8/31.
//

#import "UIManager.h"

@implementation UIManager

+ (instancetype)sharedInstance {
    static UIManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[UIManager alloc] init];
    });
    return sharedInstance;
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    
    // 在这里添加其他自定义的 UI 相关逻辑
    
    UIWindowScene *windowScene = (UIWindowScene *)[UIApplication sharedApplication].connectedScenes.anyObject;
    UIWindow *window = windowScene.windows.firstObject;
    UIViewController *rootViewController = window.rootViewController;

    [window.rootViewController presentViewController:alertController animated:YES completion:nil];


}

@end
