//
//  ViewController.m
//  TransitionsDemo
//
//  Created by Ewan Leaver on 2016/03/13.
//  Copyright © 2016年 Ewan. All rights reserved.
//

#import "ViewController.h"
#import "CustomModalViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(presentModal:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"dog.jpg"] forState:UIControlStateNormal];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button];
    
    // Will be positioned in top right corner:
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[button(150)]-(30)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(button)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(30)-[button(150)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(button)]];
}

- (void)presentModal:(UIButton *)sender {
    CustomModalViewController *modalVIewController = [CustomModalViewController new];
    [self presentViewController:modalVIewController animated:YES completion:^{
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
