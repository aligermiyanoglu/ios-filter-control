//
//  SEFilterProgressView.m
//  SEFilterControl_Sample
//
//  Created by Ali Germiyanoglu on 28/02/2017.
//  Copyright © 2017 Shady Elyaski. All rights reserved.
//

#import "SEFilterProgressView.h"

@interface SEFilterProgressView ()

@property BOOL draw;

@end

@implementation SEFilterProgressView

- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    self.contentMode = UIViewContentModeLeft;
    self.draw = YES;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)redraw {
    self.draw = YES;
    [self setNeedsDisplay];
}

- (void)setColor:(UIColor *)color {
    _color = color;
    
    [self redraw];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    if (self.draw) {
        self.draw = NO;
        
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        // Drawing code
        CGColorRef shadowColor = [UIColor colorWithRed:0 green:0
                                                  blue:0 alpha:.9f].CGColor;
        
        
        //Fill Main Path
        
        CGContextSetFillColorWithColor(context, self.color.CGColor);
        
        CGContextFillRect(context, CGRectMake(LEFT_OFFSET, rect.size.height - KNOB_WIDTH, rect.size.width-RIGHT_OFFSET-LEFT_OFFSET, 10));
        
        CGContextSaveGState(context);
        
        //Draw Black Top Shadow
        
        CGContextSetShadowWithColor(context, CGSizeMake(0, 1.f), 2.f, shadowColor);
        
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0 green:0
                                                                   blue:0 alpha:.6f].CGColor);
        CGContextSetLineWidth(context, .5f);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, LEFT_OFFSET, rect.size.height - KNOB_WIDTH);
        CGContextAddLineToPoint(context, rect.size.width-RIGHT_OFFSET, rect.size.height - KNOB_WIDTH);
        CGContextStrokePath(context);
        
        CGContextRestoreGState(context);
        
        CGContextSaveGState(context);
        
        //Draw White Bottom Shadow
        
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:1 green:1
                                                                   blue:1 alpha:1.f].CGColor);
        CGContextSetLineWidth(context, .4f);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, LEFT_OFFSET, rect.size.height-25);
        CGContextAddLineToPoint(context, rect.size.width-RIGHT_OFFSET, rect.size.height-25);
        CGContextStrokePath(context);
        
        CGContextRestoreGState(context);
        
        
        CGPoint centerPoint;
        
        for (NSInteger i = 0; i < self.nodeCount; i++) {
            centerPoint = [self centerPointForIndex:i];
            
            //Draw Selection Circles
            
            CGContextSetFillColorWithColor(context, self.color.CGColor);
            
            
            CGContextFillEllipseInRect(context, CGRectMake(centerPoint.x-15, rect.size.height-42.5f, 25, 25));
            
            //Draw top Gradient
            
            CGFloat colors[12] = {0, 0, 0, 1,
                0, 0, 0, 0,
                0, 0, 0, 0};
            
            CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
            CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 3);
            
            CGContextSaveGState(context);
            CGContextAddEllipseInRect(context, CGRectMake(centerPoint.x-15, rect.size.height-42.5f, 25, 25));
            CGContextClip(context);
            CGContextDrawLinearGradient (context, gradient, CGPointMake(0, 0), CGPointMake(0,rect.size.height), 0);
            
            CGGradientRelease(gradient);
            CGColorSpaceRelease(baseSpace);
            
            CGContextRestoreGState(context);
            
            //Draw White Bottom Shadow
            
            CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:1 green:1
                                                                       blue:1 alpha:.4f].CGColor);
            CGContextSetLineWidth(context, .8f);
            CGContextAddArc(context,centerPoint.x-2.5,rect.size.height-30.5f,12.5f,24*M_PI/180,156*M_PI/180,0);
            CGContextDrawPath(context,kCGPathStroke);
            
            //Draw Black Top Shadow
            
            CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0 green:0
                                                                       blue:0 alpha:.2f].CGColor);
            
            CGContextAddArc(context,centerPoint.x-2.5,rect.size.height-30.5f,12.f,(i==self.nodeCount-1?28:-20)*M_PI/180,(i==0?-208:-160)*M_PI/180,1);
            CGContextSetLineWidth(context, 1.f);
            CGContextDrawPath(context,kCGPathStroke);
        }
    }
}

- (CGPoint)centerPointForIndex:(NSInteger)i {
    return CGPointMake((i/(float)(self.nodeCount-1)) * (CGRectGetWidth(self.frame)-RIGHT_OFFSET-LEFT_OFFSET) + LEFT_OFFSET,
                       CGRectGetHeight(self.frame) - KNOB_HEIGHT);
}

- (BOOL)isDrawn {
    return !self.draw;
}

@end
