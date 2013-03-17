//
//  ADTAppDelegate.h
//  ADTQuartz2d
//
//  Created by csnguyen on 3/17/13.
//  Copyright (c) 2013 csnguyen. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ADTCustomView.h"

@interface ADTAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet ADTCustomView *customView;
- (IBAction)sliderMoved:(id)sender;
@end
