//
//  StoryDetailViewController.m
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import "CommentsViewController.h"
#import "Comment.h"
#import "Post.h"

@interface CommentTableViewCell:UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;

@end

@interface CommentsViewController ()

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.comments = [[self class] createComments];
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Comment Cell" forIndexPath:indexPath];
    
    Comment *comment = self.comments[indexPath.row];
    cell.commentLabel.text = comment.text;
    cell.userLabel.text = comment.user;
    
    return cell;
}

+ (NSArray *)createComments {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:20];
    
    for (int idx = 0; idx < 20; idx++) {
        [array addObject:[[Comment alloc] initWithID:@"ID" text:@"This is the best comment ever. You can't write one better." user:@"iCeq"]];
    }
    
    return array;
}
@end

@implementation CommentTableViewCell


@end
