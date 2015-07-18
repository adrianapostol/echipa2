//
//  StoriesTableViewController.m
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import "StoriesTableViewController.h"
#import "Post.h"
#import "EDStarRating.h"
#import "StoryDetailViewController.h"
#import "AppSession.h"

@interface PostTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet EDStarRating *starRatingView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@end

static NSString * const ShowStoryDetail = @"ShowStoryDetail";

@interface StoriesTableViewController() <EDStarRatingProtocol>

@property (nonatomic, copy) NSArray *posts;

@end

@implementation StoriesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 80;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self loadPosts];
}

#pragma mark - Public

- (void)updateStoriesForChannelType:(StoryChannelType)channelType {
    [self loadPosts];
}

- (void)updateStoriesForQuery:(NSString *)query {
    [self loadPosts];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Post Cell" forIndexPath:indexPath];
    Post *post = self.posts[indexPath.row];
    cell.titleLabel.text = post.title;
    cell.categoryLabel.text = post.category;
    cell.nameLabel.text = post.user;
    cell.contentLabel.text = post.content;
    cell.starRatingView.rating = post.rating;
    cell.ratingLabel.text = [NSString stringWithFormat:@"%.1f", post.rating];
    [cell.starRatingView setNeedsDisplay];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:ShowStoryDetail sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIStoryboardSegue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[StoryDetailViewController class]])
        [segue.destinationViewController setPost:self.posts[self.tableView.indexPathForSelectedRow.row]];
}

- (void)loadPosts {
    __weak typeof(self) weakSelf = self;
    [[AppSession defaultSession] fetchPostsWithParams:nil completion:^(NSArray *posts) {
        weakSelf.posts = posts;
        [weakSelf.tableView reloadData];
    }];
}

@end

@implementation PostTableViewCell


- (void)awakeFromNib {
    self.starRatingView.starImage = [UIImage imageNamed:@"star"];
    self.starRatingView.starHighlightedImage = [UIImage imageNamed:@"starhighlighted"];
    self.starRatingView.tintColor = [UIColor blueColor];
    self.starRatingView.maxRating = 5.0;
    self.starRatingView.horizontalMargin = 8;
    self.starRatingView.displayMode = EDStarRatingDisplayAccurate;
    self.starRatingView.editable = NO;
}

@end
