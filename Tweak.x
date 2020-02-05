/* #import <Foundation/Foundation.h>
#import <math.h>

@interface mainObj: NSObject {}
-(void)main;
@end

@implementation mainObj
-(void)main {

}

int main() {
  id obj=[[mainObj alloc] init];
  [obj main];
  return 0;
}
@end */ 


#import <substrate.h>
#import <Foundation/Foundation.h>

static bool isLoggedIn() {
	return TRUE;
}

%ctor {
	MSHookFunction(MSFindSymbol(NULL, "__BBSUserSessionManger"),(bool*)isLoggedIn, NULL);
}


%hook BBSUserSessionManger
-(bool)IsLoggedIn {
	return TRUE;
}
%end



%hook AppDelegate

- (void)applicationDidBecomeActive:(id)application {
    NSUserDefaults *validate = [NSUserDefaults standardUserDefaults];
    NSString *alreadyRun = @"already_run";
    if ([validate boolForKey:alreadyRun])  
    return;
    [validate setBool:YES forKey:alreadyRun];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank you for Installing"
    message:@"Thanks for Installing BBLog" delegate:nil cancelButtonTitle:@"Okay ;)"
    otherButtonTitles:nil];
    [alert show];
}

%end









/* How to Hook with Logos
Hooks are written with syntax similar to that of an Objective-C @implementation.
You don't need to #include <substrate.h>, it will be done automatically, as will
the generation of a class list and an automatic constructor.

%hook ClassName

// Hooking a class method
+ (id)sharedInstance {
	return %orig;
}

// Hooking an instance method with an argument.
- (void)messageName:(int)argument {
	%log; // Write a message about this call, including its class, name and arguments, to the system log.

	%orig; // Call through to the original function with its original arguments.
	%orig(nil); // Call through to the original function with a custom argument.

	// If you use %orig(), you MUST supply all arguments (except for self and _cmd, the automatically generated ones.)
}

// Hooking an instance method with no arguments.
- (id)noArguments {
	%log;
	id awesome = %orig;
	[awesome doSomethingElse];

	return awesome;
}

// Always make sure you clean up after yourself; Not doing so could have grave consequences!
%end
*/
