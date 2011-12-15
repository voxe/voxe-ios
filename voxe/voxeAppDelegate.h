//
//  voxeAppDelegate.h
//  voxe
//
//  Created by Antoine Maillard on 04/12/11.
//  Copyright 2011 ENST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "RootViewController-iPad.h"
@class RootViewController_iPad;


@interface voxeAppDelegate : NSObject <UIApplicationDelegate, ASIHTTPRequestDelegate>{
    
    NSDictionary *electionsData;
    NSString *electionName;
    NSArray *electionThemes;
    NSArray *electionCandidates;
    IBOutlet UIViewController *waitingViewController;
    IBOutlet RootViewController_iPad *rootViewController_iPad;
    IBOutlet UISplitViewController *splitViewController;
    
}


- (void)startDataFetch;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;
@property (readonly) NSDictionary *electionsData;
@property (readonly) NSString *electionName;
@property (readonly) NSArray *electionThemes;
@property (readonly) NSArray *electionCandidates;

@end
