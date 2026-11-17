;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SYSTEME EXPERT MIS À JOUR AVEC DETAILS COMPLETS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deftemplate plant (slot name))
(deftemplate symptom (slot name) (slot value))

(deftemplate diagnosis
   (slot disease)
   (slot advice)
   (slot description)
   (slot symptoms_desc)
   (slot reasoning)
   (slot danger_level)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; OLIVIER
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule olivier-xylella
   (plant (name "Olivier"))
   (symptom (name "jaune-olive") (value "oui"))
   (symptom (name "seche-olive") (value "oui"))
   (symptom (name "deperissement-olive") (value "oui"))
   =>
   (assert (diagnosis
      (disease "Xylella fastidiosa")
      (advice "Éliminez les arbres infectés et contrôlez les insectes vecteurs.")
      (description "Bactérie dangereuse bloquant la circulation de la sève de l’olivier.")
      (symptoms_desc "Feuilles brûlées, jaunissement, dessèchement des rameaux.")
      (reasoning "Les symptômes correspondent aux règles de diagnostic définies dans la base CLIPS.")
      (danger_level "Élevé")
   ))
)

(defrule olivier-spilocaea
   (plant (name "Olivier"))
   (symptom (name "tache-noire-olive") (value "oui"))
   (symptom (name "perte-feuilles-olive") (value "oui"))
   =>
   (assert (diagnosis
      (disease "Spilocaea oleaginea")
      (advice "Appliquez un fongicide et taillez les branches infectées.")
      (description "Champignon responsable de la maladie de l’œil de paon chez l’olivier.")
      (symptoms_desc "Taches circulaires sombres et chute progressive des feuilles.")
      (reasoning "Le motif des taches typiques correspond aux règles du système expert.")
      (danger_level "Moyen")
   ))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PALMIER
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule palmier-graphiola
   (plant (name "Palmier"))
   (symptom (name "bosses-palmier") (value "oui"))
   (symptom (name "deformation-palmier") (value "oui"))
   =>
   (assert (diagnosis
      (disease "Graphiola phoenicis")
      (advice "Ramassez et détruisez les feuilles infectées.")
      (description "Maladie fongique produisant de petites pustules sur les feuilles du palmier.")
      (symptoms_desc "Petites pustules noires et déformation du limbe foliaire.")
      (reasoning "Correspondance directe avec la règle Graphiola du système expert.")
      (danger_level "Faible")
   ))
)

(defrule palmier-fusariose
   (plant (name "Palmier"))
   (symptom (name "fletrissement-palmier") (value "oui"))
   (symptom (name "decoloration-collet-palmier") (value "oui"))
   =>
   (assert (diagnosis
      (disease "Fusariose du collet")
      (advice "Utilisez des semences certifiées et appliquez un traitement du sol.")
      (description "Champignon affectant la base de la tige et les racines.")
      (symptoms_desc "Flétrissement rapide et racines brunâtres nécrosées.")
      (reasoning "Les symptômes correspondent à la règle spécifique de fusariose du collet.")
      (danger_level "Élevé")
   ))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MENTHE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule menthe-oidium
   (plant (name "Menthe"))
   (symptom (name "poudre-blanche-menthe") (value "oui"))
   (symptom (name "tiges-fragiles-menthe") (value "oui"))
   =>
   (assert (diagnosis
      (disease "Oïdium")
      (advice "Espacez les plants et appliquez un fongicide adapté.")
      (description "Champignon très fréquent formant une poudre blanche sur les feuilles.")
      (symptoms_desc "Poudre blanche et déformation des jeunes pousses.")
      (reasoning "La présence de mycélium blanchâtre valide ce diagnostic.")
      (danger_level "Moyen")
   ))
)

(defrule menthe-fusariose
   (plant (name "Menthe"))
   (symptom (name "fletrissement-menthe") (value "oui"))
   (symptom (name "decoloration-menthe") (value "oui"))
   =>
   (assert (diagnosis
      (disease "Fusariose")
      (advice "Effectuez une rotation des cultures et utilisez des semences résistantes.")
      (description "Maladie fongique affectant les tissus internes de la plante.")
      (symptoms_desc "Jaunissement rapide et flétrissement permanent.")
      (reasoning "Les symptômes correspondent aux règles de détection dans la base CLIPS.")
      (danger_level "Élevé")
   ))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; REGLE PAR DÉFAUT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule no-diagnosis
   (plant (name ?p))
   (not (diagnosis (disease ?d)))
   =>
   (assert (diagnosis
      (disease "Inconnu")
      (advice "Aucun diagnostic certain. Consultez un spécialiste.")
      (description "Aucune maladie correspondante dans la base de connaissances.")
      (symptoms_desc "Les symptômes ne correspondent à aucune règle connue.")
      (reasoning "Aucune règle activée dans le moteur d'inférence.")
      (danger_level "Non défini")
   ))
)
