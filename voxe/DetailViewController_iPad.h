//
//  DetailViewController_iPad.h
//  voxe
//
//  Created by Antoine Maillard on 11/12/11.
//  Copyright 2011 ENST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController_iPad : UIViewController <UIWebViewDelegate> {
    IBOutlet UIWebView *webView;
    IBOutlet UIActivityIndicatorView *indicatorView;
    UIViewController *initialisator;
}


- (IBAction)close:(id)sender;
- (void) showWithParentInitialisator:(UIViewController*)anInitialisator forRequest:(NSURLRequest*)urlRequest;

@end
