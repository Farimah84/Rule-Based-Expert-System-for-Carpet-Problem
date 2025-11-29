# Title: Rule Based Expert System for Carpet Problem
### Autor: *Farimah Nourpanah*
### Course: *Artificial Intelligence and Expert System*
### Date: *November 2025*

## 1. Knowledge acquisition
- Sources: Interview with Mr. Nourpanah (expert), Book "Washing, care and maintenance of handmade carpets"

## 2. Categories
- Smell-types: smoke, chemical, urine, moistureer
- Color-types: ink-ball-point-pen, ink, crayon, paint-oil
- Glue: glue-hobby, glue-white
- Insects or Animals-types: spider-webs, cocoons, beetles, termites, dog-chewing, cat-scratching
-  Stains:
   1. Water based: tea, mixed-drinks-liqueurs, soft-drinks, food-dyes
   2. Oil based: butter, chocolate, ice-cream, grease-food, grease-auto, other
   3. Protein based: blood, milk
   4. Other: chewing-gum, nail-polish, vomit, urine, paint-latix, chalk
- Corners or Edges
- White Knots
- Moth Damage
- Color Burned
- Pile
- Torn
- Colors Bled
- Weave
- Thin
- Damages:
  1. Water
  2. Vacuum
  3. Sunlight
  4. Plantet pot
  5. Air Pollution
  6. Heat
  7. Light
  8. Moisture
- Wear
- Flattening

## 3. Rule format
```
(defrule ask-smell-type
   (smell yes)
   =>
   (bind ?type (ask "What type of smell is it?" (create$ smoke chemical urine moistureer)))
   (assert (smell ?type))
   (printout t "✔ Answer recorded: smell-type = " ?type crlf))
```
## 4. Solution Rules
```
(defrule chemical-smell
   (smell chemical)
   =>
   (printout t crlf
      "Solution: Avoid further chemical exposure; consult a specialist and consider professional cleaning." crlf)
      (assert (done)))
```

## 5. Reasoning Flow (Simplified)
```
START
 └── Smell?
       ├── Yes → Smell Type → Solution
       └── No → Color?
                ├── Yes → Color Type → Solution
                └── No → Insects/Animals?
                         ├── Yes → Type → Solution
                         └── No → Glue?
                                  ...
                                      └── No → No Problem
```
## 6. Example rules
- R1 | smell-type smoke | IF smell-type smoke oil THEN --> Solution: Air the carpet outdoors, use deep-cleaning or steam cleaning to remove residues.
- R14 | insects-or-animals-type dog-chewing | IF insects-or-animals-type dog-chewing THEN --> Solution: Sprinkle about 20 grams of moth flakes under the rug and along the edges to deter pets.

## 7. End Condition
```
(defrule no-problem
   (flatten no)
   =>
   (printout t crlf
      "No identifiable carpet issues detected." crlf))
```
