#========= Information sujet ===============

# Thematique: Analyse vole 2023
# Auteur: Bel Eric
# Date creation: 19/09/2026
# Source d'inforamation: nycflights2023.txt

#=======================================================
#====== visualisation et import des donnees================================

readLines(con= "../Data/nycflights2023.txt", 
          n=10)

dataset = read.table(file = "../Data/nycflights2023.txt", 
                     header =  TRUE, 
                     sep = "\t",
                     dec = ".")
head(dataset, n=5)
str(dataset)
dataset1=dataset  #la copie de datasets en dataset1 pour eviter l'ecrasement des donner dans le code en cas d'erreur
#tail(dataset)  permet d'afficher les dernieres ligne d'un dataframe 

#======================================================
#=======================conversion du types des donnees ============

dataset1$carrier=with(dataset1, 
                      factor(carrier))
dataset1$origin=with(dataset1, 
                     factor(origin))
dataset1$dest=with(dataset1, 
                   factor(dest))
dataset1$name=with(dataset1, 
                   factor(name))

str(dataset1)



#===================convertion des donnees ============

#dataset1$distance= dataset1$distance*1609.34 # conversion du mile en mettre 
#dataset1$dewp =(dataset1$dewp-32)*(5/9) # conversion en degre celsuce
#head(dataset1)
#dataset=dataset1

within(dataset1,{
                distance=distance*1609.34
                dewp = (dewp-32)*(5/9)
                }) |> head()
#within permet de faire plusieur operation de creation ou de modification dans une colone ou plusieur colones 

#=====================================================
#===================creation des variable ============
#================delay_dep===========================================
# ici, nous allons nous referer a la colone dep_delay(en min) pour creer la colone 
#delay_dep( retard depart.) on supose pour cela que les lignes de dep_delay sans donnee 
# sont considerer comme des depart sans retard( dep_delay = 0)
#======== conversion des ligne vide a 0 =========================
                #j'ai confondu = et ==, et apres il fallait que j'utilise la fonction is.na() pour trouver les champs vide 
dataset1$dep_delay= with(dataset1,
                         ifelse(is.na(dep_delay), 
                                0, 
                                dep_delay ) 
                         )
#A present, j'ai un soucis qui est que j'ai dans mes donner des nombre negatif. faut il les considerer comme un retard ou quoi ? 
#==========================================================================
#======================= delay_arr ===========
dataset1$arr_delay= with(dataset1,
                         ifelse(is.na(arr_delay), 
                                0, 
                                arr_delay ) 
                         )

