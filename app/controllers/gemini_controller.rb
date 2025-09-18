# app/controllers/gemini_controller.rb
class GeminiController < ApplicationController
  protect_from_forgery with: :null_session  # allow API calls from JS

  def generate
    prompt = params[:prompt]

    api_key = ENV['GOOGLE_API_KEY']
    url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=#{api_key}"

    response = Faraday.post(url) do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = {
        contents: [
          { parts: [{ text: prompt }] }
        ],
        generationConfig: {
          temperature: 0.9,
          topK: 40,
          topP: 0.95,
          maxOutputTokens: 2048
        }
      }.to_json
    end

    if response.success?
      data = JSON.parse(response.body)
      text = data.dig("candidates", 0, "content", "parts", 0, "text")
      render json: { text: text }
    else
      error_data = JSON.parse(response.body) rescue {}
      render json: { error: error_data["error"] || "Failed to generate" }, status: :unprocessable_entity
    end
  end
end
