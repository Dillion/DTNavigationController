//
//  AppDelegate.m
//  navigationControllerDemo
//
//  Created by Dillion on 1/15/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//

#import "AppDelegate.h"
#import "COSTouchVisualizerWindow.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
#ifdef DEBUG
    if ([[[NSProcessInfo processInfo] environment] objectForKey:@"DebugCALayerAnimationSpeed"]) {
        float animationSpeed = [[[[NSProcessInfo processInfo] environment] objectForKey:@"DebugCALayerAnimationSpeed"] floatValue];
        [(CALayer *)[[[[UIApplication sharedApplication] windows] objectAtIndex:0] layer] setSpeed:animationSpeed];
    }
#endif
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (COSTouchVisualizerWindow *)window
{
    static COSTouchVisualizerWindow *customWindow = nil;
    if (!customWindow) {
        customWindow = [[COSTouchVisualizerWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [customWindow setFillColor:[UIColor whiteColor]];
        [customWindow setStrokeColor:[UIColor grayColor]];
        [customWindow setTouchAlpha:0.4];
        
        [customWindow setRippleFillColor:[UIColor whiteColor]];
        [customWindow setRippleStrokeColor:[UIColor grayColor]];
        [customWindow setRippleAlpha:0.1];
        [customWindow setTouchVisualizerWindowDelegate:self];
    }
    return customWindow;
}

- (BOOL)touchVisualizerWindowShouldAlwaysShowFingertip:(COSTouchVisualizerWindow *)window
{
    return YES;  // Return YES to make the fingertip always display even if there's no any mirrored screen.
    // Return NO or don't implement this method if you want to keep the fingertip display only when
    // the device is connected to a mirrored screen.
}

@end
