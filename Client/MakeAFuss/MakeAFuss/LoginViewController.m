//
//  LoginViewController.m
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import "LoginViewController.h"

static NSString * const ShowDashboardSegueIdentifier = @"ShowDashboard";

@interface LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateLoginButtonState];
}


#pragma mark - IBActions

- (IBAction)textFieldDidChangeText:(id)sender {
    [self updateLoginButtonState];
    
}

- (IBAction)loginButtonTapped:(id)sender {
    __weak typeof(self) weakSelf = self;
    [self login:^(BOOL successful) {
        [weakSelf showDashboard];
    }];
}

#pragma mark - Private

- (void)updateLoginButtonState {
    BOOL loginEnabled = self.nameField.text.length > 0 && self.passwordField.text.length > 0;
    self.loginButton.enabled = loginEnabled;
}

- (void)login:( void (^) (BOOL successful))completion {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completion) completion(YES);
    });
}

- (void)showDashboard {
    [self performSegueWithIdentifier:ShowDashboardSegueIdentifier sender:self];
}

@end
