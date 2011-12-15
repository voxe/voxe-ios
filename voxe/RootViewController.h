//
//  RootViewController.h
//  voxe
//
//  Created by Antoine Maillard on 04/12/11.
//  Copyright 2011 ENST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompareViewController.h"
#import "CandidatesViewController.h"
@class CandidatesViewController;
@class CompareViewController;

@interface RootViewController : UITableViewController{
    
    CompareViewController *compareViewController;
    CandidatesViewController *candidatesViewController;
    IBOutlet UIBarButtonItem *selectedCandidatesItem;
    NSDictionary *currentTheme;
    UINib *cellLoader;
    
}

-(IBAction)changeCandidates:(id)sender;
- (void) showCandidatesPopup;
- (void) loadComparisonWebPage;
- (void) candidateModalViewDidDismiss;

@property(readonly) UIBarButtonItem *selectedCandidatesItem; 

@end
