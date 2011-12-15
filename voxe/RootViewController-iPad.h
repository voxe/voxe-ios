//
//  RootViewController-iPad.h
//  voxe
//
//  Created by Antoine Maillard on 10/12/11.
//  Copyright 2011 ENST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CandidatesViewController_iPad.h"
#import "DetailViewController.h"
#import "SplitViewController.h"
@class CandidatesViewController_iPad;
@class SplitViewController;

@interface RootViewController_iPad : UIViewController{
    
    CandidatesViewController_iPad *candidatesViewController_iPad;
    SplitViewController *splitViewController;
    IBOutlet UIActivityIndicatorView *waitingIndicator;
    IBOutlet UILabel *waitingLabel;
}
- (void) showCandidatesPopup;
- (void) candidatesPopupValidated;
- (void) hideWaitingMessages;

@property(readonly) CandidatesViewController_iPad *candidatesViewController_iPad;

@end
