//
//  UIViewController+AKUtils.m
//  AKNavTab
//
//  Created by Terence Adrien Zama on 11/17/14.
//  Copyright (c) 2014 Terence Adrien Zama. All rights reserved.
//

#import "UIViewController+AKUtils.h"
#pragma mark - config
static NSString *const AKStoryboard = @"Main";

@implementation UIViewController (AKUtils)

#pragma mark - Storyboard Utils
-(UIViewController *) vcWithStoryboardId:(NSString *)storyboardId{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:AKStoryboard bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:storyboardId];
    return vc;
}
-(void) pushWithVcId:(NSString *)viewControllerId{
    UIViewController *vc = [self vcWithStoryboardId:viewControllerId];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
