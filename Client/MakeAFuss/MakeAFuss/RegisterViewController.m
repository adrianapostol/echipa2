//
//  RegisterViewController.m
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import "RegisterViewController.h"

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
        [weakSelf showDashboard];
    }];
    
}

#pragma mark - Private

- (void)updateRegisterButtonState {
    BOOL hasValidLength = self.nameField.text.length > 0 && self.passwordField.text.length > 0;
    BOOL isValidPassword = [self.passwordField.text isEqualToString:self.confirmPasswordField.text];
    
    self.registerButton.enabled = hasValidLength && isValidPassword;
}

- (void)registerUser:( void (^) (BOOL successful))completion {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completion) completion(YES);
    });
}

- (void)showDashboard {
    [self performSegueWithIdentifier:ShowDashboardSegueIdentifier sender:self];
}

@end
