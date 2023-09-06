//
//  ViewController.m
//  Single
//
//  Created by ByteDance on 2023/8/30.
//

#import "ViewController.h"
#import "Single.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Single *a = [Single getInstance];
    [a loadString:@"123"];
    
    Single *b = [Single getInstance];
    [b loadString:@"456"];
}

@end
