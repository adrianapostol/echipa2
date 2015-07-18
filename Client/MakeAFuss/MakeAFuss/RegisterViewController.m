//
//  RegisterViewController.m
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import "RegisterViewController.h"
#import "AppSession.h"

static NSString * const ShowDashboardSegueIdentifier = @"ShowDashboard";

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateRegisterButtonState];
}

#pragma mark - IBActions

- (IBAction)textFieldDidChangeText:(id)sender {
    [self updateRegisterButtonState];

}

- (IBAction)registerButtonTapped:(id)sender {
    __weak typeof(self) weakSelf = self;
    [self registerUser:^(BOOL successful) {
        if (successful) {
            [weakSelf showDashboard];
        } else {
            [weakSelf showError];
        }
    }];
    
}

#pragma mark - Private

- (void)updateRegisterButtonState {
    BOOL hasValidLength = self.nameField.text.length > 0 && self.passwordField.text.length > 0;
    BOOL isValidPassword = [self.passwordField.text isEqualToString:self.confirmPasswordField.text];
    
    self.registerButton.enabled = hasValidLength && isValidPassword;
}

- (void)registerUser:( void (^) (BOOL successful))completion {
    [[AppSession defaultSession] registerUser:self.nameField.text password:self.passwordField.text completion:^(BOOL success) {
        if (completion) completion(success);
    }];
}

- (void)showDashboard {
    [self performSegueWithIdentifier:ShowDashboardSegueIdentifier sender:self];
}

- (void)showError {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Register Failed" message:@"We could not create an account. Please try again" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    [controller addAction:action];
    
    [self presentViewController:controller animated:YES completion:nil];
}

@end
