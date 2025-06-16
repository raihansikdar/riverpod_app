# 📦 Flutter CI/CD for Android (GitHub Actions)

This guide sets up automatic Android builds (APK & AAB) using GitHub Actions. It includes keystore configuration and GitHub release integration.

---

## 🔐 Step 1: Generate Keystore

Run the following to create your release keystore:

```bash
keytool -genkey -v -keystore upload-keystore.jks -alias upload -keyalg RSA -keysize 2048 -validity 10000

```

## 🔁 Step 2: Encode Keystore to Base64

```bash
[Convert]::ToBase64String([IO.File]::ReadAllBytes("upload-keystore.jks"))
```
## 🛡️ Step 3: Add GitHub Secret

1. Go to GitHub Repo → Settings → Secrets and variables → Actions → Secrets

2. Click New repository secret

3. Name it KEYSTORE (case-sensitive)

4. Paste the base64 string in the value field

5. Save it

## ⚙️ Step 4: GitHub Actions Workflow

``` bash

name: "Build & Release Android Only"

on:
  pull_request:
    branches: [main, master]
  push:
    branches: [main, master, develop]

jobs:
  build:
    name: Build & Release Android
    runs-on: windows-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Set up Java 17
        uses: actions/setup-java@v4
        with:
          distribution: 'zulu'
          java-version: '17'

      - name: Set up Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.32.4'
          channel: 'stable'

      - name: Install dependencies
        run: flutter pub get

      - name: Decode Keystore
        shell: pwsh
        run: |
          $base64String = "${{ secrets.KEYSTORE }}"
          [System.IO.File]::WriteAllBytes("android/app/upload-keystore.jks", [System.Convert]::FromBase64String($base64String))

      - name: Create key.properties
        run: |
          echo storePassword=raihan007 > android/key.properties
          echo keyPassword=raihan007 >> android/key.properties
          echo keyAlias=upload >> android/key.properties
          echo storeFile=upload-keystore.jks >> android/key.properties

      - name: Build APK
        run: flutter build apk --release

      - name: Build AAB
        run: flutter build appbundle --release

      - name: Upload APK & AAB to Release
        uses: ncipollo/release-action@v1
        with:
          artifacts: |
            build/app/outputs/flutter-apk/app-release.apk
            build/app/outputs/bundle/release/app-release.aab
          tag: v1.0.${{ github.run_number }}
          token: ${{ secrets.TOKEN }}

```

## if not build keystore:

```bash
name: "Build & Release Android Only"

on:
  pull_request:
    branches:
      - main
      - master
  push:
    branches:
      - main
      - master
      - develop

jobs:
  build:
    name: Build & Release Android
    runs-on: windows-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Set up Java 17
        uses: actions/setup-java@v4
        with:
          distribution: 'zulu'
          java-version: '17'

      - name: Set up Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.32.4'
          channel: 'stable'


      - name: Install dependencies
        run: flutter pub get

      - name: Decode Keystore
        run: echo "${{ secrets.KEYSTORE }}" | base64 --decode > android/app/upload-keystore.jks

      - name: Build APK
        run: flutter build apk --release #--split-per-abi

#      - name: Upload APK to Release
#        uses: ncipollo/release-action@v1
#        with:
#          artifacts: "build/app/outputs/apk/release/*"
#          tag: v1.0.${{ github.run_number }}
#          token: ${{ secrets.TOKEN }}

      - name: Build AAB
        run: flutter build appbundle --release

      - name: Upload APK & AAB to Release
        uses: ncipollo/release-action@v1
        with:
          artifacts: |
            build/app/outputs/flutter-apk/app-release.apk
            build/app/outputs/bundle/release/app-release.aab
          tag: v1.0.${{ github.run_number }}
          token: ${{ secrets.TOKEN }}
          
```
