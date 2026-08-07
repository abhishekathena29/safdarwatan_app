---
name: Safar Dar Watan Archive
colors:
  surface: '#fcf9f2'
  surface-dim: '#dcdad3'
  surface-bright: '#fcf9f2'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f6f3ec'
  surface-container: '#f1eee7'
  surface-container-high: '#ebe8e1'
  surface-container-highest: '#e5e2db'
  on-surface: '#1c1c18'
  on-surface-variant: '#56423e'
  inverse-surface: '#31312c'
  inverse-on-surface: '#f3f0e9'
  outline: '#89726d'
  outline-variant: '#dcc0ba'
  surface-tint: '#9d422c'
  primary: '#6d200d'
  on-primary: '#ffffff'
  primary-container: '#8c3621'
  on-primary-container: '#ffb29f'
  inverse-primary: '#ffb4a2'
  secondary: '#7f5700'
  on-secondary: '#ffffff'
  secondary-container: '#febe50'
  on-secondary-container: '#724d00'
  tertiary: '#194231'
  on-tertiary: '#ffffff'
  tertiary-container: '#325947'
  on-tertiary-container: '#a3ceb7'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#ffdad2'
  primary-fixed-dim: '#ffb4a2'
  on-primary-fixed: '#3c0700'
  on-primary-fixed-variant: '#7e2c17'
  secondary-fixed: '#ffdead'
  secondary-fixed-dim: '#fbbb4d'
  on-secondary-fixed: '#281900'
  on-secondary-fixed-variant: '#604100'
  tertiary-fixed: '#c1ecd4'
  tertiary-fixed-dim: '#a5d0b9'
  on-tertiary-fixed: '#002114'
  on-tertiary-fixed-variant: '#274e3d'
  background: '#fcf9f2'
  on-background: '#1c1c18'
  surface-variant: '#e5e2db'
typography:
  display-lg:
    fontFamily: Playfair Display
    fontSize: 48px
    fontWeight: '900'
    lineHeight: '1.1'
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Playfair Display
    fontSize: 32px
    fontWeight: '700'
    lineHeight: '1.2'
  headline-lg-mobile:
    fontFamily: Playfair Display
    fontSize: 28px
    fontWeight: '700'
    lineHeight: '1.2'
  title-md:
    fontFamily: Playfair Display
    fontSize: 22px
    fontWeight: '600'
    lineHeight: '1.4'
  body-lg:
    fontFamily: Work Sans
    fontSize: 18px
    fontWeight: '400'
    lineHeight: '1.6'
  body-md:
    fontFamily: Work Sans
    fontSize: 16px
    fontWeight: '400'
    lineHeight: '1.6'
  label-sm:
    fontFamily: Space Mono
    fontSize: 12px
    fontWeight: '500'
    lineHeight: '1.0'
    letterSpacing: 0.05em
rounded:
  sm: 0.125rem
  DEFAULT: 0.25rem
  md: 0.375rem
  lg: 0.5rem
  xl: 0.75rem
  full: 9999px
spacing:
  unit: 4px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 40px
  margin-mobile: 20px
  gutter-mobile: 12px
---

## Brand & Style
The design system is built on the concept of "Digital Heirloom." It prioritizes an intimate, tactile experience that bridges the gap between a modern mobile interface and a weathered physical archive. The brand personality is proud, resilient, and deeply nostalgic, functioning as a bridge for the Kashmiri diaspora to return "home" through a screen.

The visual style is a sophisticated blend of **Artisanal Minimalism** and **Vintage Editorial**. It rejects the sterile "tech" look in favor of a textured, human-centric aesthetic inspired by hand-painted shop signs, old literary journals, and the intricate craftsmanship of Kashmiri heritage. Every interaction should feel like turning the page of a well-loved book or unfolding a preserved map.

## Colors
The palette is rooted in the natural and architectural landscape of Kashmir. 

- **Primary (Terracotta):** Used for primary actions and key brand moments, evoking sun-dried clay and warmth.
- **Secondary (Saffron Ochre):** Used for highlighting and active states, representing the region's prized harvest.
- **Tertiary (Deep Emerald):** A rich, jewel-toned green reserved for archive categories and cultural significance.
- **Neutral (Aged Paper):** The primary background color is not a pure white, but a warm, slightly grainy off-white that reduces eye strain and provides a vintage "archival" base.
- **Charcoal:** Used for primary text to maintain high legibility while appearing softer and more organic than pure black.

## Typography
The typography strategy creates a tension between the "old world" and "modern utility."

- **Headlines:** Use **Playfair Display** for its elegant, high-contrast serif qualities that echo heritage and luxury. Large headings should use tight letter spacing to feel like editorial titles.
- **Body:** **Work Sans** provides a neutral, highly legible contrast to the decorative serifs, ensuring that long archival descriptions remain comfortable to read on mobile screens.
- **Labels & Metadata:** **Space Mono** is used for technical data, dates, and "item IDs" to reinforce the feeling of a catalogued archive or a typewriter-set index card.

## Layout & Spacing
The layout follows a **Fluid Grid** model with an emphasis on asymmetric "white space" (negative space) to avoid the cramped feeling of traditional database apps.

- **Grid:** A 4-column mobile grid with generous 20px side margins.
- **Rhythm:** Elements should feel "placed" rather than "snapped." Use intentional overlapping (e.g., a label slightly cutting into an image) to mimic the way physical artifacts might be layered on a desk.
- **Density:** High whitespace around headlines, but tighter, high-density spacing within "Archive Cards" to create a sense of information richness.

## Elevation & Depth
Depth in this design system is achieved through **Tonal Layering** and **Materiality** rather than realistic light-source shadows.

- **Surface Tiers:** The "Aged Paper" background is the base. Elements placed on top use very subtle, low-opacity charcoal borders (0.5px) rather than heavy drop shadows.
- **Subtle Grain:** A global, low-opacity grain overlay (CSS noise) is applied to all surfaces to give them a tactile, paper-like quality.
- **Interaction Depth:** When pressed, elements do not "lift" with a shadow; instead, they shift slightly in position (1-2px offset) to mimic the tactile feel of a physical stamp or a button being depressed into a surface.

## Shapes
The shape language is primarily **Soft (0.25rem)**, moving away from the perfect circles of modern UI.

- **Irregular Borders:** Use SVGs or clip-paths to create slightly "wobbly" or "rough-cut" edges for primary container cards, suggesting hand-made paper.
- **Dividers:** Instead of clean horizontal lines, use "sketch-style" dividers that look like thin charcoal strokes or decorative Kashmiri geometric patterns.
- **Images:** Archive images should use a very slight inner "vignette" or rounded corners to feel like physical printed photographs.

## Components
### Archive Cards
The central component. It uses a thin charcoal border, a small padding-top for a metadata label in Space Mono, and a high-contrast serif title. Images within cards should have a subtle "faded" filter until hovered/tapped.

### Buttons
Primary buttons are solid Terracotta with the label in Space Mono. They should not have rounded corners (0px) but may have a "double-border" effect (a 1px offset outline) to look like a vintage ticket or stamp.

### Navigation
The bottom navigation bar uses a semi-transparent blur over the Aged Paper background. Icons are "sketch-like" or hand-drawn in style, appearing as if they were inked onto the screen.

### Input Fields
Inputs are simple underlined fields (vintage ledger style) rather than enclosed boxes. The focus state changes the underline from charcoal to Saffron Ochre.

### Chips & Tags
Used for categories like "Poetry" or "Crafts." These use the Tertiary Emerald or Secondary Saffron colors with a very low opacity background and high-contrast text, appearing like small wax seals or fabric tags attached to an item.