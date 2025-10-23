# Android App Signing Setup - IMPORTANT INSTRUCTIONS

## ✅ What's Already Done

- `upload.jks` keystore file created in `android/` folder
- `key.properties` file created with template
- `android/app/build.gradle` configured for release signing

## 🔐 SECURITY SETUP REQUIRED

### Step 1: Update Passwords in key.properties

You MUST edit `android/key.properties` and replace the placeholder passwords:

```properties
storePassword=your_keystore_password_here  # ← Replace with your actual keystore password
keyPassword=your_key_password_here         # ← Replace with your actual key password
keyAlias=upload
storeFile=upload.jks
```

**IMPORTANT:**

- Use the SAME passwords you entered when creating the keystore
- Keep these passwords SECURE and PRIVATE
- Never commit the real passwords to version control

### Step 2: Add to .gitignore

Add these lines to your `.gitignore` to protect sensitive files:

```
# Android signing
android/key.properties
android/upload.jks
```

### Step 3: Build Release APK/Bundle

Once passwords are set, you can build release versions:

```bash
# Build release APK
flutter build apk --release

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release
```

### Step 4: Backup Your Keystore

- Keep `upload.jks` file safe and backed up
- If you lose this file, you cannot update your app on Play Store
- Store it in a secure location outside your project

## 🚨 Security Notes

1. **Never share your keystore file or passwords**
2. **Never commit key.properties with real passwords**
3. **Keep multiple backups of your keystore file**
4. **Use strong, unique passwords**

## ✅ Next Steps for Play Store

1. Update passwords in `key.properties`
2. Build your app bundle: `flutter build appbundle --release`
3. Upload the `.aab` file from `build/app/outputs/bundle/release/` to Play Store
4. Follow Google Play Console upload process

Your keystore is ready! Just update the passwords and you're good to go. 🎉
