class RenamePasswordDigestToEncryptedPasswordInUsers < ActiveRecord::Migration[8.0]
  def change
    rename_column :users, :password_digest, :encrpyted_passwrod
  end
end
