# Exercise  1: Variables
trial_id = "NCT04280705"
sponsor_name = "Gilead Sciences"
start_year = 2020
industry_sponsored = True

print(trial_id)
print(sponsor_name)
print(start_year)
print(industry_sponsored)

print(type(trial_id))
print(type(sponsor_name))
print(type(start_year))
print(type(industry_sponsored))

# type() function is used to check the data type of a variable. In this case, trial_id and sponsor_name are strings, start_year is an integer, and industry_sponsored is a boolean.

# Exercise 2: Lists
conditions = ["COVID-19", "HIV", "Cancer", "Diabetes"]
print(conditions)
print(type(conditions))

print(conditions[0])  # Accessing the first element
print(conditions[1])  # Accessing the second element    
print(conditions[2])  # Accessing the third element
print(conditions[3])  # Accessing the fourth element

conditions.append("Heart Disease")  # Adding a new condition to the lis

print(conditions)
print(len(conditions))  # Checking the length of the list

# Exercise 3: Dictionaries
trial = {
    "trial_id": "NCT04280705",
    "sponsor_name": "Gilead Sciences",
    "start_year": 2020,
    "industry_sponsored": True
}

print(trial)
print(type(trial))

print(trial["trial_id"])  # Accessing the value associated with the key "trial_id"
print(trial["sponsor_name"])  # Accessing the value associated with the key "sponsor_name"
print(trial["start_year"])  # Accessing the value associated with the key "start_year"
print(trial["industry_sponsored"])  # Accessing the value associated with the key "industry_sponsored"
trial["country"] = "United States"  # Adding a new key-value pair to the dictionary
print(trial)

trial["phase"] = "Phase 3"  # Adding another key-value pair to the dictionary
print(trial["phase"])  # Accessing the value associated with the key "phase"

#Exercise 4: Tuples and Sets
study_years =(2015, 2020, 2025)

print(study_years)
print(type(study_years))

print(study_years[0])  # Accessing the first element

countries = {"United Kingdom", "United States", "France", "United Kingdom"}  # Creating a set with duplicate value
print(countries)
print(type(countries))
# set automatically removes duplicate values, so "United Kingdom" will only appear once in the set.
# going to become useful later when wanting to find the unique countries represented in a clinical trial dataset.

countries.add("Germany")  # Adding a new country to the set
print(countries)
print(len(countries))  # Checking the length of the set

# Exercise 5: Conditions
phase = "Phase 3"
if phase == "Phase 3":
    print("Late-stage clinical trial")
else:
    print("Not a Phase 3 trial")

start_year = 2020
if start_year >= 2025:
    print("Very recent study")
elif start_year >= 2015:
    print("Study meets project data criteria")
else:
    print("Study is outside project scope")

Industry_sponsored = True
if Industry_sponsored:
    print("Include in Project")
else:
    print("Exclude from Project")

# Exercise 6: Loops
conditions = ["COVID-19", "HIV", "Cancer", "Diabetes"]
for condition in conditions:
    print(condition)

for condition in conditions:
    if condition == "Cancer":
        print("- priority condition")
    else:
        print(condition)

# useful because we can use loops through APU results and apply logic to each record

study_years= [2014, 2016, 2020, 2026]
for year in study_years:
    if year >= 2015:
        print(year, "-include")
    else:
        print(year, "-exclude")

# Exercise 7: Functions
def check_study_year(start_year):
    if start_year>= 2015:
        return "Include in Project"
    else:
        return "Exclude from Project"

# def means we are defining a function called check_study_year that takes one parameter, start_year. The function checks if the start_year is greater than or equal to 2015 and returns a string indicating whether to include or exclude the study from the project.
# return statement is used to send the result back to the caller of the function.
print(check_study_year(2020))  # Calling the function with start_year = 2020
print(check_study_year(2012))  # Calling the function with start_year = 2012

def create_trial_label(trial_id, sponsor_name):
    return trial_id+ " - " + sponsor_name

print(create_trial_label("NCT04280705", "Gilead Sciences"))  # Calling the function with trial_id and sponsor_name

def check_industry_sponsored(industry_sponsored):
    if industry_sponsored:
        return "industry study"
    else:
        return "non-industry study"

print(check_industry_sponsored(True))  # Calling the function with industry_sponsored = True
print(check_industry_sponsored(False))  # Calling the function with industry_sponsored = False

#Exercise 8: Imports
import math
print(math.sqrt(25))  # Using the sqrt function from the math module to calculate the square root of 25

from datetime import date
today = date.today()
print(today)  # Printing the current date
print(type(today))  # Checking the type of the today variable, which is a date object

import os
print(os.getcwd())  # Printing the current working directory

# Exercise 9: Exceptions
try:
    study_year = int("2020")  # Converting a string to an integer
    print(study_year)
except ValueError:
    print("Invalid study year")  # Handling the ValueError exception if the conversion fail

# the structure is a try-except block, where the code inside the try block is executed, and if an exception occurs, the code inside the except block is executed instead. In this case, if the conversion of the string "2020" to an integer fails, a ValueError will be raised, and the message "Invalid study year" will be printed.

trial = {
    "trial_id": "NCT04280705",
    "start_year": 2020
}

try:
    print(trial["sponsor_name"])  # Trying to access a key that doesn't exist in the dictionary
except KeyError:
    print("Sponsor name is missing")  # Handling the KeyError exception if the key doesn't exist

trial = {
    "trial_id": "NCT04280705",
}

try:
    print(trial["phase"])  # Trying to access a key that doesn't exist in the dictionary
except KeyError:
    print("Phase is missing")  # Handling the KeyError exception if the key doesn't exist

# Exercise 10: Environment Variables
import os
project_name = os.getenv("PROJECT_NAME", "Clinical Trials Project")
print(project_name)  # Printing the value of the environment variable PROJECT_NAME

#os.getenv() is used to retrieve the value of an environment variable. If the environment variable is not set, it will return the default value provided as the second argument, which in this case is "Clinical Trials Project".
