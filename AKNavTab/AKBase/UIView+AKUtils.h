//
//  UIView+AKUtils.h
//  AKNavTab
//
//  Created by Terence Adrien Zama on 11/12/14.
//  Copyright (c) 2014 Terence Adrien Zama. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AKUtils)
-(CGFloat) width;
-(void) setWidth:(CGFloat)width;

-(CGFloat) height;
-(void) setHeight:(CGFloat)height;

-(CGFloat) minX;
-(CGFloat) midX;
-(CGFloat) maxX;

-(CGFloat) minY;
-(CGFloat) midY;
-(CGFloat) maxY;

-(void) setMinX:(CGFloat)minX;
-(void) setMidX:(CGFloat)midX;
-(void) setMaxX:(CGFloat)maxX;
-(void) setMinY:(CGFloat)minY;
-(void) setMidY:(CGFloat)midY;
-(void) setMaxY:(CGFloat)maxY;

#pragma mark - Size
-(CGSize) size;
-(void) setSize:(CGSize) size;
#pragma mark - Point
-(CGPoint) point;
-(void) setPoint:(CGPoint) point;
@end
