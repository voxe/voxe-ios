//
//  CompareViewController.m
//  voxe
//
//  Created by Antoine Maillard on 04/12/11.
//  Copyright 2011 ENST. All rights reserved.
//

#import "CompareViewController.h"

@implementation CompareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithRootViewController:(RootViewController*)_rootViewController{
    self = [super init];
    if (self) {
        rootViewController = _rootViewController;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    detailViewController = [[DetailViewController alloc] init];
    [self setToolbarItems:[rootViewController toolbarItems]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void) viewWillAppear:(BOOL)animated{
    [[self navigationController] setToolbarHidden:NO animated:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Change WebView

- (void)loadComparisonPage:(NSString*)comparisonUrl{
    [indicatorView startAnimating];
    [compareWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:comparisonUrl]]];
}

#pragma mark - WebView delegate

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    
    if([[[request URL] path] isEqualToString:@"/webviews/proposition"]){
        
        [[self navigationController] pushViewController:detailViewController animated:YES];
        
        [[detailViewController webview] loadRequest:request];
        
        return NO;
        
    }
    
    return YES;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [indicatorView stopAnimating];
}


@end
