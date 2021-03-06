//
//  DTInteractionController.m
//
//  Copyright (c) 2015 Dillion. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "DTInteractionController.h"

@interface DTInteractionController()
@property (nonatomic, assign) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic) BOOL isActive;
@end

@implementation DTInteractionController

- (instancetype)init
{
    self = [self initWithAnimationController:nil decorationLayer:nil];
    return self;
}

- (instancetype)initWithAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
                            decorationLayer:(CALayer *)decorationLayer
{
    self = [super init];
    if (self) {
        _animationController = animationController;
        _decorationLayer = decorationLayer;
    }
    return self;
}

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
    [self pauseLayer:_decorationLayer atTime:pausedTime];
}

- (void)cancelInteractiveTransition
{
    if (!_isActive) return;
    
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
    [self resetLayerTime:_decorationLayer];
}

- (void)reverseAnimation:(CADisplayLink *)displayLink
{
    double percentInterval = displayLink.duration / [_animationController transitionDuration:_transitionContext];
    
    _percentComplete -= percentInterval;
    
    [self updateInteractiveTransition:_percentComplete];
    
    if (_percentComplete <= 0.0) {
        [CATransaction begin];
        [CATransaction disableActions];
        [_transitionContext cancelInteractiveTransition];
        self.isActive = NO;
        CALayer *layer = [_transitionContext containerView].layer;
        [self removeAnimationsRecursively:layer];
        [self removeAnimationsRecursively:_decorationLayer];
        [self resetLayerTime:layer];
        [self resetLayerTime:_decorationLayer];
        [CATransaction commit];
        
        [displayLink invalidate];
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
