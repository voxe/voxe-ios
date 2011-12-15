//
//  DetailViewController.h
//  voxe
//
//  Created by Antoine Maillard on 04/12/11.
//  Copyright 2011 ENST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UIWebViewDelegate> {
    
    IBOutlet UIWebView *webview;
    IBOutlet UIActivityIndicatorView *indicatorView;
}


@property(readonly) UIWebView *webview;

@end
