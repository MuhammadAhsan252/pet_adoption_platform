class Avo::Resources::Pet < Avo::BaseResource
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
    field :id, as: :id
    field :name, as: :text
    field :category, as: :select, options: ['Dog', 'Cat']
    field :size, as: :select, options: ['Small', 'Medium', 'Large']
    field :age, as: :select, options: ['Baby', 'Young', 'Adult', 'Senior']
    field :gender, as: :select, options: ['Male', 'Female']
    field :breed, as: :text
    field :color, as: :text
    field :spayed_neutered, as: :boolean
    field :house_trained, as: :boolean
    field :declawed, as: :boolean
    field :special_needs, as: :boolean
    field :shots_current, as: :boolean
    field :children, as: :boolean
    field :cats, as: :boolean
    field :dogs, as: :boolean
    field :tags, as: :tags, hide_on: :index
    field :images, as: :files, hide_on: :index
    field :organization, as: :belongs_to
  end
end
