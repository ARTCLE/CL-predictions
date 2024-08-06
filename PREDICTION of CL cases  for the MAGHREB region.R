# Chemin vers le répertoire contenant les fichiers CSV des données climatiques de différentes villes
directory <- "C:\\Users\\HONOR-ECC\\Desktop\\Cordex\\Tunisie\\TN\\prediction climatique des villes TN"
# Liste pour stocker les résultats de prédiction de chaque ville
predictions <- list()

# Loop à travers tous les fichiers CSV des différentes villes
for (city_file in list.files(directory, pattern = "*.csv", full.names = TRUE)) {
  
  # Charger les données de la ville
  city_data <- read.csv(city_file)
  
  # Effectuer les prédictions pour cette ville en utilisant le modèle GAM existant
  predicted_cases <- predict(GAM_02, newdata = city_data, type = "response")
  
  # Extraire le nom de la ville du nom du fichier
  city_name <- gsub(".csv$", "", basename(city_file))
  
  # Stocker les prédictions dans la liste des résultats avec le nom de la ville comme clé
  predictions[[city_name]] <- data.frame(Date = city_data$Date, CL_cases_predicted = predicted_cases)
}

# Combinez toutes les prédictions dans un seul cadre de données
combined_predictions <- do.call(rbind, predictions)

# Enregistrer les prédictions dans un fichier CSV
write.csv(combined_predictions, "predictions.csv", row.names = FALSE)

head(combined_predictions)




###########################################################
# Charger les packages nécessaires
library(dplyr)
library(tidyr)

# Créer une variable "City" dans combined_predictions
combined_predictions$City <- gsub("_merged.*", "", rownames(combined_predictions))

# Convertir le cadre de données en format large avec les noms de ville en tant qu'en-têtes de colonne
combined_predictions_wide <- combined_predictions %>%
  spread(key = City, value = CL_cases_predicted)

view(combined_predictions_wide)

##### enlever les nas
combined_predictions_wide = na.omit(combined_predictions_wide)


# Enregistrer les prédictions dans un fichier CSV avec le nouveau format
write.csv(combined_predictions_wide, "combined_predictions_wide.csv", row.names = FALSE)


getwd()









