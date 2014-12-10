//
//  MYCustomNavigationController.m
//  AKNavTab
//
//  Created by Terence Adrien Zama on 12/10/14.
//  Copyright (c) 2014 Terence Adrien Zama. All rights reserved.
//

#import "MYCustomNavigationController.h"

@implementation MYCustomNavigationController
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.titles=@[@"vc0",@"vc1",@"vc2",@"vc3"];
    self.viewControllersId=@[@"vc0",@"vc1",@"vc2",@"vc3"];
}

@end
