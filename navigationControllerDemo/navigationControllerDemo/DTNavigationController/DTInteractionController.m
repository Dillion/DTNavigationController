//
//  DTInteractionController.m
//  navigationControllerDemo
//
//  Created by Dillion on 1/18/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//

#import "DTInteractionController.h"

@interface DTInteractionController()
@property (nonatomic, assign) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic) BOOL isActive;
@end

@implementation DTInteractionController

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.isActive = YES;
    self.transitionContext = transitionContext;
    
    [_animationController animateTransition:_transitionContext];
    [self updateInteractiveTransition:0];
}

- (void)updateInteractiveTransition:(CGFloat)percentComplete
{
    if (!_isActive) return;
    
    CGFloat percentage = MAX(MIN(1.0f, percentComplete), 0.0f);
    
    _percentComplete = percentage;
    [_transitionContext updateInteractiveTransition:_percentComplete];
    
    CALayer *layer = [_transitionContext containerView].layer;
    CFTimeInterval pausedTime = [_animationController transitionDuration:_transitionContext] * _percentComplete;
    [self pauseLayer:layer atTime:pausedTime];
    [self pauseLayer:_animationController.navigationLayer atTime:pausedTime];
}

- (void)cancelInteractiveTransition
{
    if (!_isActive) return;
    
    [_transitionContext cancelInteractiveTransition];
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(reverseAnimation:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)finishInteractiveTransition
{
    if (!_isActive) return;
    self.isActive = NO;
    
    [_transitionContext finishInteractiveTransition];
    
    CALayer *layer = [_transitionContext containerView].layer;
    [self resetLayerTime:layer];
    [self resetLayerTime:_animationController.navigationLayer];
}

- (void)reverseAnimation:(CADisplayLink *)displayLink
{
    double percentInterval = displayLink.duration / [_animationController transitionDuration:_transitionContext];
    
    _percentComplete -= percentInterval;
    
    if (_percentComplete <= 0.0) {
        self.isActive = NO;
        CALayer *layer = [_transitionContext containerView].layer;
        [_animationController resetAnimation:_transitionContext];
        [self removeAnimationsRecursively:layer];
        [self removeAnimationsRecursively:_animationController.navigationLayer];
        [self resetLayerTime:layer];
        [self resetLayerTime:_animationController.navigationLayer];
        
        [displayLink invalidate];
    } else {
        [self updateInteractiveTransition:_percentComplete];
    }
}

- (void)removeAnimationsRecursively:(CALayer *)layer
{
    [layer.sublayers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(CALayer *)obj removeAllAnimations];
        [self removeAnimationsRecursively:obj];
    }];
}

- (void)resetLayerTime:(CALayer *)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

- (void)pauseLayer:(CALayer *)layer
            atTime:(CFTimeInterval)time
{
    layer.speed = 0;
    layer.timeOffset = time;
}

@end
