//
//  Red_RememberAppDelegate.h
//  Red Remember
//
//  Created by Bill Reardon on 8/14/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Red_RememberViewController;

@interface Red_RememberAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Red_RememberViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Red_RememberViewController *viewController;

@end

