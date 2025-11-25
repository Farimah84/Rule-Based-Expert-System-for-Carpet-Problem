# Carpet Fault Diagnosis Expert System
An interactive rule-based expert system built with CLIPS that diagnoses common carpet problems (stains, odor, fiber damage, color issues, aging, moisture problems, etc.) using a structured question–answer dialogue.
This project simulates a real expert asking sequential questions, evaluating symptoms, and generating a final diagnosis and recommended solutions.

## :file_folder: Project Structure
```
carpet-expert-system/
│
├── carpet_rules.clp        # Main CLIPS file (rules + questions)
├── README.md               
└── sample_run.txt            
``` 
## :hammer_and_wrench: Requirements
- CLIPS 6.4 or newer
- A terminal or CLIPS console
- No additional packages needed

## :rocket: How to Run
1. Open CLIPS.
2. Load the expert system:
```
(load "carpet_rules.clp")
```
3. Initialize facts:
```
(reset)
```
4. Start diagnosis:
```
(run)
```
### The system will begin asking questions such as:
- Has the rug been damaged by insects or animals?
- Is there glue spillied on the carpet?
- Did an oil-based stain spill on the carpet?
- Has sunlight caused fading or damage to the rug?

## 	:scroll: License
MIT License — free to use, modify, and distribute.

## :bust_in_silhouette: Contact
Email: farimahnourpanah@gmail.com
