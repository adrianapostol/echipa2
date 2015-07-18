//
//  StoryDetailViewController.m
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import "StoryDetailViewController.h"
#import "Post.h"
#import "RatingView.h"
#import "CommentsViewController.h"
#import "AppSession.h"

@interface StoryDetailViewController () <RatingViewDelegate>

@property (nonatomic, strong) RatingView *ratingView;
@property (nonatomic, weak) CommentsViewController *commentsViewController;

@end

@implementation StoryDetailViewController

- (void)viewDidLoad {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.commentsViewController = self.childViewControllers.firstObject;
    
    [self loadComments];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = self.post.title;
}

- (IBAction)rateButtonTapped:(id)sender {
    RatingView *ratingView = [RatingView viewFromNib];
    ratingView.frame = self.navigationController.view.bounds;
    self.ratingView = ratingView;
    self.ratingView.delegate = self;
    
    [self.navigationController.view addSubview:ratingView];
}

- (void)ratingView:(RatingView *)ratingView didSelectRating:(float)rating {
    [self.ratingView removeFromSuperview];
}

- (void)loadComments {
    __weak typeof(self) weakSelf = self;
    [[AppSession defaultSession] fetchCommentsForPost:self.post completion:^(NSArray *comments) {
        weakSelf.commentsViewController.comments = comments;
    }];
}

@end
