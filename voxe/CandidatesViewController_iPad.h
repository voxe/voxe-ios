//
//  CandidatesViewController_iPad.h
//  voxe
//
//  Created by Antoine Maillard on 10/12/11.
//  Copyright 2011 ENST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "voxeAppDelegate.h"
#import "CandidateCell.h"

@interface CandidatesViewController_iPad : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    
    IBOutlet UINavigationItem *titleItem;
    NSMutableArray *selectedCandidates;
    IBOutlet UIBarButtonItem *compareButton;
    UINib *cellLoader;
    UIViewController *initialisator;
    
}
- (IBAction) validateCandidates:(id)sender;
- (NSString*) selectedCandidatesString;
- (void) showWithParentInitialisator:(UIViewController*)anInitialisator;

@property(readonly) NSMutableArray *selectedCandidates;

@end
