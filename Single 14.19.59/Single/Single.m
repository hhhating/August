//
//  Single.m
//  Single
//
//  Created by ByteDance on 2023/8/30.
//

#import "Single.h"

@implementation Single

static Single *single = nil;
+ (instancetype)getInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[Single alloc] init];
    });
    return single;
}

- (void)loadString:(NSString *)load {
    NSLog(@"%@", load);
}

@end
