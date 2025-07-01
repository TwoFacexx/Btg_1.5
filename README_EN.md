## 🧢 Super Bogalho: Echoes of the Hat

> A 2D platformer where green pigs are your main enemies and bombs are both your salvation and your doom.

---

### 🎮 About the Game
**Super Bogalho: Echoes of the Hat** is a 2D platformer developed in GameMaker Studio 2. You play as Bogalho, a quirky character on a mission to defeat green pigs by jumping on them or using bombs, while navigating levels filled with danger, achievements, and visual feedback.

---

### 🚀 Features
- Enemy AI with varied states (walking, idle, bomb interaction)
- Bomb system with chain reactions
- Unlockable achievements with pop-up feedback
- Dynamic HUD displaying lives, coins, and effects
- Particle systems for explosions, coins, and deaths
- Save/Load system with base64 encryption (JSON-encoded)
- Exportable to Windows with Wine/Linux compatibility
- Menu with audio/visual configuration

---

### 🕹️ Controls (Keyboard)
| Action        | Key         |
|---------------|-------------|
| Move          | A / D       |
| Jump          | Space       |
| Enter Door    | W           |
| Save Game     | S           |
| Load Game     | L           |
| Reset Save    | R           |

---

### 📁 Data Persistence
- Data stored in a local `.dat` file (encrypted in Base64)
- JSON-based structure: stats, achievements, config and progress
- Autosaves every 60 seconds or after finishing a level
- Game state restored with `aplicar_dados_carregados()`

Example structure:
```json
{
  "player": {
    "stats": {
      "current_lives": 3,
      "coins_total": 42,
      "pigs_killed": 15,
      "high_score": 8000,
      "deaths_total": 2,
      "current_level": 4,
      "total_playtime": 762
    },
    "config": {
      "volume_master": 0.8,
      "volume_sfx": 0.6,
      "volume_music": 0.7
    },
    "achievements": ["first_pig"]
  }
}
```

---

### 🧠 Artificial Intelligence
- Green pigs have different behaviors:
  - Walk randomly
  - React to bombs (pick up or ignite them)
  - Handle collision, damage, and death
- Bomb pigs can detect and attack the player

---

### 💣 Bomb System
- Bombs transition through 3 states: `off` → `on` → `boom`
- Explosion triggers particles, sound, damage, and chain reactions
- Getting hit by a bomb unlocks the "Explosive!" achievement

---

### 🏆 Achievements
| ID             | Name              | Condition                       |
|----------------|-------------------|----------------------------------|
| first_pig      | First Bacon!      | Kill the first pig              |
| 10_pigs        | Pig Hunter!       | Kill 10 pigs                    |
| explosive      | Explosive!        | Get hit by a bomb               |

Visual popups are shown when an achievement is unlocked.

---

### 🔊 Menu & Settings
- Music theme on the main menu
- Adjustable music and SFX volume
- Supported resolutions: 1280x720, 1920x1080, 2560x1440

---

### 🧪 Testing
- Save/load tested with simulated corruption
- Achievements and stats debugged in real-time
- Optimized using light instance usage and particle effects

---

### 🖥️ Platforms
- **Windows**: native `.exe` executable
- **Linux/macOS**: compatible via **Wine** (tested)
- **HTML5 / Android**: not supported in this version

---

### 📜 License & Rights
This game was created by Pedro Moretti as part of the FCT/PAP 2025 project. All assets used were either original or licensed for educational use.

---

### 🧩 Minimum Requirements
- Windows 7+
- Dual-Core CPU
- 4GB RAM
- DirectX 11
- ~100MB of storage

---

### 🧠 Developed by
**Pedro Moretti**  
FCT/PAP Project - GPSI Technical Course  
**Mead Games** 

---

### 📂 GitHub / Source Code
If you'd like to explore the code or contribute:  
(https://github.com/TwoFacexx/Btg_1.5)

> Thanks for playing ✨