@echo off
REM Step 1: Build the Swift project
echo Building the Swift project...
swift build -c release

REM Step 2: Create the Output folder
echo Creating Output folder...
mkdir Output

REM Step 3: Copy the executable to the Output folder
echo Copying MyGame.exe to Output folder...
copy ".build\release\MyGame.exe" "Output\"

REM Step 4: Copy the SDL2.dll to the Output folder
echo Copying SDL2.dll to Output folder...
copy "C:\SDL2\SDL2\lib\x64\SDL2.dll" "Output\"
echo Build and packaging complete!

REM Step 5: Open MyGame.exe
echo Launching MyGame.exe...
start "" "Output\MyGame.exe"
