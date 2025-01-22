# AI Biases Towards Rich and Powerful Surnames

## Authors
- Pat Pataranutaporn (MIT)
- Nattavudh Powdthavee (NTU Singapore, IZA Bonn)  
- Pattie Maes (MIT)

## Abstract
We investigate surname-based biases in AI decision-making across hiring, leadership, and loan contexts. Analyzing 600 surnames from the US and Thailand, we find elite surnames consistently predict AI-generated perceptions of power, intelligence, and wealth. While objective qualifications reduce these biases, they persist especially with low credentials.

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


## Project Structure

├── code/
│   ├── Thai/
│   │   ├── 00_code_init_lastname.ipynb
│   │   ├── 00_code_init_profile.ipynb
│   │   ├── 01_code_OpenAI_bad_profiles.ipynb
│   │   ├── 01_code_OpenAI_good_profiles.ipynb
│   │   ├── 01_code_OpenAI_lastnames.ipynb
│   │   └── 01_code_OpenAI_middle_profiles.ipynb
│   └── US/
│       ├── 00_code_init_lastname.ipynb
│       ├── 00_code_init_profile.ipynb
│       ├── 01_code_OpenAI_bad_profiles.ipynb
│       ├── 01_code_OpenAI_good_profiles.ipynb
│       ├── 01_code_OpenAI_lastnames.ipynb
│       └── 01_code_OpenAI_middle_profiles.ipynb
├── dataset/
│   ├── merged_badprofile.dta
│   ├── merged_goodprofile.dta
│   ├── merged_mediumprofile.dta
│   ├── merged_noprofile.dta
│   ├── Thai/
│   │   ├── Thai_processed_output_bad_profiles.csv
│   │   ├── Thai_processed_output_good_profiles.csv
│   │   ├── Thai_processed_output_medium_profiles.csv
│   │   └── Thai_processed_output_updated_lastnames.csv
│   └── US/
│       ├── US_processed_output_bad_profiles.csv
│       ├── US_processed_output_good_profiles.csv
│       ├── US_processed_output_medium_profiles.csv
│       └── US_processed_output_updated_lastnames.csv
└── name/
├── legacy_variants.txt
├── normal_variants.txt
├── rich_variants.txt
└── requirements.txt