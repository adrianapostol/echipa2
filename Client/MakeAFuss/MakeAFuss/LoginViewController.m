//
//  LoginViewController.m
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import "LoginViewController.h"
#import "AppSession.h"

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
        if (successful) {
            [weakSelf showDashboard];
        } else {
            [weakSelf showError];
        }
        
    }];
}

#pragma mark - Private

- (void)updateLoginButtonState {
    BOOL loginEnabled = self.nameField.text.length > 0 && self.passwordField.text.length > 0;
    self.loginButton.enabled = loginEnabled;
}

- (void)login:( void (^) (BOOL successful))completion {
    [[AppSession defaultSession] loginUser:self.nameField.text password:self.passwordField.text completion:^(BOOL success) {
        if (completion) completion(success);
    }];
}

- (void)showDashboard {
    [self performSegueWithIdentifier:ShowDashboardSegueIdentifier sender:self];
}

- (void)showError {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Login Failed" message:@"The username or password may be incorrect. Please try again" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    [controller addAction:action];
    
    [self presentViewController:controller animated:YES completion:nil];
}

@end
