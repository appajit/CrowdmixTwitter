//
//  ProfileImageDownloadServiceTests.m
//  CrowdmixTwitter
//
//  Created by Appaji Tholeti on 28/03/2016.
//  Copyright © 2016 Tholeti. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OCMock.h"
#import "ProfileImageDownloadService.h"
#import "MTLJSONAdapter.h"

@interface ProfileImageDownloadServiceTests : XCTestCase

@property (nonatomic,strong) ProfileImageDownloadService *profileImageDownloadService;
@property (nonatomic,strong) id mockUrlSession;

@end

@implementation ProfileImageDownloadServiceTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.mockUrlSession = [OCMockObject niceMockForClass:[NSURLSession class]];
    self.profileImageDownloadService = [[ProfileImageDownloadService alloc] initWithUrlSession:self.mockUrlSession];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDownloadProfileImageUrlSuccesssfully
{
    id mockUrlResponse = [OCMockObject mockForClass:[NSHTTPURLResponse class]];
    [[[mockUrlResponse stub] andReturnValue:OCMOCK_VALUE(200)] statusCode];
    
    void (^proxyBlock)(NSInvocation *) = ^(NSInvocation *invocation)
    {
        void (^passedBlock)(NSData *data, NSURLResponse *response, NSError *error);
        [invocation getArgument:&passedBlock atIndex:3];
        NSString *filePath = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent:@"tweet_profile_image.png"];
        
        NSData* imageData = [NSData dataWithContentsOfFile:filePath];
        passedBlock(imageData,mockUrlResponse, nil);
    };

    
    [[[self.mockUrlSession stub] andDo:proxyBlock] dataTaskWithRequest:OCMOCK_ANY completionHandler:OCMOCK_ANY];
   
    __block BOOL isFinished = NO;
    __block NSData *profileImageData;
    [self.profileImageDownloadService downloadProfileImageFromURL:@"tweet_profile_image.png"
                                              withCompletionBlock:^(NSData *imageData)
    {
        isFinished = YES;
        profileImageData = imageData;
        
    }];
     
    while(!isFinished)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        [NSThread sleepForTimeInterval:0.1];
    }
    
    XCTAssertNotNil(profileImageData,@"image data should not be nil");
}



@end
