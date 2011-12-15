//
//  SplitViewController.h
//  voxe
//
//  Created by Antoine Maillard on 11/12/11.
//  Copyright 2011 ENST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CandidatesViewController_iPad.h"
#import "ThemeCell.h"
#import "DetailViewController_iPad.h"
@class CandidatesViewController_iPad;

@interface SplitViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate>{
    CandidatesViewController_iPad *candidatesViewController;
    UINib *cellLoader;
    NSDictionary *currentTheme;
    IBOutlet UINavigationItem *detailBar;
    IBOutlet UIWebView *detailWebView;
    IBOutlet UIActivityIndicatorView *indicatorView;
    IBOutlet UITableView *themeTableView;
    
    IBOutlet UIImageView *candidate1ImageView;
    IBOutlet UIImageView *candidate2ImageView;
    IBOutlet UIImageView *candidate3ImageView;
    NSArray *candidatesImageViews;
    
    DetailViewController_iPad *detailViewController;
    
}

- (id) initWithCandidatesViewController:(CandidatesViewController_iPad*)aCandidatesViewController;
- (void) loadComparisonWebPage;
- (void) loadCandidatesImageList;
- (IBAction) changeCandidates:(id)sender;

@end
