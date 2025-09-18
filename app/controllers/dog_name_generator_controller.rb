class DogNameGeneratorController < ApplicationController
  layout false
  def index
  end
  
  def build_prompt
    category    = params[:category].presence || "any style"
    gender      = params[:gender] == "any" ? "suitable for any gender" : params[:gender]
    size        = params[:size] == "any" ? "any size dog" : "#{params[:size]} sized dog"
    personality = params[:personality] == "any" ? "any personality" : params[:personality]
    breed       = params[:breed].presence
    theme       = params[:theme].presence

    prompt = <<~PROMPT
      Generate 8 creative and unique dog names with the following criteria:
      - Style: #{category}
      - Gender: #{gender}
      - Size: #{size}
      - Personality: #{personality}
    PROMPT

    prompt += "- Breed: #{breed.tr('-', ' ')}\n" if breed
    prompt += "- Theme: #{theme}\n" if theme

    prompt += <<~PROMPT

      For each name, provide:
      1. The name itself
      2. A brief 1-2 sentence explanation of why this name fits the criteria
      3. Any interesting meaning or background

      Format your response as a JSON array with objects containing "name", "description", and "meaning" fields. 
      Make sure the names are diverse and creative, avoiding overly common names like Max, Buddy, Bella unless they have a special twist that fits the criteria perfectly.
    PROMPT

    render json: { prompt: prompt }
  end
end