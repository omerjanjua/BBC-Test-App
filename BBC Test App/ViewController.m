//
//  ViewController.m
//  BBC Test App
//
//  Created by Omer Janjua on 18/01/2015.
//  Copyright (c) 2015 Omer Janjua. All rights reserved.
//

#import "ViewController.h"
#import "FruitData.h"
#import "FruitDetailedViewController.h"
#import "AFHTTPRequestOperationManager.h"

//declaration of the base URL
static NSString *baseURL = @"https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/data.json";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Setup
-(void)setupView
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:baseURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSMutableArray *tempArray = [NSMutableArray new];
        
        for (int i = 0; i < [[responseObject objectForKey:@"fruit"] count]; i++)
        {
            FruitData *fruitData = [FruitData new];
            fruitData.type = [[[responseObject objectForKey:@"fruit"] objectAtIndex:i] objectForKey:@"type"];
            fruitData.price = [[[responseObject objectForKey:@"fruit"] objectAtIndex:i] objectForKey:@"price"];
            fruitData.weight = [[[responseObject objectForKey:@"fruit"] objectAtIndex:i] objectForKey:@"weight"];
            [tempArray addObject:fruitData];
        }
        _data = [[NSMutableArray alloc] initWithArray:tempArray];
        [self.tableView reloadData];
        
    }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey] message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

#pragma mark - UITableView Datasource And Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Create cell (based on prototype)
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FruitCell" forIndexPath:indexPath];
    
    //Configure the cell
    FruitData *fruitData = _data[indexPath.row];
    cell.textLabel.text = fruitData.type;    
    return cell;
}

#pragma mark - View Controller Management
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"fruitSegue"]) {
        FruitDetailedViewController *controller = (FruitDetailedViewController *) segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        FruitData *fruitData = _data[indexPath.row];
        
        controller.price = fruitData.price;
        controller.weight= fruitData.weight;
        
    }
}

@end
