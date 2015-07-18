//
//  LLKeyboardView.m
//  Lulu
//
//  Created by Andrei Balasanu on 1/16/15.
//  Copyright (c) 2015 Luluvise. All rights reserved.
//

#import "LLKeyboardView.h"

@interface LLKeyboardView ()

@property(nonatomic, strong) NSLayoutConstraint *heightConstraint;

@end

@implementation LLKeyboardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self customInit];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)customInit {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    self.heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:0];
    [self addConstraint:self.heightConstraint];
    
}

#pragma mark - NSNotifications

- (void)keyboardWillShow:(NSNotification *)notification {
    [self changeHeightAccordingToKeyboardNotification:notification];
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [self changeHeightAccordingToKeyboardNotification:notification];
}

- (void)changeHeightAccordingToKeyboardNotification:(NSNotification *)notification {
    CGRect keyboardEndFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardEndFrame = [self.superview convertRect:keyboardEndFrame fromView:nil];
    UIViewAnimationCurve animationCurve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    UIViewAnimationOptions animationOptions = (animationCurve << 16) | UIViewAnimationOptionBeginFromCurrentState;
    NSTimeInterval animationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:animationDuration delay:0 options:animationOptions animations:^{
        CGFloat height = CGRectGetMaxY(self.superview.frame) - CGRectGetMinY(keyboardEndFrame);
        height = MAX(height, 0); // In some cases on IOS 7 height is negative
        weakSelf.heightConstraint.constant = height;
        [weakSelf.superview layoutIfNeeded];
    } completion:nil];
    
}

@end
