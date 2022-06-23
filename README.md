# TUITION PARSER
This Ruby script process all the xlsx files in a folder (expecting to be response files from tuition providers 
all sticking to the same template) and aggregates the parsed information into several csv files.

Validation errors are displayed in the case of issues finding, accessing or parsing the spreadsheets in the given path.

## Implementation
The implementation is based in several components:
- A simple Ruby script located in /bin folder that delegates the parsing  job to the next 2 Ruby classes and displays stats with the results.

- The `FolderParser` class that finds the spreadsheets files and stores extracted data models in memory data structures during the parsing process.

- The `FileParser` the main class that opens a file and extract provider details, pricing and locations served by the tuition provider.  

- The `roo` gem (open source library) to read and deal with spreadsheets in Ruby.  

- The `csv` standard Ruby library to generate csv files.

- Several Service and Report classes to help in the generation of csv files from the extracted Ruby objects. 

## Installation

### Clone the repository

```shell
git clone git@github.com:DFE-Digital/tuition_parser.git
cd tuition_parser
```

### Install Ruby

If Ruby runtime is not installed in your machine, please install it first.
Some popular ruby version managers might be helpful: [rbenv](https://github.com/rbenv/rbenv), [rvm](https://rvm.io/)

### Install  dependencies

You will need [Bundler](https://github.com/bundler/bundler) gem to install Ruby dependencies.
In the root directory of the cloned script check it is installed and accessible typing: 
 ```shell
 bundle -v
 ```  

Install it if you need to:
  ```shell
  gem install bundler
  ```

Once installed, the next command will install all Ruby dependencies for the script to run properly
```shell
bundle install
```

## Run the script

```shell
./bin/parse.rb path_to_spreadsheets_folder
```

Depending on the contents of your folder it will display something similar to:
```shell
~/scripts/tuition_parser $ ./bin/parse.rb ../../spreadsheets
Installing dependencies...
Processing /Users/ltello/spreadsheets/Provider1.xlsx
Processing /Users/ltello/spreadsheets/Provider2.xlsx
Processing /Users/ltello/spreadsheets/Provider3.xlsx
Processing /Users/ltello/spreadsheets/Provider4.xlsx
Processing /Users/ltello/spreadsheets/Provider5.xlsx
Providers: 36 (Check generated file: /Users/ltello/spreadsheets/providers.csv)
Prices: 2588 (Check generated file: /Users/ltello/spreadsheets/prices.csv)
Regions: 9 (Check generated file: /Users/ltello/spreadsheets/regions.csv)
LADs: 309 (Check generated file: /Users/ltello/spreadsheets/lads.csv)
Locations: 599 (Check generated file: /Users/ltello/spreadsheets/locations.csv)
~/scripts/tuition_parser $
```
