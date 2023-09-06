//
//  SingleController.m
//  DesignPatterns
//
//  Created by ByteDance on 2023/8/30.
//

#import "SingleController.h"
#import "UIManager.h"
@interface SingleController ()
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@end

@implementation SingleController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
}

- (void)setUI {
    _button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [_button1 setTitle:@"提示框 1 号" forState:UIControlStateNormal];
    [_button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _button1.backgroundColor = [UIColor blueColor];
    _button1.frame = CGRectMake(45, 250, 100, 50);
    [_button1 addTarget:self action:@selector(button1Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button1];
    
    _button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [_button2 setTitle:@"提示框 2 号" forState:UIControlStateNormal];
    [_button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _button2.backgroundColor = [UIColor blueColor];
    _button2.frame = CGRectMake(245, 250, 100, 50);
    [_button2 addTarget:self action:@selector(button2Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button2];
    
    _label1 = [[UILabel alloc] initWithFrame:CGRectMake(45, 400, 300, 30)];
    _label1.text = @"";
    _label1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label1];
    
    _label2 = [[UILabel alloc] initWithFrame:CGRectMake(45, 450, 300, 30)];
    _label2.text = @"";
    _label2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label2];
}

- (void)button1Click {
    UIManager *uiManager = [UIManager sharedInstance];
    [uiManager showAlertWithTitle:@"提示" message:@"这是第一个示例提示框"];
    _label1.text = [NSString stringWithFormat:@"第一个提示框地址：%p", uiManager];
}

- (void)button2Click {
    UIManager *uiManager = [UIManager sharedInstance];
    [uiManager showAlertWithTitle:@"提示" message:@"这是第二个示例提示框"];
    _label2.text = [NSString stringWithFormat:@"第二个提示框地址：%p", uiManager];
}

@end
