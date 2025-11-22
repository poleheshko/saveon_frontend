# Fix Flutter Connection Issues with Norton Antivirus

## ⚠️ IMPORTANT: Norton is Very Aggressive!

Norton often blocks Flutter connections even with exclusions. You need to configure multiple settings.

---

## Step 1: Add Exclusions in Norton (Detailed)

### 1.1 Open Norton
1. Find the **Norton icon** in your system tray (bottom right, near the clock)
2. **Right-click** the Norton icon
3. Click **"Open Norton"** or **"Norton 360"**

### 1.2 Navigate to Exclusions
1. Click **"Settings"** (usually a gear icon or in the menu)
2. Look for **"Antivirus"** or **"Scans and Risks"**
3. Click **"Scans and Risks"** or **"Exclusions / Low Risks"**
4. Find **"Exclusions"** or **"Configure Exclusions"**

### 1.3 Add Folder Exclusions
1. Click **"Add"** or **"+"** button
2. Select **"Folders and Files"** or **"Folders"**
3. Click **"Browse"** or **"Add Folder"**
4. Add these folders (one at a time):

   **Folder 1:**
   - Navigate to: `C:\Users\stani\AppData\Local\flutter`
   - Select the **flutter** folder
   - Click **"OK"** or **"Add"**

   **Folder 2:**
   - Click **"Add"** again
   - Navigate to: `C:\Users\stani\aprojects\saveon_frontend`
   - Select the **saveon_frontend** folder
   - Click **"OK"** or **"Add"**

   **Folder 3:**
   - Click **"Add"** again
   - Navigate to: `C:\Users\stani\AppData\Local\Pub\Cache`
   - If this folder exists, select it
   - Click **"OK"** or **"Add"**

5. Click **"Apply"** or **"Save"**

---

## Step 2: Disable SONAR Protection (Temporarily)

SONAR is Norton's behavioral protection that can block Flutter:

1. In Norton, go to **"Settings"**
2. Click **"Antivirus"** or **"Scans and Risks"**
3. Find **"SONAR Protection"** or **"Behavioral Protection"**
4. **Turn it OFF temporarily** (just to test)
5. Click **"Apply"**

**⚠️ IMPORTANT:** Turn this back ON after testing if Flutter works!

---

## Step 3: Add Firewall Exceptions

### 3.1 Open Norton Firewall Settings
1. In Norton, go to **"Settings"**
2. Click **"Firewall"** or **"Network"**
3. Click **"Program Rules"** or **"Program Control"**

### 3.2 Add Flutter Programs
1. Click **"Add"** or **"+"**
2. Browse to: `C:\Users\stani\AppData\Local\flutter\bin\cache\dart-sdk\bin\dart.exe`
3. Set it to **"Allow"** for all connections
4. Click **"OK"**

5. Click **"Add"** again
6. Browse to: `C:\Users\stani\AppData\Local\flutter\bin\flutter.exe`
7. Set it to **"Allow"** for all connections
8. Click **"OK"**

9. Click **"Apply"** or **"Save"**

---

## Step 4: Disable Smart Firewall for Testing

1. In Norton, go to **"Settings"** → **"Firewall"**
2. Find **"Smart Firewall"** or **"Auto Block"**
3. **Turn it OFF temporarily** (to test)
4. Click **"Apply"**

**⚠️ IMPORTANT:** Turn this back ON after testing!

---

## Step 5: Add to Trusted Applications

1. In Norton, go to **"Settings"**
2. Look for **"Trusted Applications"** or **"Application Control"**
3. Click **"Add"**
4. Browse to: `C:\Users\stani\AppData\Local\flutter\bin\cache\dart-sdk\bin\dart.exe`
5. Set trust level to **"Full Trust"** or **"Trusted"**
6. Repeat for: `C:\Users\stani\AppData\Local\flutter\bin\flutter.exe`

---

## Step 6: Test Connection

1. **Close Android Studio completely**
2. **Close all Flutter apps**
3. Open PowerShell
4. Run:
   ```powershell
   cd C:\Users\stani\aprojects\saveon_frontend
   flutter clean
   flutter run -d windows
   ```
5. **Wait 5-10 minutes** - connection should stay stable!

---

## Quick Test: Temporarily Disable Norton

To confirm Norton is the problem:

1. **Right-click** Norton icon in system tray
2. Click **"Disable Auto-Protect"** or **"Turn Off"**
3. Choose **"Until I restart"** or **"15 minutes"**
4. Test Flutter - if it works, Norton is definitely the issue
5. **Re-enable Norton** and follow the steps above

---

## Alternative: Add Norton Exception via Command Line

If you can't find the settings, try this:

1. Open PowerShell as **Administrator**
2. Run:
   ```powershell
   # Find Norton installation
   $nortonPath = Get-ChildItem "C:\Program Files\Norton*" -ErrorAction SilentlyContinue
   if ($nortonPath) {
       Write-Host "Norton found at: $($nortonPath.FullName)"
   }
   ```

---

## Most Common Norton Settings Location

Depending on your Norton version, settings might be at:
- **Norton 360:** Settings → Antivirus → Scans and Risks → Exclusions
- **Norton Security:** Settings → Antivirus → Exclusions
- **Norton Internet Security:** Settings → Antivirus → Exclusions/Low Risks

---

## Still Not Working?

1. **Temporarily disable Norton completely** (15 minutes)
2. Test Flutter - if it works, Norton is blocking it
3. Check Norton's **"History"** or **"Logs"** to see what it blocked
4. Look for entries about `dart.exe` or `flutter.exe`
5. Add those specific files to exclusions

---

## Pro Tip: Create a Norton Profile for Development

Some Norton versions let you create profiles:
1. Create a **"Development"** profile
2. Set all protections to **"Low"** or **"Off"**
3. Switch to this profile when developing
4. Switch back to **"Normal"** when done

---

## Summary Checklist

- [ ] Added Flutter folder to Norton exclusions
- [ ] Added project folder to Norton exclusions
- [ ] Added Pub cache folder to Norton exclusions
- [ ] Added dart.exe to Firewall exceptions
- [ ] Added flutter.exe to Firewall exceptions
- [ ] Temporarily disabled SONAR (to test)
- [ ] Added to Trusted Applications
- [ ] Tested with Norton disabled (to confirm it's the issue)


