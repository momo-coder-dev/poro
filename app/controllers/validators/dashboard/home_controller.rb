class Validators::Dashboard::HomeController < Validators::BaseController

    def index
      @validator = current_validator
      # Afficher la liste des événements ou statistiques
    end
end