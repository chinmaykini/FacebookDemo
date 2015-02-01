//
//  MainViewController.m
//  FacebookDemo
//
//  Created by Timothy Lee on 10/22/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

#import "MainViewController.h"
#import "FeedNodeCell.h"
#import <FacebookSDK/FacebookSDK.h>
#import "SettingsViewController.h"

@interface MainViewController ()
@property (nonatomic, strong) NSArray *feedData;

- (void)reload;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self reload];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Configure the left button
    UIImage *leftButtonImage = [[UIImage imageNamed:@"leftButton"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:leftButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(onLeftButton)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
//    // Configure the right button
//    UIImage *rightButtonImage = [[UIImage imageNamed:@"rightButton"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:rightButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(onRightButton)];
//    self.navigationItem.rightBarButtonItem = rightButton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onRightButton)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.tableView.dataSource   = self;
    self.tableView.delegate     = self;
    
    self.tableView.rowHeight    = UITableViewAutomaticDimension;
    self.title                  = @"Facebook Feed";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FeedNodeCell" bundle:nil] forCellReuseIdentifier:@"FeedNodeCell"];
}


- (void) onLeftButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
    

}

- (void) onRightButton {
    
    SettingsViewController *vc = [[SettingsViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    nvc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:nvc animated:YES completion:nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FeedNodeCell *cell             = [tableView dequeueReusableCellWithIdentifier:@"FeedNodeCell"];
    NSDictionary *feedNodeData     = self.feedData[indexPath.row];
    
    cell.nameField.text = [NSString stringWithFormat:@"%@", feedNodeData[@"name"]];
    cell.typeField.text = [NSString stringWithFormat:@"%@", feedNodeData[@"type"]];
    cell.statusTypeField.text = [NSString stringWithFormat:@"%@", feedNodeData[@"status_type"]];
    
//    cell.feedNodeDictionary        = feedNodeData;
//    [self.navigationController pushViewController: animated:<#(BOOL)#>
    return cell;
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.feedData.count;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Private methods

- (void)reload {
    [FBRequestConnection startWithGraphPath:@"/me/home"
                                 parameters:nil
                                 HTTPMethod:@"GET"
                          completionHandler:^(
                                              FBRequestConnection *connection,
                                              id result,
                                              NSError *error
                                              ) {
                              /* handle the result */
//                              NSLog(@"result: %@", result);
//                              NSDictionary *responseDictionary    = [NSJSONSerialization JSONObjectWithData:result options:0 error:nil];
                              self.feedData                         = result[@"data"];
                              NSLog(@"feedData: %@", self.feedData);
                              [self.tableView reloadData];
                          }];
}

@end
