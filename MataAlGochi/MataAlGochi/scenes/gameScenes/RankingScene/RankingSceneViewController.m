//
//  RankingSceneViewController.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/1/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "RankingSceneViewController.h"
#import "GochiTableViewCell.h"
#import "GochiInMapSceneViewController.h"
#import "NetworkRequestsHelper.h"
#import "CoreDataHelper.h"

@interface RankingSceneViewController ()

//Properties
@property(nonatomic, strong) NSArray* gochisList;

//IBOutlets
@property (strong, nonatomic) IBOutlet UITableView *tblGochisTable;

@end

@implementation RankingSceneViewController

- (instancetype) initWithGochisList:(NSArray*) gochisList
{
    self = [super init];
    self.gochisList = gochisList;
    if([self.gochisList count] > 0)
    {
        [self performSelector:@selector(getRankingFromServer) withObject:nil afterDelay:5.0f];
    }
    else
    {
        [self getRankingFromServer];
    }
    return self;
}

- (void) getRankingFromServer
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLoadGochisRaking:) name:NWNOTIFICATION_GOCHIS_LIST_LODED_SUCCESS object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFailLoadingGochisRanking:) name:NWNOTIFICATION_GOCHIS_LIST_LODED_FAILURE object:nil];
    
    [[NetworkRequestsHelper sharedInstance] retreiveAllGochisFromServer];
}

- (void) didLoadGochisRaking:(NSNotification*) sender
{
    //First of all :)
    [self removeGochisListObservation];
    self.gochisList = [sender object];
    [self updateTable];
    //save this on storage:
    [[CoreDataHelper sharedInstance] deleteGochi:nil];//This delete every gochi on disk
    [[CoreDataHelper sharedInstance] setGochisByArray:self.gochisList];
}

- (void) didFailLoadingGochisRanking:(NSNotification*) sender
{
    [self removeGochisListObservation];
    NSLog(@"Failed loading gochis ranking");
}

- (void) removeGochisListObservation
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [self removeGochisListObservation];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Gochis list";
    
    //Set table info:
    self.tblGochisTable.delegate = self;
    self.tblGochisTable.dataSource = self;
    [self.tblGochisTable registerNib:[UINib nibWithNibName:GochiTableViewCellNibString bundle:[NSBundle mainBundle]] forCellReuseIdentifier:GochiTableViewCellReuseStringIdentifier];
    [self.tblGochisTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Utilities

- (void) updateTable
{
    self.gochisList = [self.gochisList sortedArrayUsingComparator:^(id a, id b)
                       {
                           return [b compare:a];
                       }];
    [self.tblGochisTable reloadData];
}


#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.gochisList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GochiTableViewCell* gochiCell = [tableView dequeueReusableCellWithIdentifier:GochiTableViewCellReuseStringIdentifier];
    
    if(gochiCell == nil)
    {
        gochiCell = [[GochiTableViewCell alloc] init];
    }
    
    //Fill cell data
    Gochi* gochi = [self.gochisList objectAtIndex:indexPath.row];    
    gochiCell.delegate = self;
    [gochiCell fillWithGochi:gochi shouldBright:[gochi isOwnGochi]];
    
    return gochiCell;
}


#pragma mark - GochiTableViewCellDelegate


- (void) didSelectGochiInMap:(Gochi*) gochi
{
    GochiInMapSceneViewController* gochiInMap = [[GochiInMapSceneViewController alloc] initWithNibName:@"GochiInMapSceneViewController" bundle:nil];
    
    [gochiInMap.navigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    gochiInMap.gochi = gochi;
    [self.navigationController pushViewController:gochiInMap animated:YES];
}


@end
