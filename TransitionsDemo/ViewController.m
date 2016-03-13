//
//  ViewController.m
//  TransitionsDemo
//
//  Created by Ewan Leaver on 2016/03/13.
//  Copyright © 2016年 Ewan. All rights reserved.
//

#import "ViewController.h"
#import "CustomModalViewController.h"
#import "Interactor.h"

@interface ViewController ()

@property (nonatomic, strong) Interactor *interactor;

// Reference to the button created in viewDidLoad
@property (nonatomic, strong) UIButton *button;

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
    self.button = button;
    
    // Will be positioned in top right corner:
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[button(150)]-(30)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(button)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(30)-[button(150)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(button)]];
    
    self.interactor = [Interactor new];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // Want to update the modalCollapsedFrame to the button frame, whenever the view may change
    // (For our testing, this will get hit after the view rotates, and the button frame may
    // be different than before)
    if (self.interactor && self.button) {
        self.interactor.modalCollapsedFrame = self.button.frame;
    }
}

- (void)presentModal:(UIButton *)sender {
    CustomModalViewController *modalViewController = [CustomModalViewController new];
    modalViewController.modalPresentationStyle = UIModalPresentationCustom;
    // Step 1. Tell the modal that this ViewController is going to be its transitioningDelegate
    modalViewController.transitioningDelegate = self.interactor;
    self.interactor.isPresenting = YES;
    self.interactor.modalCollapsedFrame = self.button.frame;
    [self presentViewController:modalViewController animated:YES completion:^{
        self.interactor.isPresenting = NO;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
