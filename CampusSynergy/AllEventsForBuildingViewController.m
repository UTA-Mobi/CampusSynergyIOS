//
//  AllEventsForBuildingViewController.m
//  CampusSynergy
//
//  Created by feifan meng on 9/2/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import "AllEventsForBuildingViewController.h"

@interface AllEventsForBuildingViewController ()

@end

@implementation AllEventsForBuildingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.buildingEventsTable.dataSource = self;
    self.buildingEventsTable.delegate = self;
    
    NSString *buildNameText = [[NSString alloc]
                               initWithFormat:@"All Events for building: %@", [self buildingNameString]];
    
    self.buildingName.text = buildNameText;
    self.title = [self buildingNameString];
    
    //Create an NSArray with each event name
    NSError *error = nil;
    
    //NSJONReadingAllowFragments: Allows the deserialization of JSON data whose root top-level object is not an array or a dictionary
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:[self allEvents] options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
    //NSLog(@"JSON DICT: %@", [deserializedDictionary objectForKey:@"results"]);
    
    NSArray *myResults = [[NSArray alloc] initWithArray:[deserializedDictionary objectForKey:@"results"]];
    
    //NSLog(@"Array: %@", myResults);
    
    NSMutableArray *myEventsTitleArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *result in myResults){
        //NSLog(@"Event Title: %@", [result objectForKey:@"title"]);
        if([[result objectForKey:@"bldName"] isEqualToString:[self buildingNameString]] ){
            [myEventsTitleArray addObject: result];
        }
    }
    self.eventsArray = [[ NSArray alloc] initWithArray:myEventsTitleArray];
    
    if (self.eventsArray != nil && [self.eventsArray count] > 0){
        NSLog(@"Events Array Created");
    }
    //[self retrieveAllEventsForBuildingFromParse];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//This is pretty much how many tables cells should be generated
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"Generating %d Table cells", (int)[self.eventsArray count]);
    
    return [self.eventsArray count];
}

//Setings for a cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //This is the identifier for the table cells, it is in the attributes thing
    NSString *cellIdentifier = @"EventsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSString *eventString = [[self.eventsArray objectAtIndex:indexPath.row]
                             objectForKey:@"title"];
    
    NSString *subTitle = [[self.eventsArray objectAtIndex:indexPath.row]
                          objectForKey:@"bldName"];
    
    [cell.textLabel setText:eventString];
    [cell.detailTextLabel setText: subTitle];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}


//Call the parse API
-(void) retrieveAllEventsForBuildingFromParse{
    
    NSLog(@"myAppId: %@", [self myAppId]);
    NSLog(@"myRestId: %@", [self myRestId]);
    
    EventsData *buildingEvents = [[EventsData alloc] initWithAppId:[self myAppId] andRestID:[self myRestId]];
    
    NSData *responseData =
    [buildingEvents getEventsForBuilding:[self buildingNameString]];
    
    NSLog(@"ResponseData: %@", responseData);
    
    NSString *dataAsString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@ Building Events: %@",
          [self buildingNameString], dataAsString);
}

@end
