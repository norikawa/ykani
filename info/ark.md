**Arktanyl** is the data storage format of **Ykani**

It consists of up to three sections: an optional **Type Indicator**, a **Header** and the **Data**

If the first line starts with either an **M** or an **S**, it is truncated down to that first letter, and is the **Type Indicator**. Otherwise, there is no **Type Indicator**, and the first line begins the **Header** instead.

The **Type Indicator** indicates the type of the file, either a standard Arktanyl file (for **S**) or an ArktanylDB file (for **M**). The default case (for no indicator) is a standard Arktanyl file. 

The **Header** is structured as follows:

The first line indicates the **K/V Delimiter**, which separates Keys from their respective Values. Each Key/Value pair is called a **Property**.

The second line indicates the **Minor Delimiter**, which separates different properties from each other inside a single **Entry**.

The third line indicates the **Major Delimiter**, which separates distinct Entries from one another within a **Table**.

ArktanylDB files have two additional lines after the **Major Delimiter**:

The fourth line indicates the **Table Delimiter**, which separates distinct Tables from one another within a **Database**.

The fifth line indicates the **Label Marker**, which is used to indicate the end of a line which names a Table.

Table names are known as **Labels**, and are either taken from the filename (for standard Arktanyl files), or from marker lines (for ArktanylDB files).

Database names are known as **Titles**, and are taken from the filename.

Both Labels and Titles are cast to all lowercase before use.

The **Data** section begins on the line after the header, containing data formattted according to the header section.

As of now, there is no escape character for Arktanyl, meaning that the delimiter sequences cannot be escaped and will be treated as delimiter in every instance they occur.

