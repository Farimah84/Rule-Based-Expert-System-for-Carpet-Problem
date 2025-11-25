# Carpet Fault Diagnosis Expert System
An interactive rule-based expert system built with CLIPS that diagnoses common carpet problems (stains, odor, fiber damage, color issues, aging, moisture problems, etc.) using a structured question–answer dialogue.
This project simulates a real expert asking sequential questions, evaluating symptoms, and generating a final diagnosis and recommended solutions.

## :file_folder: Project Structure
```
carpet-expert-system/
│
├── carpet_rules.clp        # Main CLIPS file (rules + questions)
├── README.md                # Documentation
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
