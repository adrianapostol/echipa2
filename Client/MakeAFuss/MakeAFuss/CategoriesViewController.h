//
//  CategoriesViewController.h
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostCategory.h"

@class CategoriesViewController;

@protocol CategoriesViewControllerDelegate <NSObject>

- (void)categoriesViewController:(CategoriesViewController *)categoriesViewController didSelectCategory:(PostCategory *)category;

@end



@interface CategoriesViewController : UITableViewController

@property (nonatomic, weak) id<CategoriesViewControllerDelegate> delegate;

@end
