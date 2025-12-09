;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Carpet Expert System (Question-Based)
;; Asking multiple questions → diagnosing issue → recommending solution
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deffunction ask (?question ?choices)
   (printout t crlf ">> " ?question crlf)
   (printout t "   Options: " ?choices crlf)
   (printout t "   Enter your answer: ")
   (bind ?answer (read))
   (while (not (member$ ?answer ?choices)) do
      (printout t "   Invalid choice — please enter one of: " ?choices crlf)
      (printout t "   Enter your answer: ")
      (bind ?answer (read))
   )
   ?answer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule start
   =>
   (printout t crlf
      "==================================================" crlf
      "         CARPET PROBLEM EXPERT SYSTEM          " crlf
      "==================================================" crlf crlf
      "Welcome! Please answer the questions to diagnose." crlf crlf)
   (assert (begin)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question — Smell
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-smell
   ?b <- (begin)
   =>
   (retract ?b)
   (printout t crlf "------------------------" crlf)
   (printout t " Question: Bad Smell" crlf)
   (printout t "------------------------" crlf)
   (bind ?ans (ask "Does the carpet have a bad smell?" (create$ yes no)))
   (assert (smell ?ans))
   (printout t crlf "✔ Answer recorded: smell = " ?ans crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If smell = yes → ask smell-type
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     
(defrule ask-smell-type
   (smell yes)
   =>
   (bind ?type (ask "What type of smell is it?" (create$ smoke chemical urine moistureer)))
   (assert (smell ?type))
   (printout t "✔ Answer recorded: smell-type = " ?type crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Color type rules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule smoke-smell
   (smell smoke)
   =>
   (printout t crlf
      "Solution: Air the carpet outdoors, use deep-cleaning or steam cleaning to remove residues." crlf)
      (assert (done)))

(defrule chemical-smell
   (smell chemical)
   =>
   (printout t crlf
      "Solution: Avoid further chemical exposure; consult a specialist and consider professional cleaning." crlf)
      (assert (done)))

(defrule urine-smell
   (smell urine)
   =>
   (printout t crlf
      "Solution: Clean with vinegar solution, sprinkle baking soda, vacuum after a few hours; consult professional for severe cases." crlf)
      (assert (done)))

(defrule moisture-smell
   (smell moisture)
   =>
   (printout t crlf
      "Solution: Dry the carpet in a ventilated place or use industrial drying; reduce room humidity." crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If smell = no → ask about color
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question — Color
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-color
   (smell no)
   =>
   (printout t crlf "------------------------" crlf)
   (printout t " Question: Color Spill" crlf)
   (printout t "------------------------" crlf)
   (bind ?ans (ask "Has any kind of color or ink spilled on the carpet?" (create$ yes no)))
   (assert (color ?ans))
   (printout t crlf "✔ Answer recorded: color = " ?ans crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If color = yes → ask color-type
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-color-type
   (color yes)
   =>
   (bind ?type (ask "What type of color is it?" (create$ ink-ball-point-pen ink crayon paint-oil)))
   (assert (color ?type))
   (printout t "✔ Answer recorded: smell-type = " ?type crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Color type rules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ink-ball-point-pen-color
   (color ink-ball-point-pen)
   =>
   (printout t crlf
      "Solution: Lightly dampen a towel with a dry-cleaning solvent and wipe the stain." crlf)
      (assert (done)))

(defrule ink-color
   (color ink)
   =>
   (printout t crlf
      "Solution: Spray the area with a bit of hairspray, then clean it with a mix of water and vinegar." crlf)
      (assert (done)))

(defrule crayon-color
   (color crayon)
   =>
   (printout t crlf
      "Solution: Lightly dampen a towel with a dry-cleaning solvent and wipe the stain." crlf)
      (assert (done)))

(defrule paint-oil-color
   (color paint-oil)
   =>
   (printout t crlf
      "Solution: Lightly dampen a towel with a dry-cleaning solvent and wipe the stain." crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If color = no → ask about insects-or-animals
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — Insects or Animals
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-insects-or-animals
   (color no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: Insects or Animals" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Has the rug been damaged by insects or animals?" (create$ yes no)))
   (assert (insects-or-animals ?ans))  
   (printout t crlf "✔ Answer recorded: insects-or-animals = " ?ans crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If insects-or-animals = yes → ask insects-or-animals type
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-insects-or-animals-type
   (insects-or-animals yes)
   =>
   (bind ?type (ask "What type is it?" (create$ spider-webs cocoons beetles termites dog-chewing cat-scratching)))
   (assert (insects-or-animals ?type))
   (printout t "✔ Answer recorded: insects-or-animal-type = " ?type crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Insects or Animals type rules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule spider-webs-insects-or-animals
   (insects-or-animals spider-webs)
   =>
   (printout t crlf
      "Solution: Remove spider webs thoroughly using a vacuum or a soft brush." crlf)
      (assert (done)))

(defrule cocoons-insects-or-animals
   (insects-or-animals cocoons)
   =>
   (printout t crlf
      "Solution: Remove the cocoons, vacuum the area, and apply a fiber-safe insect spray." crlf)
      (assert (done)))

(defrule beetles-insects-or-animals
   (insects-or-animals beetles)
   =>
   (printout t crlf
      "Solution: Vacuum the area thoroughly, then use roach bait or spray around the room." crlf)
      (assert (done)))

(defrule termites-insects-or-animals
   (insects-or-animals termites)
   =>
   (printout t crlf
      "Solution: Clean the floor weekly and use termite-control treatments." crlf 
      "Identify the entry point and block it with physical barriers." crlf)
      (assert (done)))

(defrule dog-chewing-insects-or-animals
   (insects-or-animals dog-chewing)
   =>
   (printout t crlf
      "Solution: Sprinkle about 20 grams of moth flakes under the rug and along the edges to deter pets." crlf)
      (assert (done)))

(defrule cat-scratching-insects-or-animals
   (insects-or-animals cat-scratching)
   =>
   (printout t crlf
      "Solution: Brush the rug regularly and apply pet-safe deterrent sprays to prevent repeated scratching" crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If insects-or-animals = no → ask about glue
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — Glue
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-glue
   (insects-or-animals no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: Glue Spill" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Is there glue spillied on the carpet?" (create$ yes no)))
   (assert (glue ?ans))
   (printout t crlf "✔ Answer recorded: glue = " ?ans crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If Glue = yes → ask glue type
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-glue-type
   (glue yes)
   =>
   (bind ?type (ask "What type of glue is it?" (create$ glue-hobby glue-white)))
   (assert (glue ?type))
   (printout t "✔ Answer recorded: glue-type = " ?type crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Glue type rules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule glue-hobby-glue
   (glue glue-hobby)
   =>
   (printout t crlf
      "Solution: Use a cotton cloth with non-oily nail-polish remover to lift the residue." crlf 
      "Use a clean white paper towel to keep the stain from spreading." crlf 
      "Repeat the steps until all the adhesive is removed." crlf)
      (assert (done)))

(defrule glue-white-glue
   (glue glue-white)
   =>
   (printout t crlf
      "Solution: Sprinkle baking soda over the affected area. Once it dries, vacuum it." crlf 
      "Use a damp sponge to remove any remaining baking soda. Rinse the carpet with a cleaning solution and a damp towel." crlf 
      "After it dries, apply a dry-cleaning powder and vacuum it again." crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If glue = no → ask about water-based-stain
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — Water Based Stain
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-water-based-stain
   (glue no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: Water Based Stain" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Did a water-based stain spill on the carpet?" (create$ yes no)))
   (assert (water-based-stain ?ans))
   (printout t crlf "✔ Answer recorded: water-based-stain = " ?ans crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If water-based-stain = yes → ask water-based-stain type
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-water-based-stain-type
   (water-based-stain yes)
   =>
   (bind ?type (ask "What type of stain is it?" (create$ tea mixed-drinks-liqueurs soft-drinks food-dyes)))
   (assert (water-based-stain ?type))
   (printout t "✔ Answer recorded: water-based-stain-type = " ?type crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Water Based Stain type rules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule tea-water-based-stain
   (water-based-stain tea)
   =>
   (printout t crlf
      "Solution: With a damp towel, wipe the moisture from the carpet and clean the spot using a white-vinegar solution." crlf)
      (assert (done)))

(defrule mixed-drinks-liqueurs-water-based-stain
   (water-based-stain mixed-drinks-liqueurs)
   =>
   (printout t crlf
      "Solution: With a damp towel, wipe the moisture from the carpet and clean the spot using a white-vinegar solution." crlf)
      (assert (done)) )

(defrule soft-drinks-water-based-stain
   (water-based-stain soft-drinks)
   =>
   (printout t crlf
      "Solution: Sprinke dry baking soda on the affected area, and ones it's dry, vacuum it up." crlf)
      (assert (done)))

(defrule food-dyes-water-based-stain
   (water-based-stain food-dyes)
   =>
   (printout t crlf
      "Solution: Sprinke dry baking soda on the affected area, and ones it's dry, vacuum it up." crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If water-based-stain = no → ask about oil-based-stain
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — Oil Based Stain
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-oil-based-stain
   (water-based-stain no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: Oil Based Stain" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Did an oil-based stain spill on the carpet?" (create$ yes no)))
   (assert (oil-based-stain ?ans))
   (printout t crlf "✔ Answer recorded: oil-based-stain = " ?ans crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If oil-based-stain = yes → ask oil-based-stain type
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-oil-based-stain-type
   (oil-based-stain yes)
   =>
   (bind ?type (ask "What type of stain is it?" (create$ butter chocolate ice-cream grease-food grease-auto other)))
   (assert (oil-based-stain ?type))
   (printout t "✔ Answer recorded: oil-based-stain-type = " ?type crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Oil Based Stain type rules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule butter-oil-based-stain
   (oil-based-stain butter)
   =>
   (printout t crlf
      "Solution: Lightly dampen a towel with a dry-cleaning solvent and wipe the stain." crlf)
      (assert (done)))

(defrule chocolate-oil-based-stain
   (oil-based-stain chocolate)
   =>
   (printout t crlf
      "Solution: First, blot the stain with a cleaning solution and a damp towel." crlf 
      "Then clean the area with undiluted white vinegar, and finish by wiping the carpet with water and a damp sponge." crlf)
      (assert (done)))

(defrule ice-cream-oil-based-stain
   (oil-based-stain ice-cream)
   =>
   (printout t crlf
      "Solution: First, blot the stain with a cleaning solution and a damp towel." crlf 
      "Then clean the area with undiluted white vinegar, and finish by wiping the carpet with water and a damp sponge." crlf)
      (assert (done)))

(defrule grease-food-oil-based-stain
   (oil-based-stain grease-food)
   =>
   (printout t crlf
      "Solution: Lightly dampen a towel with a dry-cleaning solvent and wipe the stain." crlf)
      (assert (done)))

(defrule grease-auto-oil-based-stain
   (oil-based-stain grease-auto)
   =>
   (printout t crlf
   "Solution: Lightly dampen a towel with a dry-cleaning solvent and wipe the stain." crlf)
   (assert (done)))

(defrule other-oil-based-stain
   (oil-based-stain other)
   =>
   (printout t crlf
      "Solution: With a damp towel, wipe the moisture from the carpet and clean the spot using a white-vinegar solution." crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If oil-based-stain = no → ask about protein-based-stain
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — Protein Based Stain
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-protein-based-stain
   (oil-based-stain no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: Protein Based Stain" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Did a protein-based stain spill on the carpet?" (create$ yes no)))
   (assert (protein-based-stain ?ans))
   (printout t crlf "✔ Answer recorded: protein-based-stain = " ?ans crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If protein-based-stain = yes → ask protein-based-stain type
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-protein-based-stain-type
   (protein-based-stain yes)
   =>
   (bind ?type (ask "What type is it?" (create$ blood milk)))
   (assert (protein-based-stain ?type))
   (printout t "✔ Answer recorded: protein-based-stain-type = " ?type crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Protein Based Stain type rules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule blood-protein-based-stain
   (protein-based-stain blood)
   =>
   (printout t crlf
      "Solution: With a damp towel, wipe the moisture from the carpet and clean the spot using a white-vinegar solution." crlf)
      (assert (done)))

(defrule milk-protein-based-stain
   (protein-based-stain milk)
   =>
   (printout t crlf
      "Solution: First, blot the stain with a cleaning solution and a damp towel." crlf 
      "Then clean the area with undiluted white vinegar, and finish by wiping the carpet with water and a damp sponge." crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If protein-based-stain = no → ask about other-stain
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — Other Stain
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-other-stain
   (protein-based-stain no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: Other Stain" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Is there other type of stain?" (create$ yes no)))
   (assert (other-stain ?ans))
   (printout t crlf "✔ Answer recorded: other-stain = " ?ans crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If other-stain = yes → ask other-stain type
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-other-stain-type
   (other-stain yes)
   =>
   (bind ?type (ask "What type of stain is it?" (create$ chewing-gum nail-polish vomit urine paint-latix chalk)))
   (assert (other-stain ?type))
   (printout t "✔ Answer recorded: other-stain-type = " ?type crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Other Stain type rules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
(defrule chewing-gum-other-stain
   (other-stain chewing-gum)
   =>
   (printout t crlf
      "Solution: Scrape off the excess material from the carpet, then freeze it using small ice cubes. " crlf
      "Crush it with the back of a large spoon, and vacuum the pieces before they melt." crlf)
      (assert (done)))

(defrule nail-polish-other-stain
   (other-stain nail-polish)
   =>
   (printout t crlf
      "Solution: Use a cotton cloth with non-oily nail-polish remover to lift the residue." crlf 
      "Use a clean white paper towel to keep the stain from spreading." crlf 
      "Repeat the steps until all the adhesive is removed." crlf)
      (assert (done)))

(defrule vomit-other-stain
   (other-stain vomit)
   =>
   (printout t crlf
      "Solution: Sprinkle baking soda over the affected area. Once it dries, vacuum it." crlf 
      "Use a damp sponge to remove any remaining baking soda. Rinse the carpet with a cleaning solution and a damp towel." crlf
      "After it dries, apply a dry-cleaning powder and vacuum it again." crlf)
      (assert (done)))

(defrule urine-other-stain
   (other-stain urine)
   =>
   (printout t crlf
      "Solution: First, blot the stain with a cleaning solution and a damp towel." crlf 
      "Then clean the area with undiluted white vinegar, and finish by wiping the carpet with water and a damp sponge." crlf)
      (assert (done)))

(defrule paint-latix-other-stain
   (other-stain paint-latix)
   =>
   (printout t crlf
      "Solution: First, blot the stain with a cleaning solution and a damp towel." crlf
      "Then clean the area with undiluted white vinegar, and finish by wiping the carpet with water and a damp sponge." crlf)
      (assert (done)))

(defrule chalk-other-stain
   (other-stain chalk)
   =>
   (printout t crlf
      "Solution: Vacuum as much of the chalk dust as possible." crlf 
      "Gently break the remaining chalk by tapping it with a soft-bristle brush." crlf 
      "Apply a dry-cleaning powder and let it sit on the carpet for one hour." crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If other-stain = no → ask about corners-or-edges
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — Corners or Edges
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-corners-or-edges
   (other-stain no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: Corners or Edges" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Are the rug’s corners or edges curled or warped?" (create$ yes no)))
   (assert (corners-or-edges ?ans))
   (printout t crlf "✔ Answer recorded: corners-or-edges = " ?ans crlf))

(defrule corners-or-edges-yes
   (corners-or-edges yes)
   =>
   (printout t crlf
      "Solution: Slightly open a few points along the edge to release the tight weft threads," crlf 
      "Then sew the edges back to restore their shape." crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If corners-or-edges = no → ask about white-knots
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — White Knots
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-white-knots
   (corners-or-edges no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: White Knots" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Are white knots appearing on the rug?" (create$ yes no)))
   (assert (white-knots ?ans))
   (printout t crlf "✔ Answer recorded: white-knots = " ?ans crlf))

(defrule white-knots-yes
   (white-knots yes)
   =>
   (printout t crlf
      "Solution: Gently open and tidy the fibers using a small, sharp pair of scissors." crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If white-knots = no → ask about moth-damage
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — Moth Damage
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-moth-damage
   (white-knots no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: Moth Damage" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Has the rug been affected by moth damage?" (create$ yes no)))
   (assert (moth-damage ?ans))
   (printout t crlf "✔ Answer recorded: moth-damage = " ?ans crlf))

(defrule moth-damage-yes
   (moth-damage yes)
   =>
   (printout t crlf
      "Solution: Vacuum the back, underside, and surface weekly." crlf
      "Use a non-staining insect spray for areas that cannot be vacuumed." crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If moth-damage = no → ask about color-burned
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — Color Burned
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-color-burned
   (moth-damage no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: Color Burned" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Has the rug’s color been burned or permanently damaged?" (create$ yes no)))
   (assert (color-burned ?ans))
   (printout t crlf "✔ Answer recorded: color-burned = " ?ans crlf))

(defrule color-burned-yes
   (color-burned yes)
   =>
   (printout t crlf
      "Solution: If the fibers and dyes are burned, the damage is permanent and cannot be restored." crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If color-burned = no → ask about pile
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — Pile
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-pile
   (color-burned no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: Pile" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Has the rug’s pile become flattened or reversed?" (create$ yes no)))
   (assert (pile ?ans))
   (printout t crlf "✔ Answer recorded: pile = " ?ans crlf))

(defrule pile-yes
   (pile yes)
   =>
   (printout t crlf
      "Solution: Brush it gently in the direction of the weave. For heavy flattening, light steaming can help." crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If pile = no → ask about torn
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — Torn
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-torn
   (pile no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: Torn" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Has the rug torn?" (create$ yes no)))
   (assert (torn ?ans))
   (printout t crlf "✔ Answer recorded: torn = " ?ans crlf))

(defrule torn-yes
   (torn yes)
   =>
   (printout t crlf
      "Solution: A skilled weaver must re-weave and repair the damaged area using matching yarn." crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If torn = no → ask about Colors color-bled
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — Colors Bled
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-color-bled
   (torn no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: Colors Bled" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Have the rug’s colors bled or run?" (create$ yes no)))
   (assert (color-bled ?ans))
   (printout t crlf "✔ Answer recorded: color-bled = " ?ans crlf))

(defrule color-bled-yes
   (color-bled yes)
   =>
   (printout t crlf
      "Solution: Add some vinegar to the wash water before cleaning the rug to help stabilize the dyes." crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If color-bled = no → ask about weave
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — Weave
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-weave
   (color-bled no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: Weave" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Has the weave been distorted due to excessive tension?" (create$ yes no)))
   (assert (weave ?ans))
   (printout t crlf "✔ Answer recorded: weave = " ?ans crlf))

(defrule weave-yes
   (weave yes)
   =>
   (printout t crlf
      "Solution: Lay the rug flat and gently realign it. Severe cases require structural re-weaving." crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If weave = no → ask about thin
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — Thin
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-thin
   (weave no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: Thin" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Has the rug become thin or worn down?" (create$ yes no)))
   (assert (thin ?ans))
   (printout t crlf "✔ Answer recorded: thin = " ?ans crlf))

(defrule thin-yes
   (thin yes)
   =>
   (printout t crlf
      "Solution: Dye the exposed warp and weft threads with matching colors to improve its appearance." crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If thin = no → ask about water-damage
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — Water Damage
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-water-damage
   (thin no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: Water Damage" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Has the rug suffered water damage?" (create$ yes no)))
   (assert (water-damage ?ans))
   (printout t crlf "✔ Answer recorded: water-damage = " ?ans crlf))

(defrule water-damage-yes
   (water-damage yes)
   =>
   (printout t crlf
      "Solution: Remove it from the damp area and let it dry completely in open air." crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If water-damage = no → ask about vacuum-damage
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — Vacuum Damage
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-vacuum-damage
   (water-damage no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: Vacuum Damage" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Has the vacuum cleaner damaged the rug?" (create$ yes no)))
   (assert (vacuum-damage ?ans))
   (printout t crlf "✔ Answer recorded: vacuum-damage = " ?ans crlf))

(defrule vacuum-damage-yes
   (vacuum-damage yes)
   =>
   (printout t crlf
      "Solution: Avoid rotating brushes or harsh attachments. Trim loose fibers carefully with scissors." crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If vacuum-damage = no → ask about sunlight-damage
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — Sunlight Damage
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-sunlight-damage
   (vacuum-damage no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: Sunlight Damage" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Has sunlight caused fading or damage to the rug?" (create$ yes no)))
   (assert (sunlight-damage ?ans))
   (printout t crlf "✔ Answer recorded: sunlight-damage = " ?ans crlf))

(defrule sunlight-damage-yes
   (sunlight-damage yes)
   =>
   (printout t crlf
      "Solution: Flip the rug to even out the color. Use sheer curtains to reduce direct sunlight exposure." crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If sunlight-damage = no → ask about plant-damage
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — Plant Damage
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-plant-damage
   (sunlight-damage no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: Plant Damage" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Has the rug rotted under a plant pot?" (create$ yes no)))
   (assert (plant-damage ?ans))
   (printout t crlf "✔ Answer recorded: plant-damage = " ?ans crlf))

(defrule plant-damage-yes
   (plant-damage yes)
   =>
   (printout t crlf
      "Solution: The damaged area must be re-woven." crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If plant-damage = no → ask about air-pollution-damage
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — Air Pollution Damage
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-air-pollution-damage
   (plant-damage no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: Air Pollution Damage" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Has air pollution damaged the rug?" (create$ yes no)))
   (assert (air-pollution-damage ?ans))
   (printout t crlf "✔ Answer recorded: air-pollution-damage = " ?ans crlf))

(defrule air-pollution-damage-yes
   (air-pollution-damage yes)
   =>
   (printout t crlf
      "Solution: Remove it from the contaminated area and air it out outdoors" crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If air-pollution-damage = no → ask about heat-damage
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — Heat Damage
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-heat-damage
   (air-pollution-damage no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: Heat Damage" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Has heat or humidity damaged the rug?" (create$ yes no)))
   (assert (heat-damage ?ans))
   (printout t crlf "✔ Answer recorded: heat-damage = " ?ans crlf))

(defrule heat-damage-yes
   (heat-damage yes)
   =>
   (printout t crlf
      "Solution: Store the rug in a cool, dry environment and avoid prolonged exposure to steam or direct heat." crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If heat-damage = no → ask about light-damage
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — Light Damage
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-light-damage
   (heat-damage no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: Light Damage" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Has light exposure caused damage to the rug?" (create$ yes no)))
   (assert (light-damage ?ans))
   (printout t crlf "✔ Answer recorded: light-damage = " ?ans crlf))

(defrule light-damage-yes
   (light-damage yes)
   =>
   (printout t crlf
      "Solution: Keep it away from direct light and use protective window films." crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If light-damage = no → ask about moisture-damage
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — Moisture Damage
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-moisture-damage
   (light-damage no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: Moisture Damage" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Has moisture or water repeatedly damaged the rug?" (create$ yes no)))
   (assert (moisture-damage ?ans))
   (printout t crlf "✔ Answer recorded: moisture-damage = " ?ans crlf))

(defrule moisture-damage-yes
   (moisture-damage yes)
   =>
   (printout t crlf
      "Solution: Move it regularly to ensure even drying and allow it to air out." crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If moisture-damage = no → ask about wear
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — Wear
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-wear-damage
   (moisture-damage no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: Wear" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Has the rug developed uneven or localized wear?" (create$ yes no)))
   (assert (wear-damage ?ans))
   (printout t crlf "✔ Answer recorded: wear-damage = " ?ans crlf))

(defrule wear-damage-yes
   (wear-damage yes)
   =>
   (printout t crlf
      "Solution: Rotate the rug once or twice a year and avoid placing it on irregular surfaces" crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If wear-damage = no → ask about flatten
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question  — Flattening
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule ask-flatten
   (wear-damage no)
   =>
   (printout t crlf "------------------------------" crlf)
   (printout t " Question: Flattening" crlf)
   (printout t "------------------------------" crlf)
   (bind ?ans (ask "Is the carpet surface flattened in some areas?" (create$ yes no)))
   (assert (flatten ?ans))
   (printout t crlf "✔ Answer recorded: flatten = " ?ans crlf))

(defrule flatten-yes
   (flatten yes)
   =>
   (printout t crlf
      "Solution: Apply gentle steam and brush the fibers upward with a soft carpet brush." crlf)
      (assert (done)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; No problems detected
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule no-problem
   (flatten no)
   =>
   (printout t crlf
      "Solution: No identifiable carpet issues detected." crlf)
      (assert (done)))


(defrule end-message
   ?d <- (done)
   =>
   (retract ?d)
   (printout t "--------------------------------------------------" crlf)
   (printout t "     Thank you for using the expert system!" crlf)
   (printout t "--------------------------------------------------" crlf crlf)

)


