//
//  RatingView.h
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RatingView, EDStarRating;

@protocol RatingViewDelegate <NSObject>

- (void)ratingView:(RatingView *)ratingView didSelectRating:(float)rating;

@end

@interface RatingView : UIView

@property (weak, nonatomic) IBOutlet EDStarRating *starRatingView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@property (weak, nonatomic) id<RatingViewDelegate> delegate;

+ (instancetype)viewFromNib;

@end
