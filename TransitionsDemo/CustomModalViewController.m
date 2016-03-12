//
//  CustomModalViewController.m
//  TransitionsDemo
//
//  Created by Ewan Leaver on 2016/03/13.
//  Copyright © 2016年 Ewan. All rights reserved.
//

#import "CustomModalViewController.h"

@interface CustomModalViewController ()

@end

@implementation CustomModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [closeButton setTitle:@"X" forState:UIControlStateNormal];
    closeButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [closeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[closeButton(40)]-(10)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(closeButton)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(22)-[closeButton(40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(closeButton)]];
    
    UIImageView *imageView = [UIImageView new];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.image = [UIImage imageNamed:@"dog.jpg"];
    [self.view addSubview:imageView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(imageView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(imageView)]];
}

- (void)closeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
