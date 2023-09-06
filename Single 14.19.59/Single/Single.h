//
//  Single.h
//  Single
//
//  Created by ByteDance on 2023/8/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Single : NSObject

+ (instancetype)getInstance;
- (void)loadString:(NSString *)load;

@end

NS_ASSUME_NONNULL_END
