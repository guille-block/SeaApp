# Welcome to the sea app analyzer

## Objective: 

Utilize an interactive dashboard to find the longest route between two signals gotten from an specific ship in its trip.

# How to use it:

There are a couple of considerations to take in place. First, data has not been upload by github 100MB restriction and because of issues runned by GIT Bash Large files system.

To utilize the app, access the ships.csv and load it in the cloned repository with the following path "./www/inputs/"

Then simply run in your RStudio console:

```{js}
runApp()
```
# Considerations

The app has been deployed to shinyapp.io and you can acess it through <link>https://seaportanalyzer.shinyapps.io/SeaAppAnalyzer/</link>. Shinyapp has some limitations and 
only allows you to utilize 1 GB of memory so for that reason it disconnects from server eventually. 
