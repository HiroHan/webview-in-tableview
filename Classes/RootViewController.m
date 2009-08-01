//
//  RootViewController.m
//  webview-fullsize-with-tableview
//
//  Created by Fabien Penso on 02/08/09.
//  Copyright CONOVAE 2009. All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Webview in UITableView";
	webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)]; // Don't use CGRectZero here, won't work
	webview.delegate = self;
	webview.hidden = YES;
	
	[webview loadRequest:[[NSURLRequest alloc] 
						  initWithURL: [NSURL URLWithString:@"http://www.google.com/"]]];
	
	[self.tableView setTableFooterView:webview]; // Leave this, else you'll have rows to fill the rest of the screen

}

- (void) webViewDidFinishLoad:(UIWebView *)webView {
	float newSize = [[webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollHeight"] floatValue];
	NSLog(@"Resizing webview from %.2f to %.2f", webView.frame.size.height, newSize);
	webView.frame = CGRectMake(webView.frame.origin.x, webView.frame.origin.y, webView.frame.size.width, newSize);
	webView.hidden = NO;
	
	// We need to reset this, else the new frame is not used.
	[self.tableView setTableFooterView:webview];
}

- (void)viewDidUnload {
	// Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
	// For example: self.myOutlet = nil;
}

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 3;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	cell.textLabel.text = [NSString stringWithFormat:@"this is cell %d", indexPath.row];
	
    return cell;
}



#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	// Relinquish ownership of any cached data, images, etc that aren't in use.
}


- (void)dealloc {
    [super dealloc];
}


@end

