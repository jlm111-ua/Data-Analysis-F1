# Data-Analysis-F1

This is a personal work about the data analysis of the different teams and drivers in F1. With this code is possible to collect data in an Excel sheet, clean the data with Scala in Apache Spark, in a Web-based notebook called Zeppelin that enables data-driven, interactive data analytics and collaborative documents with SQL, Scala and more. In addition, the data processed will be send to a database in MySQL Worbench, a tool to store the data. For the graphic visualizations of the data are available in PowerBI, with different dashboards to show the results of the data.

## ⭐ Repository Guide

The repository is organized in different folders with the different parts of the data analysis process. 
First of all, there is a folder called "Diseños_MySQL" where you can find the differents steps of the models to create the database on MySQL Workbench: the conceptual model and the physical and logical schemas. 

In the "Download_CSV_API" folder, there is a script in Python where can be found the script to get the data from the API called "FastF1". The script should be modified to change the path where the Excel sheet will be stored and obtain the different years. 

The other folder called "ETL_Zeppelin(Spark_Scala)" have a notebook with the clean phase of the data stored on the excel sheet. The code is in the programming language Scala and the it was executed in Zeppelin, with the installation of Spark. 

For the visualizations there are two folders. In the "Pentaho_Schema_Workbench" there is a representation of the Mondrian cube, with needs to install the framework of Pentaho_Schema_Workbench for watch it. The other visualization can be displayed with PowerBI and is in the folder "Visualizaciones_PowerBI". In the file, there are a lot of examples showing different data about the drivers, Grand Prix, Lap time, Speed ....

In addition, there is a memory with all the process along the project, with the details of the data and explanations of the steps and problems in the process. The memory is in Spanish.
