**Arktanyl** is the database format of **Ykani**

It consists of two sections: a **Header** and the **Data**

The **Header** consists of the first three lines of a *.ark* file, and denote the character sequences which will be used to split the text in the data section

The first line indicates the **K/V Separator**, which separates Keys from their respective Values. Each Key/Value pair is called a **Property**

The second line indicates the **Minor Separator**, which separates different properties from each other inside a single **Entry**

The third line indicates the **Major Separator**, which separates distinct Entries from one another

The **Data** section begins on the fourth line, containing data formattted according to the header section.

As of now, there is no escape character for Arktanyl, meaning that the separator sequences cannot be escaped and will be treated as separators in every instance they occur.

