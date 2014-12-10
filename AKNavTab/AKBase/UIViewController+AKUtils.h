//
//  UIViewController+AKUtils.h
//  AKNavTab
//
//  Created by Terence Adrien Zama on 11/17/14.
//  Copyright (c) 2014 Terence Adrien Zama. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AKUtils)
#pragma mark - Storyboard Utils
-(UIViewController *) vcWithStoryboardId:(NSString *)storyboardId;
-(void) pushWithVcId:(NSString *)viewControllerId;
@end
