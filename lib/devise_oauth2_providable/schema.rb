require 'devise/schema'

module Devise
  module Oauth2Providable
    module Schema
      def self.up(migration)
        migration.create_table :oauth2_clients do |t|
          t.string :name
          t.string :redirect_uri
          t.string :website
          t.string :identifier
          t.string :secret
          t.timestamps
        end
        migration.add_index :oauth2_clients, :identifier, :unique => true

        migration.create_table :access_tokens do |t|
          t.belongs_to :user, :oauth2_client, :refresh_token
          t.string :token
          t.datetime :expires_at
          t.timestamps
        end
        migration.add_index :access_tokens, :token, :unique => true
        migration.add_index :access_tokens, :expires_at
        migration.add_index :access_tokens, :user_id
        migration.add_index :access_tokens, :oauth2_client_id

        migration.create_table :refresh_tokens do |t|
          t.belongs_to :user, :oauth2_client
          t.string :token
          t.datetime :expires_at
          t.timestamps
        end
        migration.add_index :refresh_tokens, :token, :unique => true
        migration.add_index :refresh_tokens, :expires_at
        migration.add_index :refresh_tokens, :user_id
        migration.add_index :refresh_tokens, :oauth2_client_id

        migration.create_table :authorization_codes do |t|
          t.belongs_to :user, :oauth2_client
          t.string :token
          t.datetime :expires_at
          t.string :redirect_uri
          t.timestamps
        end
        migration.add_index :authorization_codes, :token, :unique => true
        migration.add_index :authorization_codes, :expires_at
        migration.add_index :authorization_codes, :user_id
        migration.add_index :authorization_codes, :oauth2_client_id
      end

      def self.down(migration)
        migration.drop_table :refresh_tokens
        migration.drop_table :access_tokens
        migration.drop_table :authorization_codes
        migration.drop_table :oauth2_clients
      end
    end
  end
end

