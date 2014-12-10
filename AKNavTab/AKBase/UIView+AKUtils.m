//
//  UIView+AKUtils.m
//  AKNavTab
//
//  Created by Terence Adrien Zama on 11/12/14.
//  Copyright (c) 2014 Terence Adrien Zama. All rights reserved.
//

#import "UIView+AKUtils.h"

@implementation UIView (AKUtils)
//Getters
-(CGFloat) width{
    return  CGRectGetWidth(self.frame);
}
-(CGFloat) height{
    return CGRectGetHeight(self.frame);
}
#pragma mark  X
-(CGFloat) minX{
    return CGRectGetMinX(self.frame);
}
-(CGFloat) midX{
    return CGRectGetMidX(self.frame);
}
-(CGFloat) maxX{
    return CGRectGetMaxX(self.frame);
}
#pragma mark  Y
-(CGFloat) minY{
    return CGRectGetMinY(self.frame);
}
-(CGFloat) midY{
    return CGRectGetMidY(self.frame);
}
-(CGFloat) maxY{
    return CGRectGetMaxY(self.frame);
}
//Setters
-(void) setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width=width;
    self.frame = frame;
}
-(void) setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height=height;
    self.frame = frame;
}
-(void) setMinX:(CGFloat)minX{
    CGRect frame = self.frame;
    frame.origin.x=minX;
    self.frame = frame;
}
-(void) setMidX:(CGFloat)midX{
    CGRect frame = self.frame;
    frame.origin.x=midX-CGRectGetWidth(self.frame)/2;
    self.frame = frame;
}
-(void) setMaxX:(CGFloat)maxX{
    CGRect frame = self.frame;
    frame.origin.x=maxX-CGRectGetWidth(self.frame);
    self.frame = frame;
}
-(void) setMinY:(CGFloat)minY{
    CGRect frame = self.frame;
    frame.origin.y=minY;
    self.frame = frame;
}
-(void) setMidY:(CGFloat)midY{
    CGRect frame = self.frame;
    frame.origin.y=midY-CGRectGetHeight(self.frame)/2;
    self.frame = frame;
}
-(void) setMaxY:(CGFloat)maxY{
    CGRect frame = self.frame;
    frame.origin.y=maxY-CGRectGetHeight(self.frame);
    self.frame = frame;
}
#pragma mark - Size
-(CGSize) size{
    return  self.frame.size;
}
-(void) setSize:(CGSize) size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
#pragma mark - Point
-(CGPoint) point{
    return  self.frame.origin;
}
-(void) setPoint:(CGPoint) point{
    CGRect frame = self.frame;
    frame.origin = point;
    self.frame = frame;
}

@end
