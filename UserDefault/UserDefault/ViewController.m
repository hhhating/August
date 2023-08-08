//
//  ViewController.m
//  UserDefault
//
//  Created by ByteDance on 2023/8/8.
//

#import "ViewController.h"
#import "LTUser.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self storage];
    [self show];
}

- (void)storage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"Jane" forKey:@"Name"];
    [defaults setObject:@"female" forKey:@"Sex"];
    [defaults setInteger:30 forKey:@"Age"];
    [defaults setFloat:165.5 forKey:@"Height"];
    [defaults setFloat:45.5 forKey:@"Weight"];
    [defaults setBool:NO forKey:@"Marriage"];
    NSArray *holdArr = [NSArray arrayWithObjects:@"House", @"Car", @"Deposit", nil];
    [defaults setObject:holdArr forKey:@"Property"];
    LTUser *user = [[LTUser alloc] init];
    user.userName = @"Jane_lucky";
    user.password = @"123321";
    // 归档保存，保存自定义对象
    NSError *error = nil;
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user requiringSecureCoding:YES error:&error];
    if (error) {
        NSLog(@"Archiving user data failed with error: %@", error);
    }
    [defaults setObject:userData forKey:@"User"];
}

- (void)show {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"Name: %@", [defaults objectForKey:@"Name"]);
    NSLog(@"Sex: %@", [defaults objectForKey:@"Sex"]);
    NSLog(@"Age: %ld", [defaults integerForKey:@"Age"]);
    NSLog(@"Height: %f", [defaults floatForKey:@"Height"]);
    NSLog(@"Weight: %f", [defaults floatForKey:@"Weight"]);
    NSLog(@"Marriage: %d", [defaults boolForKey:@"Marriage"]);
    NSLog(@"Property: %@", [defaults objectForKey:@"Property"]);
    // 获取自定义对象
    NSData *userData = [defaults objectForKey:@"User"];
    // 解挡，回复对象
    NSError *error = nil;
    LTUser *user = [NSKeyedUnarchiver unarchivedObjectOfClass:[LTUser class] fromData:userData error:&error];
    if (error) {
        NSLog(@"Unarchiving user data failed with error: %@", error);
    }
    NSLog(@"%@", [user toString]);
}

@end

