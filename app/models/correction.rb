class Correction < ActiveRecord::Base
  # enum action: {modification: 0, suppression: 1, insertion: 2, remplacement: 3, commentaire: 4}
  # enum etat: {attente: 0, corrige: 1, verifie: 2}
  validates_presence_of :avant,:description,:project_id, :user_id, :ligne, :page, :demande, :action
  belongs_to :project

end
