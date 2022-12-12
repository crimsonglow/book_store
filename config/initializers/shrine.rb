require 'shrine'

if Rails.env.test?
  require 'shrine/storage/memory'
  Shrine.storages = {
    cache: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new
  }
else
  require "shrine/storage/s3"
  s3_options = {
    bucket:            "book-store-zs",
    access_key_id:     "AKIATNY3W3ISJJQXHC45",
    secret_access_key: "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",
    region:            "us-east-1",
  }
  Shrine.storages = {
    cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options),
    store: Shrine::Storage::S3.new(prefix: "store", **s3_options)
  }
end

Shrine.plugin :default_url
Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for retaining the cached file across form redisplays
Shrine.plugin :restore_cached_data # re-extract metadata when attaching a cached file
