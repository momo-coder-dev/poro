module EventsHelper
  COLUMNS = {
    name: "Nom",
    start_at: "Date de début",
    end_at: "Date de fin",
    venue: "Lieu",
    category: "Catégorie",
    status: "Statut",
    access_visibility: "Visibilité"
  }

  CREATE_FIELDS = {
    name: { type: :text, placeholder: "Name", label: "Name", options: {} },
    description: { type: :text_area, placeholder: "description", options: {} },
    cover_image: { type: :image, placeholder: "Image", options: {} },
    category: { type: :select, placeholder: "Category", options: { collection: Event.categories } },
    start_at: { type: :date, placeholder: "Start At" },
    end_at: { type: :date, placeholder: "End At" },
    venue: { type: :nested_association,
      options: {
        model: Venue,
        fields: {
          name: { type: :text, placeholder: "Nom du lieu" },
          address: { type: :text, placeholder: "Adresse" },
          longitude: { type: :text, placeholder: "Longitude" },
          latitude: { type: :text, placeholder: "Latitude" }
        }
      }
    },
    ticket_types: { type: :nested_association,
      options: {
        model: TicketType,
        fields: {
          name: { type: :text, placeholder: "Nom du billet" },
          price: { type: :number, placeholder: "Prix" },
          quantity: { type: :number, placeholder: "Quantité" }
        }
      }
    },
    status: { type: :select, placeholder: "Status", options: { collection: Event.statuses } },
    access_visibility: { type: :select, placeholder: "access_visibility", options: { collection: Event.access_visibilities } },
    entry_requirement: { type: :text_area, placeholder: "entry_requirement", options: {} }
  }

  ACTIONS = [ :show, :edit, :destroy ]
end
