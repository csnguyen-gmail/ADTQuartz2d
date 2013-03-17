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
    }
    // draw to main context
    // draw background
    HARD_WORK
    CGFloat red =  (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGColorRef backgroundColor = CGColorCreateGenericRGB(red, green, blue, 1);
    CGContextSetFillColorWithColor(mainContext, backgroundColor);
    CGColorRelease(backgroundColor);
    CGContextFillRect (mainContext, trackingArea.rect);
    // draw foreground
    CGContextSetRGBFillColor (mainContext, 0, 0, 1, 1);
    CGContextFillRect (mainContext, NSMakeRect(currentPoint.x - HALF_WIDTH, currentPoint.y - HALF_WIDTH, HALF_WIDTH * 2, HALF_WIDTH * 2));
}
#pragma - Event hadling
- (void)mouseMoved:(NSEvent *)theEvent {
    currentPoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    [self setNeedsDisplay:YES];
    
}
@end
