#-----------------------------------------#
#### PART 1.2: CHANGING CASE
#-----------------------------------------#

## Sometimes we find our character values aren't synchronized to one format, so we have to modify names individually. However, with these specific stringr functions involving case changes, we can unify character values in one step. 

## TASK: Let's start by identifying some fundamental functions that we can use. Run the code below to create a set of character values.

case_names <- c("layne staley", "JERRY CANTRELL", "MIKE inez", "SeAn KiNnEy")

## TASK: Run the following seven functions, and answer the question at the end of the list of functions either during or after this process.

str_to_upper(case_names)

str_to_lower(case_names)

str_to_title(case_names)

str_to_sentence(case_names)

str_to_camel(case_names)

str_to_snake(case_names)

str_to_kebab(case_names)

## QUESTION: What happened to the case_names values in reference to each function that you ran?

## ANSWER: str_to_upper makes all the words uppercase. str_to_lower makes all the words lowercase. str_to_title makes each first letter after a space capitalized. str_to_sentence makes only the first letter in the sentence or quotes capitalized. str_to_camel removes any spaces between words and capitalized the letter to have words not overlap. str_to_snake adds an underscore between words that either are filled by a space or no space but a capitalization. str_to_kebab adds a heiphen in the same way the previous function does.

## When just doing the camel, snake, and kebab functions, the last name came out weird, right? Let's fix that.

## TASK: Put the uppercase function within the camel function and run the code. Then, instead of the uppercase function, put the lowercase function within the camel function and run the code.

## ANSWER: str_to_camel(str_to_upper(case_names)) ; str_to_camel(str_to_lower(case_names))

## QUESTION: What do you notice about the two results?

## ANSWER: They are both the same.

## QUESTION: Since the last name in case_names had problems with the camel, snake, and kebab functions, is it possible to also fix the name with the snake and kebab functions as we did with the camel function in the previous task?

## ANSWER: Yes.

## Now that you've completed some examples using case_names, lets use our babyNames data frame to modify something a little more complex.

## TASK: Using the babyNames data frame, complete the following:
#(1) Create a new data frame named uppercaseBabyNames.
#(2) Select by name and year.
#(3) Mutate the name column to be labelled name_upper and use the                   uppercase function on the name column.
#(4) Select the name column once again, removing it, leaving only the               name_upper column.

## ANSWER:
uppercaseBabyNames <- babyNames %>%
  select(name, year) %>%
  mutate(name_upper = str_to_upper(name)) %>%
  select(-name)

## TASK: Using the babyNames data frame, complete the following:
#(1) Create a new data frame named oldBabyNames.
#(2) Filter by the year 1880
#(3) Mutate the name column to be labelled name_title and use the title             function on the name column.
#(4) Select the name column once again, removing it, leaving only the               name_title column.

## ANSWER:
oldBabyNames <- babyNames %>%
  filter(year == 1880) %>%
  mutate(name_title = str_to_title(name)) %>%
  select(-name)

## Good work! You've learned how to use some case changing functions within simple values as well as data frames!

## These examples might not be the most practical, but the option to organize entire data frames within simple functions justifies its use in a more practical sense.