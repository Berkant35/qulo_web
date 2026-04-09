# Store Screenshot Seed Profiles — Design Spec

**Date:** 2026-04-09
**Branch:** APP-1915
**Status:** Approved

## Goal

Create 8 high-quality English female profiles for App Store / Play Store screenshot capture. Profiles must look premium, realistic, and showcase the app's question-based matching mechanic.

## Profiles

| # | Name | Age | City | Job | Zodiac | Relationship Goal |
|---|------|-----|------|-----|--------|-------------------|
| 1 | Sophia | 24 | New York | Fashion Designer | Libra | SERIOUS |
| 2 | Emma | 26 | London | Art Curator | Pisces | SERIOUS |
| 3 | Olivia | 23 | Paris | Photographer | Sagittarius | NOT_SURE |
| 4 | Isabella | 27 | Los Angeles | Yoga Instructor | Aquarius | SERIOUS |
| 5 | Mia | 25 | Barcelona | Interior Designer | Leo | FRIENDSHIP |
| 6 | Charlotte | 28 | Amsterdam | Marketing Director | Virgo | SERIOUS |
| 7 | Amelia | 22 | Milan | Dance Student | Aries | NOT_SURE |
| 8 | Luna | 26 | Sydney | Marine Biologist | Cancer | SERIOUS |

## Bio Style — Sophisticated & Minimal

Short, elegant bios that convey personality without trying too hard. Premium dating app feel.

Examples:
- "Art curator with a weakness for rooftop sunsets and good conversation."
- "Designing spaces by day, exploring hidden cafés by night."
- "Somewhere between the ocean and the next adventure."

## Question Style — Personality & Deep (Jealousy/Hype Triggers)

Each profile gets 3 questions. Questions should trigger curiosity, jealousy, and "I need to answer this" feeling.

Question pool (24 questions, 3 per profile):
- Relationship dynamics, loyalty tests, emotional intelligence
- Categories: personality, relationship, lifestyle
- Format: 4 answer choices, 1 correct, 30s time limit
- Locale: "en"

## Photos

- Source: Unsplash high-quality portrait photos
- 3-4 photos per profile
- URL format: `https://images.unsplash.com/photo-XXXX?w=800&q=80`
- Diverse ethnicity, style, and aesthetic
- Portrait orientation preferred (matches card UI)

## Technical Details

### User Fields
- `locale`: "en"
- `preferred_languages`: ["en"]
- `gender`: WOMAN
- `gender_pref`: MAN
- `email`: `store_01@qulo.test` → `store_08@qulo.test`
- `password`: `Test1234!`
- `email_verified`: true
- `profile_completion`: 75-90%
- `green_diamonds`: 10-30
- `is_online`: random (some online for green dot in screenshots)

### User Details
- `height`: 160-175 cm
- `zodiac`: as per profile table
- `job`: as per profile table
- `smoking`: mostly NO
- `alcohol`: SOMETIMES or NO
- `personality`: varied (Introvert/Extrovert/Ambivert)

### Location Coordinates
- New York: 40.7128, -74.0060
- London: 51.5074, -0.1278
- Paris: 48.8566, 2.3522
- Los Angeles: 34.0522, -118.2437
- Barcelona: 41.3874, 2.1686
- Amsterdam: 52.3676, 4.9041
- Milan: 45.4642, 9.1900
- Sydney: -33.8688, 151.2093

### Script
- File: `qulo-server/scripts/seed-store-profiles.ts`
- Independent from existing seed-test-users.ts
- Run: `npx tsx scripts/seed-store-profiles.ts`
- Delete: `npx tsx scripts/seed-store-profiles.ts --delete`
- Inserts into: `users`, `user_details`, `user_languages`, `questions`

## Out of Scope
- Male profiles (not needed for current screenshots)
- Chat/match mock data (screenshots of chat can use existing data)
- Localization (everything English-only)
