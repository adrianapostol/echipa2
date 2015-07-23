//
//  CreateStoryViewController.m
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import "CreateStoryViewController.h"
#import "CategoriesViewController.h"
#import "AppSession.h"

@interface CreateStoryViewController () <CategoriesViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *selectCategoryButton;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UISwitch *anonymousSwitch;

@property (nonatomic, strong) PostCategory *category;

@end

@implementation CreateStoryViewController


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
        id rootViewController = [[segue.destinationViewController viewControllers] firstObject];
        if ([rootViewController isKindOfClass:[CategoriesViewController class]]) {
            [rootViewController setDelegate:self];
        }
    }
}


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

#pragma mark - CategoriesViewControllerDelegate

- (void)categoriesViewController:(CategoriesViewController *)categoriesViewController didSelectCategory:(PostCategory *)category {
    self.category = category;
    [self.selectCategoryButton setTitle:category.categoryName forState:UIControlStateNormal];
}

#pragma mark - Private

- (void)createStory:(void (^)(BOOL successful)) completion {
    [[AppSession defaultSession] addPostWithTitle:self.titleField.text content:self.contentTextView.text categoryId:[self.category.categoryID integerValue] anonymous:self.anonymousSwitch.isOn completion:^(BOOL success) {
        if (completion) completion(success);
    }];
}

@end
