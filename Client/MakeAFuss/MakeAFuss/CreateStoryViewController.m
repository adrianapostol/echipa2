//
//  CreateStoryViewController.m
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import "CreateStoryViewController.h"

@interface CreateStoryViewController ()

@end

@implementation CreateStoryViewController


#pragma mark - IBActions


- (IBAction)cancelButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonTapped:(id)sender {
    if (self.inputValuesAreValid) {
        [self createStory:^(BOOL successful) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}

- (BOOL)inputValuesAreValid {
    return YES;
}

#pragma mark - Private

- (void)createStory:(void (^)(BOOL successful)) completion {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completion) completion(YES);
    });
}

@end
