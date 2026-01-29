class Avo::Resources::Organization < Avo::BaseResource
  self.find_record_method = -> {
    if id.is_a?(Array)
      query.where(slug: id)
    else
      # We have to add .friendly to the query
      query.friendly.find id
    end
  }
  self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :name, as: :text
    field :address, as: :text
    field :city, as: :select, options: CS.states(:us).keys.flat_map { |state| CS.cities(state, :us) }.uniq.sort!
    field :state, as: :select, options: CS.states(:us).map { |_, v| [v, v] }
    field :country, as: :select, options: ['US']
    field :postal_code, as: :number
    field :phone, as: :text
    field :email, as: :text
    field :logo, as: :file
  end
end
