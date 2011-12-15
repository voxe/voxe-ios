//
//  voxeAppDelegate.m
//  voxe
//
//  Created by Antoine Maillard on 04/12/11.
//  Copyright 2011 ENST. All rights reserved.
//

#import "voxeAppDelegate.h"
#import "RootViewController.h"


@implementation voxeAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize electionsData, electionName, electionThemes, electionCandidates, splitViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the navigation controller's view to the window and display.
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        self.window.rootViewController = waitingViewController;
    }else{
        //splitViewController = [[SplitViewController alloc] init];
        self.window.rootViewController = rootViewController_iPad;
    }
    
    
    
    
    [self.window makeKeyAndVisible];
    
    [self startDataFetch];
    return YES;
}

- (void)startDataFetch{
    NSURL *dataURL = [NSURL URLWithString:@"http://joinplato.herokuapp.com/api/v1/elections/4ed1cb0203ad190006000001"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:dataURL];
    [request setDelegate:self];
    [request startAsynchronous];


}

-(void) requestFinished: (ASIHTTPRequest *) request {
    

    NSString *theJSON = [request responseString];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    electionsData = [[parser objectWithString:theJSON error:nil] retain];
    electionName = [[[electionsData valueForKey:@"election"] valueForKey:@"name"] retain];
    electionThemes = [[[electionsData valueForKey:@"election"] valueForKey:@"themes"] retain];
    electionCandidates = [[[electionsData valueForKey:@"election"] valueForKey:@"candidates"] retain];
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
       
        [[[[self navigationController] viewControllers] objectAtIndex:0] setTitle:electionName];
        [(UITableView*)[[[[self navigationController] viewControllers] objectAtIndex:0] view] reloadData];
        self.window.rootViewController = self.navigationController;
        [(RootViewController*)[[[self navigationController] viewControllers] objectAtIndex:0] showCandidatesPopup];
        
    }else{
        [rootViewController_iPad hideWaitingMessages];
        [rootViewController_iPad showCandidatesPopup];
        
    }
    
    
}

-(void) requestFailed: (ASIHTTPRequest *) request {
    
    
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [super dealloc];
}

@end
