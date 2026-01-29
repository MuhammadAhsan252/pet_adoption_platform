class Avo::Resources::Blog < Avo::BaseResource
  self.find_record_method = -> {
    if id.is_a?(Array)
      query.where(slug: id)
    else
      # We have to add .friendly to the query
      query.friendly.find id
    end
  }
  self.includes = []
  self.search = {
    query: -> {
      query.ransack(title_cont: params[:q]).result(distinct: false)
    }
  }

  def fields
    field :id, as: :id
    field :title, as: :text, required: true
    field :category, as: :select, options: [ "General", "Plant Disease", "Pest Control", "Soil Health", "Crop Management", "Irrigation", "Fertilizer" ]
    field :tags, as: :tags, hide_on: :index
    field :cover_image, as: :file, is_image: true, hide_on: :index
    field :content, as: :trix, attachment_key: :trix_attachments, html: {
      edit: {
        wrapper: {
          style: "display: block;"

        }
      },
      show: {
        wrapper: {
          style: "display: block;"
        }
      }
    }
  end
end
