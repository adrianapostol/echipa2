//
//  CategoriesViewController.m
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import "CategoriesViewController.h"
#import "AppSession.h"

@interface CategoriesTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@interface CategoriesViewController ()

@property (nonatomic, strong) NSArray *categories;

@end



@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    [self loadCategories:^(NSArray *categories) {
        weakSelf.categories = categories;
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoriesTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Category Cell" forIndexPath:indexPath];
    cell.titleLabel.text = [self.categories[indexPath.row] categoryName];
    
    return cell;
}


#pragma mark - IBActions

- (IBAction)cancelButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonTapped:(id)sender {
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    if (selectedIndexPath && [self.delegate respondsToSelector:@selector(categoriesViewController:didSelectCategory:)]) {
        [self.delegate categoriesViewController:self didSelectCategory:self.categories[selectedIndexPath.row]];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private

- (void)loadCategories:(void (^)(NSArray *categories)) completion {
    [[AppSession defaultSession] fetchCategories:^(NSArray *categories) {
        completion(categories);
    }];
}

@end

@implementation CategoriesTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.accessoryType = selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

@end


