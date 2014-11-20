//
//  FeedSceneViewController.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/20/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "FeedSceneViewController.h"
#import "FoodTableViewCell.h"
#import "Food.h"

@interface FeedSceneViewController ()

#pragma mark - Properties
@property (strong, nonatomic) NSMutableArray* foodArray;

#pragma mark - IBOutlets
@property (strong, nonatomic) IBOutlet UITableView *tblFoodTable;

@end

@implementation FeedSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Select Food";
    [self loadFood];
    
    //set table info:
    self.tblFoodTable.delegate = self;
    self.tblFoodTable.dataSource = self;
    [self.tblFoodTable registerNib:[UINib nibWithNibName:FoodTableViewCellNibString bundle:[NSBundle mainBundle]] forCellReuseIdentifier:FoodTableViewCellReuseStringIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Fill info
-(void) loadFood
{
    self.foodArray = [[NSMutableArray alloc] initWithObjects:
                      [[Food alloc] initFood:FOOD_APPLE
                                 whichNameIs:@"Apple"
                              andDescription:@"A nice apple"],
                      
                      [[Food alloc] initFood:FOOD_BREAD
                                 whichNameIs:@"Bread"
                              andDescription:@"A piese of bread"],
                      
                      [[Food alloc] initFood:FOOD_BURGER
                                 whichNameIs:@"Burger"
                              andDescription:@"A huge burger"],
                      
                      [[Food alloc] initFood:FOOD_CAKE
                                 whichNameIs:@"Pie"
                              andDescription:@"A great cake"],
                      
                      [[Food alloc] initFood:FOOD_CAKE_TWO
                                 whichNameIs:@"Piese of Pie"
                              andDescription:@"Another cake"],
                      
                      [[Food alloc] initFood:FOOD_CHICKEN
                                 whichNameIs:@"Chicken"
                              andDescription:@"A little chicken"],
                      
                      [[Food alloc] initFood:FOOD_ICE_CREAM
                                 whichNameIs:@"Ice cream"
                              andDescription:@"An cold ice cream"],
                      
                      [[Food alloc] initFood:FOOD_LEMON_FISH
                                 whichNameIs:@"Fish"
                              andDescription:@"A wild Magicarp Appears"],
                      
                      [[Food alloc] initFood:FOOD_SAUSAGE
                                 whichNameIs:@"Sausage"
                              andDescription:@"Mr. Sausage"],
                      nil];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FoodTableViewCell* cell =[tableView dequeueReusableCellWithIdentifier:FoodTableViewCellReuseStringIdentifier];
    
    if(!cell)
    {
        cell = [[FoodTableViewCell alloc] init];
    }
    [cell setFood:[self.foodArray objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.foodArray count];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Food* food = [self.foodArray objectAtIndex:indexPath.row];
    [self.foodDelegate feedGochiWithFood:food];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
