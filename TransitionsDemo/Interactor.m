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

- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    self.modalExpandedFrame = [transitionContext containerView].bounds;
}

- (void)updateInteractiveTransition:(CGFloat)percentComplete {
    CGFloat xOriginDelta = self.modalExpandedFrame.origin.x - self.modalCollapsedFrame.origin.x;
    CGFloat yOriginDelta = self.modalExpandedFrame.origin.y - self.modalCollapsedFrame.origin.y;
    CGFloat xWidthDelta = self.modalExpandedFrame.size.width - self.modalCollapsedFrame.size.width;
    CGFloat yHeightDelta = self.modalExpandedFrame.size.height - self.modalCollapsedFrame.size.height;
    
    CGFloat transitionX = self.modalCollapsedFrame.origin.x + (xOriginDelta * percentComplete);
    CGFloat transitionY = self.modalCollapsedFrame.origin.y + (yOriginDelta * percentComplete);
    CGFloat transitionWidth = self.modalCollapsedFrame.size.width + (xWidthDelta * percentComplete);
    CGFloat transitionHeight = self.modalCollapsedFrame.size.height + (yHeightDelta * percentComplete);
    
    UIView *fromView = [self.transitionContext viewForKey:UITransitionContextFromViewKey];
    fromView.frame = CGRectMake(transitionX, transitionY, transitionWidth, transitionHeight);
}

- (void)cancelInteractiveTransition {
    UIView *fromView = [self.transitionContext viewForKey:UITransitionContextFromViewKey];
    [self animateWithModalView:fromView destinationFrame:self.modalExpandedFrame didComplete:NO];
}

- (void)finishInteractiveTransition {
    UIView *fromView = [self.transitionContext viewForKey:UITransitionContextFromViewKey];
    [self animateWithModalView:fromView destinationFrame:self.modalCollapsedFrame didComplete:YES];
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
    
    [self animateWithModalView:modalView destinationFrame:destinationFrame didComplete:YES];
}

- (void)animateWithModalView:(UIView *)view destinationFrame:(CGRect)destinationFrame didComplete:(BOOL)didComplete {
    [UIView animateWithDuration:[self transitionDuration:self.transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:0 animations:^{
        view.frame = destinationFrame;
        [view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.transitionContext completeTransition:didComplete];
    }];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.isInteractive ? self : nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.isInteractive ? self : nil;
}

- (void)animationEnded:(BOOL) transitionCompleted {
    self.isInteractive = NO;
    self.isPresenting = NO;
}

@end
