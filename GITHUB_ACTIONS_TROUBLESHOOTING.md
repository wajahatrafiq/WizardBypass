# GitHub Actions Troubleshooting Guide

## 🔍 Common Issues and Solutions

### **Issue 1: Theos Installation Fails**
**Problem:** Theos fails to install or iOS SDK download times out
**Solution:** Use the simplified workflow that doesn't depend on Theos
- Use `build-simple.yml` or `build-standalone.yml`
- These compile directly with clang, no Theos needed

### **Issue 2: SDK Path Problems**
**Problem:** iOS SDK not found or incorrect path
**Solution:** The new workflows use `xcrun --sdk iphoneos --show-sdk-path`
- Automatically finds the correct SDK
- Works with latest Xcode versions
- No hardcoded paths

### **Issue 3: Architecture Mismatch**
**Problem:** Dylib compiled for wrong architecture
**Solution:** Explicit arm64 compilation
- `-arch arm64` flag ensures correct architecture
- Verification step checks for arm64
- Fails fast if wrong architecture

### **Issue 4: Missing Dependencies**
**Problem:** Required frameworks not linked
**Solution:** Explicit framework linking
- `-framework Foundation`
- `-framework UIKit`
- `-framework CoreGraphics`
- Verification step checks all dependencies

### **Issue 5: Dylib Not Found After Build**
**Problem:** Theos creates complex output paths
**Solution:** Direct clang compilation
- Output file name is predictable
- No complex path finding needed
- Single command produces dylib

---

## 🛠️ Available Workflows

### **1. build-simple.yml (Recommended)**
- ✅ Compiles your existing `WizardBypass.x`
- ✅ Direct clang compilation
- ✅ No Theos dependency
- ✅ Includes verification steps
- ✅ Creates test binary

### **2. build-standalone.yml (Most Reliable)**
- ✅ Self-contained source code
- ✅ No external file dependencies
- ✅ Complete bypass implementation
- ✅ Deployment package included
- ✅ Most reliable option

### **3. build.yml (Original - Not Recommended)**
- ❌ Theos dependency issues
- ❌ Complex build process
- ❌ SDK download failures
- ❌ Path finding problems

---

## 🚀 Quick Fix Steps

### **Step 1: Use Standalone Workflow**
```bash
# Switch to standalone workflow
mv .github/workflows/build.yml .github/workflows/build-old.yml
mv .github/workflows/build-standalone.yml .github/workflows/build.yml
```

### **Step 2: Commit and Push**
```bash
git add .github/workflows/build.yml
git commit -m "Fix GitHub Actions - use standalone workflow"
git push origin main
```

### **Step 3: Monitor Build**
- Go to Actions tab in GitHub
- Watch the build progress
- Check for any errors
- Download artifacts when complete

---

## 📊 Expected Build Output

### **Successful Build Should Show:**
```
🔨 COMPILING STANDALONE WIZARDBYPASS...
Using SDK: /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk
📊 COMPILATION RESULTS:
-rwxr-xr-x  1 runner  staff    24K WizardBypass_Standalone.dylib
WizardBypass_Standalone.dylib: Mach-O 64-bit dynamically linked shared library arm64
📋 DEPENDENCIES:
WizardBypass_Standalone.dylib:
	/usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1311.0.0)
	/System/Library/Frameworks/Foundation.framework/Versions/C/Foundation (compatibility version 300.0.0, current version 1856.0.0)
	/System/Library/Frameworks/UIKit.framework/Versions/A/UIKit (compatibility version 1.0.0, current version 6100.0.0)
	/System/Library/Frameworks/CoreGraphics.framework/Versions/A/CoreGraphics (compatibility version 64.0.0, current version 1670.0.0)
📊 SIZE: 24K
✅ STANDALONE DYLIB VERIFICATION PASSED!
```

---

## 🧪 Testing the Compiled Dylib

### **1. Download Artifacts**
- Go to Actions → Latest Run → Artifacts
- Download `WizardBypass-Standalone`
- Extract the deployment package

### **2. Verify Dylib**
```bash
# Check architecture
file WizardBypass.dylib
# Should show: Mach-O 64-bit dynamically linked shared library arm64

# Check dependencies
otool -L WizardBypass.dylib
# Should show Foundation, UIKit, CoreGraphics

# Check size
ls -lh WizardBypass.dylib
# Should be around 20-30KB
```

### **3. Test on Device**
- Inject dylib into 8 Ball Pool
- Launch game
- Look for purple "W" button after 3 seconds
- Tap button to see "CustomWizard" menu
- Check console for "[WizKey]" logs

---

## 🔧 Debugging Failed Builds

### **Check Build Logs:**
1. Go to Actions tab
2. Click on failed run
3. Click on each step to expand
4. Look for red error messages
5. Check the specific command that failed

### **Common Error Messages:**

#### **"clang: error: no such file or directory"**
- SDK path issue
- Fixed by using `xcrun --sdk iphoneos --show-sdk-path`

#### **"file WizardBypass.dylib: cannot open"**
- Compilation failed
- Check clang command output
- Verify source file exists

#### **"Mach-O, but wrong architecture"**
- Wrong architecture flags
- Ensure `-arch arm64` is present
- Check SDK compatibility

---

## 📞 Support

If builds still fail:
1. Check the specific error message
2. Verify the source file exists
3. Try the standalone workflow
4. Check GitHub Actions runner status
5. Ensure all files are committed to git

The standalone workflow should work reliably as it has no external dependencies beyond standard macOS tools.
