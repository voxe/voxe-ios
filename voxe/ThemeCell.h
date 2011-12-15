//
//  ThemeCell.h
//  voxe
//
//  Created by Antoine Maillard on 08/12/11.
//  Copyright 2011 ENST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface ThemeCell : UITableViewCell{
    
    IBOutlet UILabel *themeName;
    NSString *customIdentifier;
    NSDictionary *associatedTheme;
    
}

@property(retain, nonatomic) NSString *customIdentifier;
- (void)setAssociatedTheme:(NSDictionary*)aTheme;


@end
