# Rule-Based Expert System for Carpet Problem
This project focuses on building an expert system that does not rely on a fixed algorithmic solution. Instead, it is based on **real expert knowledge**.
For the carpet fault–diagnosis domain, **my expert was my father** — a professional carpet specialist with over 37 years of experience. His practical knowledge served as the foundation for designing the rules and solutions used in this system.
This expert system asks a series of questions in sequence, and whenever the user confirms a condition, it provides the appropriate solution.

## :file_folder: Project Structure
```
carpet-expert-system/
|── carpet_rules.clp        # Main CLIPS file (rules + questions)
|── knowledge_base_notes.md
|── sample_run.txt
|   README.md  
``` 
## :hammer_and_wrench: Requirements
- CLIPS 6.4 or newer
- A terminal or CLIPS console
- No additional packages needed

## :inbox_tray: Install CLIPS
Install CLIPS from [here](https://www.clipsrules.net/?utm_source=chatgpt.com) to run the file.

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
- [Email](farimahnourpanah@gmail.com)
- [LinkedIn](https://www.linkedin.com/in/farimah-nourpanah)
