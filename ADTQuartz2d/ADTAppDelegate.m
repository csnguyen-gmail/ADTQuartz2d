//
//  ADTAppDelegate.m
//  ADTQuartz2d
//
//  Created by csnguyen on 3/17/13.
//  Copyright (c) 2013 csnguyen. All rights reserved.
//

#import "ADTAppDelegate.h"

@implementation ADTAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(triggerUpdateBackground)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)triggerUpdateBackground{
    [self.customView setNeedsDisplay:YES];
}

- (IBAction)sliderMoved:(id)sender {
    [self.customView setNeedsDisplay:YES];
}

@end
