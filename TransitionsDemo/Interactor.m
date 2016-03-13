//
//  Interactor.m
//  TransitionsDemo
//
//  Created by Ewan Leaver on 2016/03/13.
//  Copyright © 2016年 Ewan. All rights reserved.
//

#import "Interactor.h"

@interface Interactor ()

// Want to keep a reference to the current transition context
@property (nonatomic, strong) id <UIViewControllerContextTransitioning> transitionContext;

@end


// This is the class that Apple has provided for us to subclass and manage a transition
// that we can actually control at every percentage step of the way

@implementation Interactor

- (void)updateInteractiveTransition:(CGFloat)percentComplete {
    
}

- (void)cancelInteractiveTransition {
    
}

- (void)finishInteractiveTransition {
    
}

// Step 2. Say that when it wants an animationController for presenting or dismissing the modal,
// then this ViewController will also be that.
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}

// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}
// This is where we define the custom transition itself
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    // We set self.transitionContext to the transitionContext that gets passed into the method
    self.transitionContext = transitionContext;
    
    // References to the from/toViews
    // (Reference to the view that presented the modal, and the view that is presented)
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    // This containerView is the view that acts as the superview for the views involved in this transition
    self.modalExpandedFrame = [transitionContext containerView].bounds;
    
    UIView *modalView;
    CGRect destinationFrame;
    
    if (self.isPresenting) {
        modalView = toView;
        destinationFrame = self.modalExpandedFrame;
        // Never need to remove this, the animator will do it for us:
        // (But we do need to remember this when presenting, otherwise no modal view will appear)
        [[transitionContext containerView] addSubview:toView];
        toView.frame = self.modalCollapsedFrame;
        [toView layoutIfNeeded];
    } else {
        modalView = fromView;
        destinationFrame = self.modalCollapsedFrame;
    }
    
    [self animateWithModalView:modalView destinationFrame:destinationFrame];
}

- (void)animateWithModalView:(UIView *)view destinationFrame:(CGRect)destinationFrame {
    [UIView animateWithDuration:[self transitionDuration:self.transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:0 animations:^{
        view.frame = destinationFrame;
        [view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.transitionContext completeTransition:YES];
    }];
}

@end
