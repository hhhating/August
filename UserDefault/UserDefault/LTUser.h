//
//  LTUser.h
//  UserDefault
//
//  Created by ByteDance on 2023/8/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LTUser : NSObject<NSCoding>
// 用户名
@property (nonatomic, strong) NSString *userName;
// 密码
@property (nonatomic, strong) NSString *password;
// 获取对象所有属性组合到的一个字符串
- (NSString *) toString;
@end

NS_ASSUME_NONNULL_END
