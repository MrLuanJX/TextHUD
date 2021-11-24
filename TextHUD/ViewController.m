//
//  ViewController.m
//  TextHUD
//
//  Created by hogo0211 on 2021/11/24.
//

#import "ViewController.h"
#import "TextHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    btn.backgroundColor = [UIColor blackColor];
    [btn setTitle:@"alert" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnAction {
    [TextHUD showInWindowWithDuration:2 Text:@"这是一个纯文本的HUD"];
    [TextHUD showIn:self.view text:@"这是一个纯文本的HUD"];
    [TextHUD showIn:self.view Duration:2 Text:@"这是一个纯文本的HUD"];
    
    [TextHUD hideIn:self.view];
    [TextHUD dismiss];
}



@end
