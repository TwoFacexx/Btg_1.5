# ⚡ Execution Manual
## Super Bogalho: Echoes of the Hat

### 🚀 Running the Game

**Prerequisites:**
- Windows 7 or higher
- DirectX 11 installed
- ~100MB free space

**Method 1 - Desktop Shortcut:**
- Double-click the "Super Bogalho" icon on desktop

**Method 2 - Start Menu:**
- Click the Start button
- Search for "Super Bogalho" or "Mead Games"
- Click the game to launch

**Method 3 - Installation Folder:**
- Navigate to the installation folder
- Execute the `Super_Bogalho.exe` file

### 🎯 Menu Navigation

The game features an intuitive menu interface with the following options:

**🔄 Continue** *(appears only if save exists)*
- Loads automatically saved progress
- Takes you directly to the last played level

**🆕 New Game**
- Starts a fresh adventure from scratch
- If previous save exists, asks if you want to delete progress

**🏆 Achievements**
- View all game achievements
- Shows which ones you've unlocked and which are still locked

**⚙️ Options**
- **Music Volume:** Adjusts background music (100% → 0% → 10% → 20%...)
- **SFX Volume:** Adjusts sound effects (100% → 0% → 10% → 20%...)
- **Resolution:** Switch between 1280x720, 1920x1080, 2560x1440

**❌ Exit**
- Closes the game completely
- Progress is automatically saved

### 🕹️ In-Game Controls

**Movement:**
- **A / D:** Move character left/right
- **Space:** Jump
- **W:** Enter doors

**Interface:**
- **ESC or P:** Pause/Unpause the game

**Debug Functions (during development):**
- **S:** Manually save game
- **L:** Load game
- **R:** Reset save (with confirmation)
- **Enter:** Restart after Game Over (manual mode)

### ⏸️ Pause Menu

**During gameplay, press ESC or P to open the pause menu:**

**▶️ Continue**
- Returns immediately to the game

**⚙️ Options**
- Same options menu as main menu
- Changes are applied and saved instantly

**🏠 Main Menu**
- Returns to main menu
- Asks for confirmation before exiting
- Progress is automatically saved

### 📊 Data Persistence System

**Persistence Implementation:**
- **Format:** JSON serialized with Base64 encryption
- **Location:** `pigplatformer_save.dat` in game folder
- **Structure:** Hierarchical system with player → statistics/achievements/settings
- **Security:** Automatic integrity verification when loading

