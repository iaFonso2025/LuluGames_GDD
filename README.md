# LuluGames_GDD

# Orc Clash – Game Design Document

## 1. General Information

- **Working title:** Orc Clash  
- **Genre:** 2D Turn-Based RPG  
- **Platform:** PC  
- **Engine:** Godot Engine 4.5.1  
- **Perspective:** 2D  
- **Project status:** Playable prototype  

---

## 2. Game Overview

Orc Clash is a 2D RPG game that combines free map exploration with turn-based combat. The player controls a character who moves through the environment, and when colliding with an enemy, a combat sequence is automatically triggered.

The game design focuses on clear mechanics and simple strategic decision-making, allowing only one action per turn.

---

## 3. Exploration Mechanics

- Free movement in a 2D map  
- Controls:
  - W: move up  
  - A: move left  
  - S: move down  
  - D: move right  
- Enemies are visible on the map  
- No combat during exploration  

---

## 4. Combat System

Combat starts automatically when the player collides with an enemy.

### Features

- 1 vs 1 combat  
- Turn-based system  
- One action per turn  
- Combat ends when one character reaches 0 health  

---

## 5. Characters

### 5.1 Player

**Attributes:**
- Name  
- Maximum health  
- Current health  

**Actions:**
- Light attack  
- Heavy attack  
- Ultimate attack  

---

### 5.2 Enemy – Orc

**Attributes:**
- Name  
- Maximum health  
- Current health  

**Actions:**
- Light attack  
- Heavy attack  

Enemy actions are selected using simple automatic logic.

---

## 6. Game Flow

1. Player spawns on the map  
2. Explores the environment  
3. Collides with an enemy  
4. Turn-based combat starts  
5. Combat ends with victory or defeat  
6. After victory, the player returns to the map  

---

## 7. User Interface

### Exploration
- Full-screen map view  

### Combat
- Player health bar  
- Enemy health bar  
- Action menu  
- Combat log messages  

---

## 8. Visual Style

- 2D graphics  
- Animated character sprites  
- Clear and functional visual design  

---

## 9. Technical Architecture

- Separate scenes for exploration and combat  
- Collision-based combat triggering  
- State-based game flow management  

---

## 10. Project Goal

To develop a functional turn-based RPG prototype demonstrating skills in game design, programming logic, and project structuring using Godot Engine.

---
**This document describes the game design, mechanics, and overall structure of the project.**
