//
//  VLViewController.m
//  Example
//
//  Created by Deniz Adalar on 15/01/14.
//  Copyright (c) 2014 Valensas. All rights reserved.
//

#import "VLViewController.h"
#import <VLFramework/UIViewController+VLFramework.h>
#import "TestRequest.h"
#import <AFNetworking.h>

@interface VLViewController ()

@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation VLViewController

-(AFHTTPRequestOperation *)mainRequest {
    TestRequest *request = [TestRequest new];
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer new];
    serializer.acceptableContentTypes = [serializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    request.operationManager.responseSerializer = serializer;
    
    return request.operation;
}

-(void)displayData:(TestResponse*)data {
    [self.tableView reloadData];
    self.dataLabel.text = data.foo;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TestResponse *response = self.vl_data;
    return response.obj.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    TestResponse *response = self.vl_data;
    
    cell.textLabel.text = [response.obj.array[indexPath.row] description];
    
    return cell;
}

- (IBAction)requestDataAction:(id)sender {
    TestRequest *request = [TestRequest new];
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer new];
    serializer.acceptableContentTypes = [serializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    request.operationManager.responseSerializer = serializer;
    
    AFHTTPRequestOperation *operation = request.operation;
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, TestResponse *responseObject) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"foo: %@\nprop1: %@",responseObject.foo, responseObject.obj.prop1] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    } failure:nil];
    [operation start];
}

@end