**Persisted Data:**
- ✅ Level progress
- ✅ Collected coins (unique system - don't respawn)
- ✅ Unlocked achievements
- ✅ Audio and video settings
- ✅ Game statistics (pigs killed, time played)

**Backup and Recovery:**
- Automatic save every 60 seconds
- Data validation when loading
- Automatic recreation if file corrupted

### 🎮 Game Interface (HUD)

**Top Left Corner:**
- **💖 Hearts:** Show remaining lives (maximum 3)
- **🪙 Coins:** Counter of coins collected in current session

**During Game Over:**
- **Manual Mode:** Press ENTER to restart
- Slow motion camera effect for dramatization

### 🎯 Game Mechanics

**❤️ Lives:**
- You have 3 lives by default
- Lose life when touching enemies or hit by bombs
- Game Over occurs when all lives are lost

**🪙 Coins:**
- Collect coins scattered throughout levels
- **Persistent system**: Collected coins don't respawn
- Progress is automatically saved
- Use to track your progress

**🐷 Enemies:**
- **Basic Pigs:** Walk randomly, can activate bombs
- **Bomb Pigs:** Detect player and throw bombs
- **Jump on heads** of enemies to defeat them
- Each eliminated enemy counts for achievements

**💣 Bombs:**
- **States:** Off → On → Explosion
- **Chain reaction:** Bombs activate other nearby bombs
- Can be activated by enemies or other explosions
- Cause area damage

**🏆 Achievement System:**
- **"First Bacon!":** Kill your first pig
- **"Pig Hunter!":** Kill 10 pigs
- **"Explosive!":** Get hit by a bomb
- Achievements are permanently saved

### 🎵 Implemented Audio System

**Ambient Music:**
- Musical theme in main menu
- Independent volume control for music
- Automatic loop playback

**Sound Effects (SFX):**
- ✅ Footstep sounds during movement
- ✅ Jump and landing sounds
- ✅ Coin collection sounds
- ✅ Bomb explosion sounds
- ✅ Enemy damage/hit sounds
- ✅ Interface sounds (door opening/closing)

**Volume Control:**
- Separation between music and SFX
- Real-time adjustment via menu
- Settings automatically saved

**🔊 Volume Control:**
- **Music Volume:** Controls background music
- **SFX Volume:** Controls sound effects
- Adjustment goes 100% → 0% → 10% → 20% → ... → 90% → 100%
- Settings are automatically saved

### 🖥️ Platform Compatibility

**Primary Platform:**
- **Windows** (7/8/10/11): Native `.exe` executable
- Tested on different resolutions and configurations

**Additional Export:**
- **Linux/macOS**: Compatible via Wine (tested)
- **Other platforms**: GameMaker Studio 2 supports multiple platforms
  
**Current Limitations:**
- HTML5: Not recommended due to file-based save system
- Mobile: Not implemented (requires control adaptation)

### 🛠️ Runtime Troubleshooting

**Game Crashed:**
1. Press Alt+Tab to minimize
2. Close game via Task Manager
3. Restart game - autosave will preserve progress

**Sound Cutting Out:**
1. Go to Options → adjust volumes
2. Test different volume levels
3. Restart game if necessary

**Controls Not Responding:**
1. Press ESC to pause/unpause
2. Click on game window to ensure focus
3. Restart game if problem persists

**Low Performance:**
1. Reduce resolution in Options
2. Close browsers and other programs
3. Check if Windows updates are running

### 📝 Credits and Resources

**Development:**
- **Developer:** Pedro Fontana Moretti
- **Supervisor:** Helena Nunes
- **Institution:** Escola Profissional Bento de Jesus Caraça
- **Project:** FCT/PAP 2025 - GPSI Course

**Visual Resources:**
- **Player Sprites:** Created using Aseprite
- **Enemy Sprites:** Original development
- **Environment Sprites:** Original creation
- **Particles:** Internally developed system

**Audio Resources:**
- **SFX:** [Specify sound effects source]
- **Music:** [Specify ambient music source]
- **Processing:** `tocar_som()` system developed internally

**Technologies:**
- **Engine:** GameMaker Studio 2 (2024.x)
- **Language:** GML (GameMaker Language)
- **Version Control:** Git + GitHub
- **Design:** Aseprite for pixel art

### ❌ Closing the Game

**Methods to Close:**
1. **Main Menu → Exit**
2. **Alt+F4** during execution
3. **X** in window corner (if in windowed mode)
4. **Ctrl+Alt+Del → Task Manager** (emergency)

**Important:** Progress is always automatically saved before closing!

### 📋 Execution and Debug Logs

**Available Debug Information:**
- `show_debug_message()` for save/load monitoring
- Coin collection and achievement logs
- Data integrity verification
- Performance monitoring (FPS, memory)

**Debug Commands (Development):**
- **S:** Manual save with log
- **L:** Manual load with verification
- **R:** Complete save reset
- **T:** Manual achievement testing (achievements screen)
- **I:** Forced save system reinitialization

**Log Location:**
- GameMaker Studio 2 output console
- Real-time debug messages during execution

---

## 📊 Technical Information

**Version:** 1.5  
**Build Date:** June 2025  
**Compatibility:** Windows 7+  
**Disk Space:** ~100MB  
**Recommended RAM:** 4GB+  

For technical support, consult the main [README.md](README_PT.md).