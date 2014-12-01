//
//  RankingSceneViewController.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/1/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "RankingSceneViewController.h"
#import "GochiTableViewCell.h"

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
    self.gochisList = [gochisList sortedArrayUsingComparator:^(id a, id b)
                       {
                           return [b compare:a];
                       }];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Gochis list";
    
    //Set table info:
    self.tblGochisTable.delegate = self;
    self.tblGochisTable.dataSource = self;
    [self.tblGochisTable registerNib:[UINib nibWithNibName:GochiTableViewCellNibString bundle:[NSBundle mainBundle]] forCellReuseIdentifier:GochiTableViewCellReuseStringIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
}


@end
