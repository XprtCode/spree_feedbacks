namespace :feedbacks do
  task load: :environment do
    effects = [
      'hungry', 'relaxed', 'sleepy', 'chatty', 'euphoric', 'uplifeted',
      'focused', 'energetic', 'aroused', 'creative', 'tingly', 'giggly',
      'insomnia', 'wigged out'
    ]

    tastes = [
      'citrus', 'berry', 'diesel', 'honey', 'earthy', 'chemical', 'spicy',
      'floral', 'fruity', 'pungent', 'sweet', 'skunk'
    ]

    vibes = [
      'run', 'thinking', 'nap', 'work', 'eat', 'wunderlust', 'read', 'create',
      'movies', 'social', 'anti social', 'dance', 'heavy', 'outdoors', 'sexy'
    ]

    effects.each do |effect|
      Spree::Effect.find_or_create_by(name: effect)
    end

    tastes.each do |taste|
      Spree::Taste.find_or_create_by(name: taste)
    end

    vibes.each do |vibe|
      Spree::Vibe.find_or_create_by(name: vibe)
    end
  end
end
