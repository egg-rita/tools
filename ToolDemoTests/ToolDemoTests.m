//
//  ToolDemoTests.m
//  ToolDemoTests
//
//  Created by zkl on 2019/3/13.
//  Copyright © 2019 赵凯乐. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
@interface ToolDemoTests : XCTestCase
@property(nonatomic,strong)ViewController *ctr;
@end

@implementation ToolDemoTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.ctr = [[ViewController alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    self.ctr.view.backgroundColor = [UIColor redColor];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
