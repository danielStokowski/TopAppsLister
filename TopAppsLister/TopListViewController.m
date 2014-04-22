//
//  TopListViewController.m
//  TopAppsLister
//
//  Created by Daniel Stokowski on 22.04.2014.
//  Copyright (c) 2014 BLTest. All rights reserved.
//

#import "TopListViewController.h"
#import "FeedHandler.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "ApplicationCell.h"


static NSString *cellIdentifier = @"applicationCell";

@interface TopListViewController ()

@end

@implementation TopListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self disableEdgesForExtendedLayout];
    
    [self setupTableView];
    [self setupRefreshControl];
    [self setupTextSizeChangeNotification];
    
    [self fetchApps];
}

- (void)disableEdgesForExtendedLayout
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
    
- (void)setupTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:@"ApplicationCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
}
    
- (void)setupRefreshControl
{
    self.refreshControl = [[[UIRefreshControl alloc] init] autorelease];
    self.refreshControl.attributedTitle = [[[NSAttributedString alloc] initWithString:@"Pull to Refresh"] autorelease];
    [self.refreshControl addTarget:self action:@selector(fetchApps)
                  forControlEvents:UIControlEventValueChanged];
}
    
- (void)setupTextSizeChangeNotification
{
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(textSizeChanged:)
     name:UIContentSizeCategoryDidChangeNotification
     object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.applications count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ApplicationCell *cell = (ApplicationCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    NSDictionary *appDictionary = [self.applications objectAtIndex:indexPath.row];
    cell.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cell.titleLabel.text = [appDictionary valueForKeyPath:@"im:name.label"];
    
    cell.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    cell.positionLabel.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
    
    
    NSURL* imageUrl = [FeedHandler urlForSmallImageForApplicationWithDictionary:appDictionary];
    [self setImageWithUrl:imageUrl forCell:cell];
    
    return cell;
}
    
- (void)setImageWithUrl:(NSURL *)imageUrl forCell:(ApplicationCell *)cell
    {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:imageUrl];
        [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
        [cell.imageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            cell.IconImageView.image = image;
            [cell setNeedsLayout];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            NSLog(@"fail");
        }];
    }

#pragma mark - Fetching data
- (void)fetchApps{
    [self.refreshControl beginRefreshing];
    NSURL *url = [NSURL URLWithString:FEED_URL];
    NSData *results = [NSData dataWithContentsOfURL:url];
    NSError* error = nil;
    NSDictionary *resultsDictionary = [NSJSONSerialization JSONObjectWithData:results options:0 error:&error];
    if(!error){
        NSArray *applications = [resultsDictionary valueForKeyPath:ITUNES_APPLICATIONS_ARRAY];
        self.applications = applications;
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:error.localizedFailureReason
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    [self.refreshControl endRefreshing];
}

#pragma mark - font size change
- (void)textSizeChanged:(NSNotification *)notification {

    NSArray *paths = [self.tableView indexPathsForVisibleRows];
    
    for (NSIndexPath *path in paths) {
        [self.tableView reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
@end
