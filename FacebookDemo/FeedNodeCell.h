//
//  FeedNodeCell.h
//  FacebookDemo
//
//  Created by Chinmay Kini on 1/29/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedNodeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameField;
@property (weak, nonatomic) IBOutlet UILabel *typeField;
@property (weak, nonatomic) IBOutlet UILabel *statusTypeField;
@property (strong, nonatomic) NSDictionary *feedNodeDictionary;

@end
