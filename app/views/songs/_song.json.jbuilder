json.extract! song, :id, :name, :length, :artist, :created_at, :updated_at
json.url song_url(song, format: :json)
