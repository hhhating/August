//
//  LTUser.m
//  UserDefault
//
//  Created by ByteDance on 2023/8/8.
//

#import "LTUser.h"

@implementation LTUser

// 恢复
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.userName = [coder decodeObjectForKey:@"userName"];
        self.password = [coder decodeObjectForKey:@"password"];
    }
    return self;
}

// 归档写入
- (void) encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_userName forKey:@"userName"];
    [coder encodeObject:_password forKey:@"password"];
}

- (NSString *)toString {
    return [NSString stringWithFormat:@"userName: %@, password: %@", _userName, _password];
}

@end

