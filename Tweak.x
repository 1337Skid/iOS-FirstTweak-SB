#include <UIKit/UIKit.h>

@interface SBHomeScreenViewController : UIViewController
- (void)createbutton;
- (void)btnclick;
- (void)showalert;
@end

static BOOL btnadded = NO;

%hook SBHomeScreenViewController

- (void)viewDidAppear: (BOOL)animated {
    %orig;
    if (btnadded == NO) {
        [self performSelector:@selector(createbutton) withObject:nil];
        [self performSelector:@selector(showalert) withObject:nil];
        btnadded = YES;
    }
}

%new
- (void)createbutton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(50, 100, 120, 50)];
    NSString *str = [NSString stringWithUTF8String:"Hello world!!"];
    [btn setTitle:str forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blueColor];
    btn.layer.cornerRadius = 10;
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

%new
- (void)btnclick {
    UIView *square = [[UIView alloc] initWithFrame:CGRectMake(100, 250, 250, 150)];
    square.backgroundColor = [UIColor redColor];
    square.layer.cornerRadius = 30;
    [self.view addSubview:square];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationRepeatCount:1000.0f];
    [UIView setAnimationRepeatAutoreverses:YES];
    square.backgroundColor = [UIColor orangeColor];
    square.transform = CGAffineTransformMakeScale(1.4, 1.4);
    [UIView commitAnimations];
}

%new
- (void)showalert {
    NSString *title = [NSString stringWithUTF8String:"Hi"];
    NSString *msg = [NSString stringWithUTF8String:"No more PAC violation lol"];
    NSString *ok = [NSString stringWithUTF8String:"Damn cool"];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

%end