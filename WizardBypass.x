// MINIMAL WIZARD BYPASS v5.0 - Crash-Safe Runtime Approach
// Only targets specific popup blocking without aggressive binary modification

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>

static BOOL g_bypass_active = NO;
static BOOL g_popup_blocked = NO;

// MARK: - Minimal SCLAlertView Blocking
static void block_sclalertview_minimal() {
    NSLog(@"[WizKey] 🎯 MINIMAL SCLAlertView BLOCKING...");
    
    // Only block show methods that cause license popups
    Class sclClass = objc_getClass("SCLAlertView");
    if (sclClass) {
        NSLog(@"[WizKey] ✅ SCLAlertView FOUND - MINIMAL BLOCKING");
        
        // Only block specific show methods
        NSArray *targetMethods = @[@"showInfo", @"showSuccess", @"showError", @"showWarning"];
        
        for (NSString *methodName in targetMethods) {
            SEL selector = sel_registerName([methodName UTF8String]);
            Method method = class_getInstanceMethod(sclClass, selector);
            
            if (method) {
                method_setImplementation(method, imp_implementationWithBlock(
                    ^(id self, ...) {
                        NSLog(@"[WizKey] 🚫 LICENSE POPUP BLOCKED: %@", methodName);
                        g_popup_blocked = YES;
                        return nil; // Block the popup
                    }
                ));
                NSLog(@"[WizKey] ✅ BLOCKED METHOD: %@", methodName);
            }
        }
        
        NSLog(@"[WizKey] ✅ MINIMAL SCLAlertView BLOCKING ACTIVE");
    } else {
        NSLog(@"[WizKey] ❌ SCLAlertView NOT FOUND");
    }
}

// MARK: - Safe Authentication Spoofing
static void spoof_authentication_safe() {
    NSLog(@"[WizKey] 🎯 SAFE AUTHENTICATION SPOOFING...");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Only set essential auth keys
    NSArray *essentialKeys = @[@"wizard-authenticated", @"wizard-premium"];
    NSArray *essentialValues = @[@"true", @"enabled"];
    
    for (int i = 0; i < essentialKeys.count; i++) {
        [defaults setObject:essentialValues[i] forKey:essentialKeys[i]];
        NSLog(@"[WizKey] 🔐 SET %@ = %@", essentialKeys[i], essentialValues[i]);
    }
    
    [defaults synchronize];
    NSLog(@"[WizKey] ✅ SAFE AUTHENTICATION SPOOFED");
}

// MARK: - Create Simple Access Button
static void create_access_button() {
    NSLog(@"[WizKey] 🎨 CREATING SIMPLE ACCESS BUTTON...");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if (window) {
            // Create simple purple button
            UIButton *accessButton = [UIButton buttonWithType:UIButtonTypeCustom];
            accessButton.frame = CGRectMake(50, 100, 100, 100);
            accessButton.backgroundColor = [UIColor purpleColor];
            accessButton.layer.cornerRadius = 50;
            accessButton.layer.borderWidth = 3;
            accessButton.layer.borderColor = [UIColor whiteColor].CGColor;
            
            // Add "WIZ" text
            [accessButton setTitle:@"WIZ" forState:UIControlStateNormal];
            [accessButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            accessButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
            accessButton.titleLabel.numberOfLines = 1;
            
            // Add to window
            [window addSubview:accessButton];
            [window bringSubviewToFront:accessButton];
            
            // Add tap handler
            [accessButton addTarget:accessButton action:@selector(show_wizard_menu) 
                         forControlEvents:UIControlEventTouchUpInside];
            
            NSLog(@"[WizKey] 🎨 ACCESS BUTTON CREATED AND VISIBLE");
        }
    });
}

// MARK: - Show Wizard Menu (Safe)
static void show_wizard_menu() {
    NSLog(@"[WizKey] 🎯 ATTEMPTING TO SHOW WIZARD MENU...");
    
    // Try to find and create ABVJSMGADJS instance
    Class abvClass = objc_getClass("ABVJSMGADJS");
    if (abvClass) {
        // Try to get existing instance
        id singleton = nil;
        
        // Method 1: Try sharedInstance
        if (class_getClassMethod(abvClass, @selector(sharedInstance))) {
            singleton = ((id(*)(id, SEL))objc_msgSend)(abvClass, @selector(sharedInstance));
        }
        
        // Method 2: Try alloc/init
        if (!singleton) {
            singleton = ((id(*)(id, SEL))objc_msgSend)([abvClass alloc], @selector(init));
        }
        
        if (singleton) {
            NSLog(@"[WizKey] ✅ ABVJSMGADJS OBTAINED: %p", singleton);
            
            // Try to call menu creation methods safely
            NSArray *menuMethods = @[@"IKAFHFDSAJ", @"PADSGFNDSAHJ"];
            for (NSString *methodName in menuMethods) {
                SEL selector = sel_registerName([methodName UTF8String]);
                if (class_getInstanceMethod(abvClass, selector)) {
                    NSLog(@"[WizKey] 🎯 CALLING METHOD: %@", methodName);
                    @try {
                        ((void(*)(id, SEL))objc_msgSend)(singleton, selector);
                        NSLog(@"[WizKey] ✅ MENU METHOD CALLED SUCCESSFULLY");
                        break;
                    } @catch (NSException *exception) {
                        NSLog(@"[WizKey] ❌ METHOD FAILED: %@", exception.reason);
                    }
                }
            }
        } else {
            NSLog(@"[WizKey] ❌ FAILED TO OBTAIN ABVJSMGADJS");
        }
    } else {
        NSLog(@"[WizKey] ❌ ABVJSMGADJS CLASS NOT FOUND");
    }
}

// MARK: - Button Action
@implementation UIButton (WizardBypass)
- (void)show_wizard_menu {
    show_wizard_menu();
}
@end

// MARK: - Main Constructor
__attribute__((constructor))
static void wizard_minimal_bypass() {
    NSLog(@"[WizKey] 🚀 MINIMAL WIZARD BYPASS v5.0 STARTING...");
    
    // Execute bypass safely with delays
    dispatch_async(dispatch_get_main_queue(), ^{
        // Phase 1: Block popups (minimal)
        block_sclalertview_minimal();
        
        // Phase 2: Safe authentication spoofing
        spoof_authentication_safe();
        
        // Phase 3: Create access button (guaranteed access)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
            create_access_button();
            
            g_bypass_active = YES;
            NSLog(@"[WizKey] 🎉 MINIMAL BYPASS COMPLETE!");
            NSLog(@"[WizKey] 📊 STATUS: Bypass=%@ Popup=%@", 
                   g_bypass_active ? @"✅" : @"❌",
                   g_popup_blocked ? @"✅" : @"❌");
        });
    });
}
