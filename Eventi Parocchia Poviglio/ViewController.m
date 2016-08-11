//
//  ViewController.m
//  Eventi Parocchia Poviglio
//
//  Created by marco on 05/02/15.
//  Copyright (c) 2015 vitaparrpov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

UIDeviceOrientation currentOrientation;
UIWebView* webview;
int dy = 20;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *public_server = @"www.vitaparrpov.altervista.org";
    NSString *local_server = @"marcosim.homepc.it:8082";
    NSString *server = local_server;
    
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                                @"Mozilla/5.0 (iPhone; like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Mobile vitaparrpovmobile/2.0", @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    
    NSString *startpage = [[@"http://" stringByAppendingString:server] stringByAppendingString:@"/app/mobileEvents/"];
    
    NSURL *url = [NSURL URLWithString:startpage];
    
    webview=[[UIWebView alloc] init];
    
    [webview setDelegate:self];
    
    webview.frame = CGRectMake(0, dy, self.view.frame.size.width, self.view.frame.size.height-dy);
    
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:url];
    [webview loadRequest:nsrequest];
    webview.scalesPageToFit = false; // non forza lo zoom al 100%
    [self.view addSubview:webview];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //NSString *theTitle=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    //[webView loadHTMLString:theTitle baseURL:[NSURL URLWithString:@""]];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if(self.view.frame.size.width > self.view.frame.size.height) {
        webview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    } else {
        webview.frame = CGRectMake(0, dy, self.view.frame.size.width, self.view.frame.size.height-dy);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if([[[request URL] absoluteString] containsString:@"__vpextlnk__"]) {
        NSString *urlstr = [[[request URL] absoluteString] stringByReplacingOccurrencesOfString:@"__vpextlnk__" withString:@""];
        NSURL *url = [NSURL URLWithString:urlstr];
        
        [[UIApplication sharedApplication] openURL:url];
        
        return NO;
    }
    return YES;
}

@end
