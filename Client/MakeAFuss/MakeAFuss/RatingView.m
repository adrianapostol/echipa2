//
//  RatingView.m
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import "RatingView.h"
#import "EDStarRating.h"

@interface RatingView () <EDStarRatingProtocol>

@end

@implementation RatingView

+ (instancetype)viewFromNib {
   return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([RatingView class]) owner:nil options:nil].firstObject;
}

- (void)awakeFromNib {
    self.starRatingView.starImage = [UIImage imageNamed:@"star"];
    self.starRatingView.starHighlightedImage = [UIImage imageNamed:@"starhighlighted"];
    self.starRatingView.tintColor = [UIColor blueColor];
    self.starRatingView.maxRating = 5.0;
    self.starRatingView.horizontalMargin = 8;
    self.starRatingView.displayMode = EDStarRatingDisplayAccurate;
    self.starRatingView.editable = YES;
    self.starRatingView.delegate = self;
    
    [[self.subviews.firstObject layer] setCornerRadius:5];
}

- (IBAction)rateButtonTapped:(id)sender {
    [self.delegate ratingView:self didSelectRating:self.starRatingView.rating];
}

- (void)starsSelectionChanged:(EDStarRating *)control rating:(float)rating {
    self.ratingLabel.text = [NSString stringWithFormat:@"%.1f", rating];
}

@end
