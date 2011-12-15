//
//  CandidatesViewController.h
//  voxe
//
//  Created by Antoine Maillard on 04/12/11.
//  Copyright 2011 ENST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
@class RootViewController;

@interface CandidatesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    IBOutlet UINavigationBar *navigationBar;
    RootViewController *rootViewController;
    NSMutableArray *selectedCandidates;
    IBOutlet UIBarButtonItem *compareButton;
    UINib *cellLoader;
    
}
- (IBAction) validateCandidates:(id)sender;
- (NSString*) selectedCandidatesString;
- (id) initWithRootViewController:(RootViewController*)_rootViewController;

@property(readonly) NSMutableArray *selectedCandidates;

@end
