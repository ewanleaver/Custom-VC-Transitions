//
//  Interactor.h
//  TransitionsDemo
//
//  Created by Ewan Leaver on 2016/03/13.
//  Copyright © 2016年 Ewan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Interactor : UIPercentDrivenInteractiveTransition <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) CGRect modalCollapsedFrame;
@property (nonatomic, assign) CGRect modalExpandedFrame;
@property (nonatomic, assign) BOOL isPresenting;

@end
