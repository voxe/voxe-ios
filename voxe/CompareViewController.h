//
//  CompareViewController.h
//  voxe
//
//  Created by Antoine Maillard on 04/12/11.
//  Copyright 2011 ENST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "RootViewController.h"
@class RootViewController;

@interface CompareViewController : UIViewController <UIWebViewDelegate>{
    DetailViewController *detailViewController;
    RootViewController *rootViewController;
    IBOutlet UIWebView *compareWebView;
    IBOutlet UIActivityIndicatorView *indicatorView;
}
- (id)initWithRootViewController:(RootViewController*)_rootViewController;
- (void)loadComparisonPage:(NSString*)comparisonUrl;

@end
