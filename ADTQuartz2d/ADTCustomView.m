//
//  ADTCustomView.m
//  ADTQuartz2d
//
//  Created by csnguyen on 3/17/13.
//  Copyright (c) 2013 csnguyen. All rights reserved.
//

#import "ADTCustomView.h"

#define HARD_WORK for (int i = 0; i < 500; i++) NSLog(@"HARD WORK");
#define HALF_WIDTH 20

@implementation ADTCustomView{
    CGLayerRef backgroundLayer;
    CGLayerRef foregroundLayer;
    NSPoint currentPoint;
    NSTrackingArea *trackingArea;
}
#pragma - Initial, De-initial
- (void)awakeFromNib{

}
-(void)dealloc{
    if (backgroundLayer != NULL) {
        CGLayerRelease(backgroundLayer);
    }
    if (foregroundLayer != NULL) {
        CGLayerRelease(foregroundLayer);
    }
}
#pragma - Draw function
- (void)drawRect:(NSRect)dirtyRect{
    CGContextRef mainContext = [[NSGraphicsContext currentContext] graphicsPort];
    // in case view size change
    if (trackingArea == nil || !NSEqualRects(dirtyRect, trackingArea.rect)){
        // update new size
        [self removeTrackingArea:trackingArea];
        trackingArea = [[NSTrackingArea alloc] initWithRect:dirtyRect
                                                    options: ( NSTrackingMouseMoved | NSTrackingActiveInKeyWindow )
                                                      owner:self userInfo:nil];
        [self addTrackingArea:trackingArea];
        // re-create layers
        if (backgroundLayer != NULL) {
            CGLayerRelease(backgroundLayer);
        }
        backgroundLayer = CGLayerCreateWithContext(mainContext, dirtyRect.size, NULL);
        if (foregroundLayer != NULL) {
            CGLayerRelease(foregroundLayer);
        }
        foregroundLayer = CGLayerCreateWithContext(mainContext, dirtyRect.size, NULL);
        // re-draw layers
        [self drawBackground];
        [self drawForeground];
    }
    // draw to main context
    CGContextDrawLayerAtPoint (mainContext, CGPointZero, backgroundLayer);
    CGContextDrawLayerAtPoint (mainContext, CGPointZero, foregroundLayer);
}
- (void)drawForeground{
    CGContextRef context = CGLayerGetContext(foregroundLayer);
    if (context == NULL) {
        return;
    }
    // draw foreground
    CGContextClearRect(context, trackingArea.rect);
    CGContextSetRGBFillColor (context, 0, 0, 1, 1);
    CGContextFillRect (context, NSMakeRect(currentPoint.x - HALF_WIDTH, currentPoint.y - HALF_WIDTH, HALF_WIDTH * 2, HALF_WIDTH * 2));
}
- (void)drawBackground{
    HARD_WORK
    CGContextRef context = CGLayerGetContext(backgroundLayer);
    if (context == NULL) {
        return;
    }
    // draw background
    CGFloat red =  (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGColorRef backgroundColor = CGColorCreateGenericRGB(red, green, blue, 1);
    CGContextSetFillColorWithColor(context, backgroundColor);
    CGColorRelease(backgroundColor);
    CGContextFillRect (context, trackingArea.rect);
}

#pragma - Event hadling
- (void)mouseMoved:(NSEvent *)theEvent {
    NSPoint point = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    
    currentPoint = point;
    [self drawForeground];
    [self setNeedsDisplay:YES];
    
}
@end
