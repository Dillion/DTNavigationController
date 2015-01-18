//
//  HamburgerButton.m
//  navigationControllerDemo
//
//  Created by Dillion on 1/17/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//

#import "HamburgerButton.h"

static const CGFloat kWidth = 18.0f;
static const CGFloat kHeight = 16.0f;
static const CGFloat kTopYPosition = 2.0f;
static const CGFloat kMiddleYPosition = 8.0f;
static const CGFloat kBottomYPosition = 14.0f;

@interface HamburgerButton() {
    
}
@property (nonatomic, strong) CAShapeLayer *topShapeLayer;
@property (nonatomic, strong) CAShapeLayer *middleShapeLayer;
@property (nonatomic, strong) CAShapeLayer *bottomShapeLayer;

@end

@implementation HamburgerButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)commonInit
{
    self.lineColor = [UIColor orangeColor];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(kWidth, 0)];
    
    self.topShapeLayer = [CAShapeLayer layer];
    self.middleShapeLayer = [CAShapeLayer layer];
    self.bottomShapeLayer = [CAShapeLayer layer];
    
    [self initializeShapeLayer:_topShapeLayer withPath:path.CGPath];
    [self initializeShapeLayer:_middleShapeLayer withPath:path.CGPath];
    [self initializeShapeLayer:_bottomShapeLayer withPath:path.CGPath];
    
    CGFloat widthMiddle = kWidth/2;
    _topShapeLayer.position = CGPointMake(widthMiddle, kTopYPosition);
    _middleShapeLayer.position = CGPointMake(widthMiddle, kMiddleYPosition);
    _bottomShapeLayer.position = CGPointMake(widthMiddle, kBottomYPosition);
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)initializeShapeLayer:(CAShapeLayer *)shapeLayer
                    withPath:(CGPathRef)pathRef
{
    shapeLayer.path = pathRef;
    shapeLayer.lineWidth = 3;
    shapeLayer.strokeColor = _lineColor.CGColor;
    
    shapeLayer.actions = @{@"transform":[NSNull null], @"position":[NSNull null]};
    
    CGPathRef strokingPathRef = CGPathCreateCopyByStrokingPath(shapeLayer.path, nil, shapeLayer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, shapeLayer.miterLimit);
    shapeLayer.bounds = CGPathGetPathBoundingBox(strokingPathRef);
    
    [self.layer addSublayer:shapeLayer];
}

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(kWidth, kHeight);
}

- (NSArray *)rotationValuesFromTransform:(CATransform3D)transform
                                endValue:(CGFloat)endValue
{
    int frames = 4;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:frames];
    
    for (int i = 0; i < frames; i++) {
        NSValue *val = [NSValue valueWithCATransform3D:CATransform3DRotate(transform, endValue / (frames - 1.0)*i, 0, 0, 1)];
        [array addObject:val];
    }
    return array;
}

- (UIBezierPath *)quadBezierCurveFromPoint:(CGPoint)startPoint
                                   toPoint:(CGPoint)toPoint
                              controlPoint:(CGPoint)controlPoint
{
    UIBezierPath *quadPath = [UIBezierPath bezierPath];
    [quadPath moveToPoint:startPoint];
    [quadPath addQuadCurveToPoint:toPoint controlPoint:controlPoint];
    return quadPath;
}

- (void)showMenu:(BOOL)show
        animated:(BOOL)animated
{
    CGFloat positionPathControlPointY = kBottomYPosition / 2;
    CGFloat verticalOffsetInRotatedState = 0.75f;
    
    CGFloat topEndValue = show ? -M_PI - M_PI_4*13/16 : M_PI + M_PI_4*13/16;
    CGFloat topPositionEndPointY = show ? kTopYPosition : kBottomYPosition + verticalOffsetInRotatedState;
    CGPoint topPositionEndPoint = CGPointMake(kWidth/2, topPositionEndPointY);
    
    NSArray *topRotationValues = [self rotationValuesFromTransform:_topShapeLayer.transform endValue:topEndValue];
    UIBezierPath *topRotationPath = [self quadBezierCurveFromPoint:_topShapeLayer.position toPoint:topPositionEndPoint controlPoint:CGPointMake(kWidth, positionPathControlPointY)];
    
    CGFloat middleEndValue = show ? -M_PI : M_PI;
    
    NSArray *middeRotationValues = [self rotationValuesFromTransform:_middleShapeLayer.transform endValue:middleEndValue];
    
    CGFloat bottomEndValue = show ? -M_PI_2 - M_PI_4*19/16 : M_PI_2 + M_PI_4*19/16;
    CGFloat bottomPositionEndPointY = show ? kBottomYPosition : kTopYPosition - verticalOffsetInRotatedState;
    CGPoint bottomPositionEndPoint = CGPointMake(kWidth/2, bottomPositionEndPointY);
    
    NSArray *bottomRotationValues = [self rotationValuesFromTransform:_bottomShapeLayer.transform endValue:bottomEndValue];
    UIBezierPath *bottomRotationPath = [self quadBezierCurveFromPoint:_bottomShapeLayer.position toPoint:bottomPositionEndPoint controlPoint:CGPointMake(0, positionPathControlPointY)];
    
    if (animated) {
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.4];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0]];
                                                                             
        CAKeyframeAnimation *topRotation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        topRotation.values = topRotationValues;
        topRotation.calculationMode = kCAAnimationCubic;
        topRotation.keyTimes = @[@0.0, @0.33, @0.73, @1.0];
        [_topShapeLayer setValue:[topRotationValues lastObject] forKey:@"transform"];
        [_topShapeLayer addAnimation:topRotation forKey:@"transform"];
        
        CAKeyframeAnimation *topPosition = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        topPosition.path = topRotationPath.CGPath;
        [_topShapeLayer setValue:[NSValue valueWithCGPoint:topPositionEndPoint] forKey:@"position"];
        [_topShapeLayer addAnimation:topPosition forKey:@"position"];
        
        CAKeyframeAnimation *middleRotation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        middleRotation.values = middeRotationValues;
        [_middleShapeLayer setValue:[middeRotationValues lastObject] forKey:@"transform"];
        [_middleShapeLayer addAnimation:middleRotation forKey:@"transform"];
        
        CAKeyframeAnimation *bottomRotation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        bottomRotation.values = bottomRotationValues;
        bottomRotation.calculationMode = kCAAnimationCubic;
        bottomRotation.keyTimes = @[@0.0, @0.33, @0.73, @1.0];
        [_bottomShapeLayer setValue:[bottomRotationValues lastObject] forKey:@"transform"];
        [_bottomShapeLayer addAnimation:bottomRotation forKey:@"transform"];
        
        CAKeyframeAnimation *bottomPosition = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        bottomPosition.path = bottomRotationPath.CGPath;
        [_bottomShapeLayer setValue:[NSValue valueWithCGPoint:bottomPositionEndPoint] forKey:@"position"];
        [_bottomShapeLayer addAnimation:bottomPosition forKey:@"position"];
        
        [CATransaction commit];
        
    } else {
        
        [_topShapeLayer setValue:[topRotationValues lastObject] forKey:@"transform"];
        [_topShapeLayer setValue:[NSValue valueWithCGPoint:topPositionEndPoint] forKey:@"position"];
        [_middleShapeLayer setValue:[middeRotationValues lastObject] forKey:@"transform"];
        [_bottomShapeLayer setValue:[bottomRotationValues lastObject] forKey:@"transform"];
        [_bottomShapeLayer setValue:[NSValue valueWithCGPoint:bottomPositionEndPoint] forKey:@"position"];
    }
}

@end
