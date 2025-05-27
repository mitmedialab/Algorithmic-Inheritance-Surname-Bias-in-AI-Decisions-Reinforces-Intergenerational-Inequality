# Algorithmic Inheritance: Surname Bias in AI Decisions Reinforces Intergenerational Inequality

## Authors
- Pat Pataranutaporn (MIT)
- Nattavudh Powdthavee (NTU Singapore, IZA Bonn)  
- Pattie Maes (MIT)

## Abstract
Surnames often convey implicit markers of social status, wealth, and lineage, shaping perceptions in ways that can perpetuate systemic biases and intergenerational inequality. This study is the first of its kind to investigate whether and how surnames influence AI-driven decision-making, focusing on their effects across key areas such as hiring recommendations, leadership appointments, and loan approvals. Using 72,000 evaluations of 600 surnames from the United States and Thailand, two countries with distinct sociohistorical contexts and surname conventions, we classify names into four categories: Rich, Legacy, Normal, and phonetically similar Variant groups. Our findings show that elite surnames consistently increase AI-generated perceptions of power, intelligence, and wealth, which in turn influence AI-driven decisions in high-stakes contexts. Mediation analysis reveals perceived intelligence as a key mechanism through which surname biases influence AI decision-making process. While providing objective qualifications alongside surnames mitigates most of these biases, it does not eliminate them entirely, especially in contexts where candidate credentials are low. These findings highlight the need for fairness-aware algorithms and robust policy measures to prevent AI systems from reinforcing systemic inequalities tied to surnames, an often-overlooked bias compared to more salient characteristics such as race and gender. Our work calls for a critical reassessment of algorithmic accountability and its broader societal impact, particularly in systems designed to uphold meritocratic principles while counteracting the perpetuation of intergenerational privilege.

## Link to the Paper
https://arxiv.org/abs/2501.19407


## Requirements
pip install -r requirements.txt

## Data Structure
- `name/*.txt`: Surname categorization files
- `dataset/Thai/*.csv`: Thai surname analysis results
- `dataset/US/*.csv`: US surname analysis results
- `dataset/*.dta`: Merged analysis datasets

## Pipeline
1. `00_code_init_*.ipynb`: Data preprocessing
2. `01_code_OpenAI_*.ipynb`: OpenAI API interactions
3. Statistical analysis of results

## License
MIT License

## Contact
patpat@mit.edu and nick.powdthavee@ntu.edu.sg
