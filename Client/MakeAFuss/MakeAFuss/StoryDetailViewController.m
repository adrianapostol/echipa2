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

@interface StoryDetailViewController () <RatingViewDelegate>

@property (nonatomic, strong) RatingView *ratingView;

@end

@implementation StoryDetailViewController

- (void)viewDidLoad {
    self.automaticallyAdjustsScrollViewInsets = NO;
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

@end
