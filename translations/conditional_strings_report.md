# Conditional Strings Report

## Summary
- Known missed strings: 9
- Potential conditional strings: 24

## Pattern Categories

### 1. Age-based Conditionals
- `in their [age group]`
- `in your [age]s`

### 2. Score/Result Conditionals
- `That's a/an [quality] score!`
- `[percentage]% of [group]`
- `[number] out of [total]`

### 3. Time-based Conditionals
- `within [number] days`
- `after the [event]`

### 4. Personal/Dynamic Text
- `You deserve this, [Name]`
- `Hello/Welcome [Name]`

### 5. Urgency/Scarcity
- `Only [number] [items] remaining`
- `Hurry up!`

## Next Steps
1. Search for these patterns in all Flutter files
2. Add found strings to conditional_strings_mapping.json
3. Update robust_translation_system.py with translations
4. Test with different user conditions/states