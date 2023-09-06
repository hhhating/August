//
//  UIManager.h
//  DesignPatterns
//
//  Created by ByteDance on 2023/8/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIManager : NSObject

+ (instancetype)sharedInstance;
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
