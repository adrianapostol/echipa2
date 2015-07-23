//
//  DashboardViewController.m
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import "DashboardViewController.h"
#import "StoriesTableViewController.h"
#import "CategoriesViewController.h"

@interface DashboardViewController () <UISearchBarDelegate, CategoriesViewControllerDelegate>

@property (nonatomic, weak) StoriesTableViewController *storiesController;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *storyChannelSegmentedControl;

@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.storiesController = self.childViewControllers.firstObject;
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"Search for a post";
    self.navigationItem.titleView = self.searchBar;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.storiesController updateStoriesForQuery:searchText];
}

#pragma mark - CategoriesViewControllerDelegate

- (void)categoriesViewController:(CategoriesViewController *)categoriesViewController didSelectCategory:(PostCategory *)category {
    self.storiesController.postCategory = category;
}

#pragma mark - IBActions

- (IBAction)selectedTabChanged:(id)sender {
    [self.storiesController updateStoriesForChannelType:self.storyChannelSegmentedControl.selectedSegmentIndex];
}

#pragma mark - UIStoryBoardSegue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[CategoriesViewController class]]) {
        [segue.destinationViewController setDelegate:self];
    }
}

@end
