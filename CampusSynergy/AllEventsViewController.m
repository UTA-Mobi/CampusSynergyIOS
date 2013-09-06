//
//  AllEventsViewController.m
//  CampusSynergy
//
//  Created by feifan meng on 8/30/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import "AllEventsViewController.h"

@interface AllEventsViewController ()

@end

@implementation AllEventsViewController

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
    
    //Event change this to dynamically retrieve all the events
    //from the parsed server
    
    NSLog(@"Creating the dataSource and the delegate for the view cells.");
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
   // NSLog(@"All Events JSON in AllEventsViewController: %@", [self allEventsAsJSON]);
    //Create an NSArray with each event name
    NSError *error = nil;
    
    //NSJONReadingAllowFragments: Allows the deserialization of JSON data whose root top-level object is not an array or a dictionary
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:[self allEventsAsJSON] options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
    //NSLog(@"JSON DICT: %@", [deserializedDictionary objectForKey:@"results"]);
    
    NSArray *myResults = [[NSArray alloc] initWithArray:[deserializedDictionary objectForKey:@"results"]];
    
    NSLog(@"Array: %@", myResults);
    
    NSMutableArray *myEventsTitleArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *result in myResults){
        //NSLog(@"Event Title: %@", [result objectForKey:@"title"]);
        //[myEventsTitleArray addObject: [result objectForKey:@"title"]];
        [myEventsTitleArray addObject: result];
    }
        
    self.eventsArray = [[NSArray alloc] initWithArray:myEventsTitleArray];
    
    if (self.eventsArray != nil && [self.eventsArray count] > 0){
        NSLog(@"Events Array Created");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//This is pretty much how many tables cells should be generated
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"Generating %d Table cells", (int)[self.eventsArray count]);
    
    //return [self.eventsArray count];
    return [self.parseEventObjects count];
}

//Setings for a cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //This is the identifier for the table cells, it is in the attributes thing
    NSString *cellIdentifier = @"EventsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    /*
    NSString *eventString =
    [[self.eventsArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    NSString *subLabel =
    [[self.eventsArray objectAtIndex:indexPath.row] objectForKey:@"bldName"];
    */
    
    //new parse event API
    NSLog(@"parse event api.");
    NSString *myEventString =
    [[self.parseEventObjects objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    NSString *mySubLabel =
    [[self.parseEventObjects objectAtIndex:indexPath.row] objectForKey:@"bldName"];
    
    
    [cell.textLabel setText:myEventString];
    [cell.detailTextLabel setText: mySubLabel];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EventDetailsViewController *eventDetailsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"EventDetailVC"];
    
    eventDetailsVC.navigationItem.hidesBackButton = NO;
    
    //Set the fields for the eventdetails object
    /*
    NSString *eventsTitle = [[self.eventsArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    eventDetailsVC.eventTitleText = eventsTitle;
    NSString *eventDescript = [[self.eventsArray objectAtIndex:indexPath.row] objectForKey:@"longDescription"];
    eventDetailsVC.eventDescriptionText = eventDescript;
    NSString *roomString = [[self.eventsArray objectAtIndex:indexPath.row] objectForKey:@"room"];
    eventDetailsVC.eventRoomText = roomString;
    NSString *buildingString = [[self.eventsArray objectAtIndex:indexPath.row]
                                objectForKey:@"bldName"];
    eventDetailsVC.eventBuildingText = buildingString;
    
    eventDetailsVC.publisherText = [self username];
    
    NSString *iso_date = [[[self.eventsArray objectAtIndex:indexPath.row]
                           objectForKey:@"date"] objectForKey:@"iso"];
    
    NSDateFormatter *rawDateFormatter = [ [NSDateFormatter alloc] init];
    [rawDateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ"];
    NSDate *myRawDate = [rawDateFormatter dateFromString:iso_date];
    NSLog(@"Raw Date: %@", myRawDate.description);
    
    [rawDateFormatter setDateFormat:@"hh:mm a"];
    NSString *myTime = [rawDateFormatter stringFromDate:myRawDate];
    NSLog(@"myTime: %@", myTime);
    
    [rawDateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *myDate = [rawDateFormatter stringFromDate:myRawDate];
    NSLog(@"myDate: %@", myDate);
    
    NSString *duration = [[self.eventsArray objectAtIndex:indexPath.row] objectForKey:@"duration"];
    NSString *startTimeText = [[NSString alloc] initWithFormat:@"This event starts at %@ %@ and it takes %@ hours to finish", myTime, myDate, duration];
    eventDetailsVC.startTimeDescriptionText = startTimeText;
    */
    
    //new parse API
    NSString *myEventsTitle
    = [[self.parseEventObjects objectAtIndex:indexPath.row] objectForKey:@"title"];
    eventDetailsVC.eventTitleText = myEventsTitle;
    
    NSString *myEventDescription = [[self.parseEventObjects objectAtIndex:indexPath.row] objectForKey:@"longDescription"];
    eventDetailsVC.eventDescriptionText = myEventDescription;
    
    NSString *myRoomString = [[self.parseEventObjects objectAtIndex:indexPath.row] objectForKey:@"room"];
    eventDetailsVC.eventRoomText = myRoomString;
    
    NSString *myBuildingString = [[self.parseEventObjects objectAtIndex:indexPath.row] objectForKey:@"bldName"];
    eventDetailsVC.eventBuildingText = myBuildingString;
    
    eventDetailsVC.publisherText = [self username];

    NSString *myDuration = [[self.parseEventObjects objectAtIndex:indexPath.row] objectForKey:@"duration"];
    
    NSDate *parseDate = [[self.parseEventObjects objectAtIndex:indexPath.row]
                          objectForKey:@"date"];
    
    NSLog(@"parseDate: %@", parseDate);
    NSLog(@"parseDate description: %@", parseDate.description);
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"MM/dd/yyyy"];
    
    NSString *myParseTime = [timeFormatter stringFromDate:parseDate];
    
    [timeFormatter setDateFormat:@"hh:mm a"];
    NSString *myParseDate = [timeFormatter stringFromDate:parseDate];
    
    NSString *myStartTimeText = [[NSString alloc] initWithFormat:@"This event starts at %@ %@ and it takes %@ hours to finish", myParseTime, myParseDate, myDuration];
    eventDetailsVC.startTimeDescriptionText = myStartTimeText;
    
    [self.navigationController pushViewController:eventDetailsVC animated:YES];
}

@end
