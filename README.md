# Card Battle Game – iOS App (SwiftUI)

## 🃏 Overview

**Card Battle Game** is a simple turn-based iOS card game where a player competes against the computer (PC) in 10 rounds. In each round, both the player and the PC are dealt random cards, and the one with the higher card power wins the round. The game includes animations, sounds, and UI responsiveness for both light and dark modes.

---

## 🎥 Demo Video

https://drive.google.com/file/d/1EfS80wJyJkVepL99I9doqALMIQ5XfeUc/view?usp=drive_link


---

## 🎮 Features

- 🔁 10-card battle round system  
- 🎨 Dynamic card animations with flip sounds  
- 🔊 Background music during gameplay  
- 🧭 Automatic player-side assignment based on user location (East/West)  
- 📱 Fully responsive in both portrait and landscape orientations  
- 🌙 Supports Light Mode & Dark Mode  
- 📝 Name input saved via `UserDefaults` (only requested on first launch)  
- 📍 Location-based side assignment using Core Location  
- ✅ Game summary at the end with win/draw/lose message  
- 🎉 Victory sound when the player wins  
- ⏱️ Countdown timer for each round  
- 🛑 Pauses game logic and music when app is backgrounded  

---

## 🛠️ Technologies Used

- **SwiftUI** – for UI components and navigation  
- **AVFoundation** – for audio playback (sound effects and music)  
- **CoreLocation** – to detect the player's latitude and assign side  
- **UserDefaults** – to store player name  
- **Xcode Simulator** – for testing and debugging  

---

## 📂 Assets

- **Card Images** – e.g., `ace_of_spades`, `king_of_hearts`, etc.  
- **Sounds**:  
  - `cardFlip.wav` – played when cards are flipped  
  - `winnerSound.wav` – played if the player wins  
  - `backgroundMusic.mp3` – background music  
- **Earth Images (Welcome screen)**:  
  - `earth_day_left`, `earth_day_right`  
  - `earth_night_left`, `earth_night_right`  

---

## 🚀 Getting Started

1. Open the project in **Xcode**  
2. Ensure all `.wav` and `.mp3` sound files are added to the main bundle  
3. Run the app using the **iOS Simulator** or a real device  
4. Grant location permission when prompted  

---

## 🎯 How to Play

1. Enter your name (only on first launch)  
2. Based on your location, you’ll be assigned to **East Side** or **West Side**  
3. Watch the card battle unfold in each round  
4. After 10 rounds, the summary screen displays the winner  

---

## 📸 Simulator Recording

To record gameplay:  
- Use QuickTime or the Terminal command:  
  ```bash
  xcrun simctl io booted recordVideo game_demo.mov
